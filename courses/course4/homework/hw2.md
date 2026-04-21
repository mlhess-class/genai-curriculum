# Homework 2: Advanced RAG Pipeline

**GENAI 401 — Advanced AI Systems & Architecture**
**Assigned:** Week 4 | **Due:** Week 7 | **Points:** 100

## Overview

Build an advanced RAG pipeline that goes beyond naive retrieval. Your system must handle multi-hop reasoning, hybrid search, and adaptive retrieval strategies over a provided corpus of technical documentation.

## Requirements

### Part A: Retrieval Architecture (30 pts)

1. Implement hybrid search combining dense embeddings + sparse retrieval (BM25)
2. Add a query rewriting/decomposition step for complex questions
3. Implement at least one advanced pattern:
   - Self-RAG (retrieval-augmented generation with self-reflection)
   - Corrective RAG (verify retrieval relevance before generation)
   - Adaptive RAG (route between retrieval strategies based on query type)
4. Document your chunking strategy with justification

### Part B: Knowledge Integration (30 pts)

1. Process the provided corpus (500+ documents) into your retrieval system
2. Implement metadata filtering and re-ranking (e.g., Cohere reranker, cross-encoder)
3. Add citation tracking — every generated claim must reference source chunks
4. Handle multi-hop questions requiring synthesis across 3+ documents

### Part C: Evaluation & Benchmarking (40 pts)

1. Evaluate on the provided question set (50 questions with ground truth)
2. Report: precision@k, recall@k, MRR, answer faithfulness, answer relevance
3. Ablation study: measure impact of each component (rewriting, reranking, hybrid search)
4. Compare at least 2 embedding models and analyze tradeoffs
5. Latency analysis with p50/p95/p99 breakdown

## Rubric

| Criteria | Excellent (90-100%) | Good (70-89%) | Needs Work (<70%) |
|----------|-------------------|---------------|-------------------|
| Retrieval | Hybrid + advanced pattern working well | Basic hybrid search | Single retrieval method |
| Integration | Citations, reranking, multi-hop all working | Most components working | Major gaps |
| Evaluation | Full metrics, ablation, embedding comparison | Basic metrics | Missing key analysis |
| Code Quality | Clean, documented, reproducible | Working with minor issues | Hard to run or understand |

## Submission

- GitHub repo with setup instructions
- Evaluation report (PDF, max 6 pages)
- Notebook showing retrieval examples and metrics
