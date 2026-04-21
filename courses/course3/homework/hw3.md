# Homework 3: RAG Pipeline Construction

**Due:** End of Week 7 | **Points:** 100 | **Weight:** ~6.7% of final grade

## Objectives
- Build a complete RAG pipeline from document loading to retrieval
- Compare vector stores: ChromaDB, FAISS
- Implement different chunking and embedding strategies
- Create a retrieval chain with source attribution

---

## Part 1: Document Loading & Chunking (25 pts)

```python
# document_pipeline.py
from langchain_community.document_loaders import (
    PyPDFLoader, TextLoader, WebBaseLoader, DirectoryLoader
)
from langchain_text_splitters import (
    RecursiveCharacterTextSplitter,
    TokenTextSplitter,
    MarkdownHeaderTextSplitter
)

def load_and_chunk_documents(source_dir: str) -> dict:
    """
    Load documents from source_dir (contains .pdf, .txt, .md files).
    
    Apply THREE different chunking strategies and return results:
    
    1. RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)
    2. TokenTextSplitter(chunk_size=256, chunk_overlap=32)
    3. MarkdownHeaderTextSplitter for .md files
    
    Return: {
        "recursive": [Document, ...],
        "token": [Document, ...],  
        "markdown": [Document, ...],
        "stats": {
            "total_docs_loaded": int,
            "recursive_chunks": int,
            "token_chunks": int,
            "markdown_chunks": int,
            "avg_chunk_size_recursive": float,
            "avg_chunk_size_token": float,
        }
    }
    """
    pass

def load_web_documents(urls: list[str]) -> list:
    """
    Load content from a list of URLs using WebBaseLoader.
    Split using RecursiveCharacterTextSplitter.
    Add metadata: {"source_url": url, "loaded_at": timestamp}
    
    Handle errors gracefully (skip failed URLs, log warnings).
    """
    pass
```

**Test data:** Create a `test_docs/` directory with at least 3 sample files.

## Part 2: Vector Store Comparison (30 pts)

```python
# vector_stores.py
from langchain_openai import OpenAIEmbeddings
from langchain_community.vectorstores import Chroma, FAISS
import time

def create_chroma_store(documents: list, collection_name: str = "hw3") -> Chroma:
    """
    Create a ChromaDB vector store from documents.
    Use OpenAIEmbeddings (text-embedding-3-small).
    Persist to ./chroma_db/ directory.
    
    Return the Chroma instance.
    """
    pass

def create_faiss_store(documents: list) -> FAISS:
    """
    Create a FAISS vector store from the same documents.
    Use the same embedding model.
    Save the index to ./faiss_index/ directory.
    
    Return the FAISS instance.
    """
    pass

def compare_retrieval(query: str, chroma_store, faiss_store, k: int = 5) -> dict:
    """
    Run the same query against both stores. Compare:
    - Result relevance (top-k documents returned)
    - Latency (ms)
    - Overlap in results
    
    Return: {
        "query": str,
        "chroma": {"results": [...], "latency_ms": float},
        "faiss": {"results": [...], "latency_ms": float},
        "overlap_pct": float,  # % of docs appearing in both result sets
    }
    """
    pass

def similarity_with_filters(store: Chroma, query: str, filters: dict) -> list:
    """
    Perform similarity search with metadata filtering.
    
    Example filters: {"source_type": "pdf", "date": {"$gte": "2024-01-01"}}
    
    Use store.similarity_search(query, k=5, filter=filters)
    """
    pass
```

## Part 3: Complete RAG Chain (30 pts)

```python
# rag_chain.py
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.runnables import RunnablePassthrough
from langchain_core.output_parsers import StrOutputParser
from langchain_openai import ChatOpenAI

def build_rag_chain(retriever) -> object:
    """
    Build a complete RAG chain using LCEL:
    
    1. Retrieve relevant documents
    2. Format documents into context string
    3. Generate answer with source attribution
    
    The chain should:
    - Accept a question string
    - Retrieve top-5 documents
    - Include source metadata in the answer
    - Handle "I don't know" when context is insufficient
    
    Template:
    "Answer the question based only on the following context.
     If you cannot answer from the context, say 'I don't have enough
     information to answer this question.'
     
     Always cite your sources with [Source: filename, page X].
     
     Context: {context}
     Question: {question}
     Answer:"
    """
    pass

def format_docs(docs: list) -> str:
    """
    Format retrieved documents into a context string.
    Include metadata (source, page number) with each chunk.
    """
    pass

def rag_with_history(retriever) -> object:
    """
    Extend the RAG chain to support conversation history.
    
    Use RunnablePassthrough.assign() to inject chat history.
    The chain should rephrase the question using history context
    before retrieving, then answer.
    
    Input: {"question": str, "chat_history": list[tuple[str,str]]}
    """
    pass
```

## Part 4: Evaluation (15 pts)

```python
# evaluate_rag.py

def evaluate_retrieval(retriever, test_queries: list[dict]) -> dict:
    """
    Evaluate retrieval quality on test queries.
    
    test_queries format:
    [
        {"query": "What is X?", "expected_sources": ["doc1.pdf"], "expected_answer_contains": ["key phrase"]},
        ...
    ]
    
    Calculate:
    - Retrieval precision (% of retrieved docs that are relevant)
    - Answer correctness (does answer contain expected phrases)
    - Average latency
    
    Return evaluation report as dict.
    """
    pass
```

---

## Rubric

| Component | Points | Criteria |
|-----------|--------|----------|
| Document loading & chunking | 25 | 3 strategies implemented, stats correct, error handling |
| Vector store comparison | 30 | Both stores work, comparison metrics calculated, filtering works |
| RAG chain | 30 | LCEL chain works, source attribution, history support |
| Evaluation | 15 | Metrics calculated, test queries provided |

## Submission
Push to `hw3/` with test documents, working code, and a comparison report in README.
