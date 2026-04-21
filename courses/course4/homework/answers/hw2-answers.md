# HW2 Model Answers: Advanced RAG Pipeline

## Part A: Retrieval Architecture

### Hybrid Search Implementation

```python
# Dense: sentence-transformers/all-MiniLM-L6-v2 (fast, good baseline)
# Sparse: BM25 via rank_bm25 or Elasticsearch
# Fusion: Reciprocal Rank Fusion (RRF)

def hybrid_search(query, k=10, alpha=0.7):
    dense_results = vector_store.similarity_search(query, k=k*2)
    sparse_results = bm25_index.search(query, k=k*2)
    return reciprocal_rank_fusion(dense_results, sparse_results, alpha=alpha)

def reciprocal_rank_fusion(lists, alpha, k=60):
    scores = defaultdict(float)
    for rank, doc in enumerate(lists[0]):
        scores[doc.id] += alpha * (1 / (k + rank + 1))
    for rank, doc in enumerate(lists[1]):
        scores[doc.id] += (1-alpha) * (1 / (k + rank + 1))
    return sorted(scores.items(), key=lambda x: -x[1])
```

### Query Decomposition
```python
DECOMPOSE_PROMPT = """Break this complex question into simpler sub-questions.
Question: {query}
Return as JSON array of strings."""

async def decompose_and_retrieve(query):
    sub_queries = await llm.generate(DECOMPOSE_PROMPT.format(query=query))
    all_chunks = []
    for sq in sub_queries:
        all_chunks.extend(hybrid_search(sq))
    return deduplicate_and_rerank(all_chunks, query)
```

### Advanced Pattern: Corrective RAG
```python
async def corrective_rag(query, chunks):
    # Step 1: Grade each retrieved chunk for relevance
    relevant = []
    for chunk in chunks:
        grade = await llm.generate(
            f"Is this document relevant to '{query}'? "
            f"Document: {chunk.text[:500]}. Answer YES or NO with reason."
        )
        if "YES" in grade:
            relevant.append(chunk)

    # Step 2: If insufficient relevant docs, trigger web search fallback
    if len(relevant) < 2:
        web_results = await web_search(query)
        relevant.extend(web_results)

    # Step 3: Generate with verified context only
    return await generate_with_citations(query, relevant)
```

### Chunking Strategy
- **Method:** Recursive character splitting with 512 tokens, 50-token overlap
- **Justification:** Balances context preservation with retrieval precision; overlap prevents information loss at boundaries
- **Metadata:** Source document, section header, page number attached to each chunk

## Part B: Knowledge Integration

### Reranking
- Cross-encoder reranker (ms-marco-MiniLM-L-6-v2) applied after initial retrieval
- Top 20 from hybrid search → rerank → top 5 to LLM

### Citation Tracking
```python
CITE_PROMPT = """Answer using ONLY the provided sources. 
For each claim, add [Source N] inline.
Sources:
{numbered_sources}
Question: {query}"""
```

### Multi-hop: Chain sub-question answers, feeding prior answers as context for subsequent questions.

## Part C: Evaluation

| Metric | Naive RAG | Hybrid | +Rerank | +Corrective | +Decomposition |
|--------|-----------|--------|---------|-------------|----------------|
| Precision@5 | 0.52 | 0.64 | 0.71 | 0.74 | 0.78 |
| Recall@10 | 0.61 | 0.73 | 0.75 | 0.79 | 0.85 |
| MRR | 0.48 | 0.59 | 0.67 | 0.70 | 0.73 |
| Faithfulness | 0.71 | 0.74 | 0.76 | 0.83 | 0.85 |
| Latency p50 | 1.2s | 1.4s | 1.9s | 2.8s | 3.5s |
| Latency p99 | 3.1s | 3.5s | 4.2s | 6.1s | 8.2s |

**Key Findings:**
- Reranking provides best quality-per-latency improvement
- Corrective RAG most valuable for ambiguous queries (reduces hallucination significantly)
- Query decomposition critical for multi-hop but adds ~2x latency
- **Embedding comparison:** `all-MiniLM-L6-v2` (384d) vs `e5-large-v2` (1024d): e5 gives +5% recall but 3x slower indexing and 2.5x storage
