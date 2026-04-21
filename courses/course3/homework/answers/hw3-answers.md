# HW3 Answer Key: RAG Pipeline Construction

## Part 1: Document Loading & Chunking (25 pts)

```python
# document_pipeline.py
from langchain_community.document_loaders import PyPDFLoader, TextLoader, DirectoryLoader, WebBaseLoader
from langchain_text_splitters import (
    RecursiveCharacterTextSplitter, TokenTextSplitter, MarkdownHeaderTextSplitter
)
from pathlib import Path
from datetime import datetime

def load_and_chunk_documents(source_dir: str) -> dict:
    # Load all documents
    all_docs = []
    source = Path(source_dir)
    
    for pdf in source.glob("*.pdf"):
        loader = PyPDFLoader(str(pdf))
        all_docs.extend(loader.load())
    
    for txt in source.glob("*.txt"):
        loader = TextLoader(str(txt))
        all_docs.extend(loader.load())
    
    md_docs = []
    for md in source.glob("*.md"):
        loader = TextLoader(str(md))
        md_docs.extend(loader.load())
    all_docs.extend(md_docs)
    
    # Strategy 1: Recursive character
    recursive_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)
    recursive_chunks = recursive_splitter.split_documents(all_docs)
    
    # Strategy 2: Token-based
    token_splitter = TokenTextSplitter(chunk_size=256, chunk_overlap=32)
    token_chunks = token_splitter.split_documents(all_docs)
    
    # Strategy 3: Markdown headers (only for .md files)
    md_splitter = MarkdownHeaderTextSplitter(
        headers_to_split_on=[("#", "h1"), ("##", "h2"), ("###", "h3")]
    )
    markdown_chunks = []
    for doc in md_docs:
        splits = md_splitter.split_text(doc.page_content)
        markdown_chunks.extend(splits)
    
    avg_recursive = sum(len(c.page_content) for c in recursive_chunks) / max(len(recursive_chunks), 1)
    avg_token = sum(len(c.page_content) for c in token_chunks) / max(len(token_chunks), 1)
    
    return {
        "recursive": recursive_chunks,
        "token": token_chunks,
        "markdown": markdown_chunks,
        "stats": {
            "total_docs_loaded": len(all_docs),
            "recursive_chunks": len(recursive_chunks),
            "token_chunks": len(token_chunks),
            "markdown_chunks": len(markdown_chunks),
            "avg_chunk_size_recursive": round(avg_recursive, 1),
            "avg_chunk_size_token": round(avg_token, 1),
        }
    }


def load_web_documents(urls: list[str]) -> list:
    splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)
    all_chunks = []
    
    for url in urls:
        try:
            loader = WebBaseLoader(url)
            docs = loader.load()
            for doc in docs:
                doc.metadata["source_url"] = url
                doc.metadata["loaded_at"] = datetime.now().isoformat()
            chunks = splitter.split_documents(docs)
            all_chunks.extend(chunks)
        except Exception as e:
            print(f"Warning: Failed to load {url}: {e}")
    
    return all_chunks
```

**Grading notes:**
- -5 if only one splitter implemented
- -3 if metadata not preserved through splitting
- -3 if no error handling in web loader

---

## Part 2: Vector Store Comparison (30 pts)

```python
# vector_stores.py
from langchain_openai import OpenAIEmbeddings
from langchain_community.vectorstores import Chroma, FAISS
import time

def create_chroma_store(documents: list, collection_name: str = "hw3") -> Chroma:
    embeddings = OpenAIEmbeddings(model="text-embedding-3-small")
    store = Chroma.from_documents(
        documents=documents,
        embedding=embeddings,
        collection_name=collection_name,
        persist_directory="./chroma_db"
    )
    return store


def create_faiss_store(documents: list) -> FAISS:
    embeddings = OpenAIEmbeddings(model="text-embedding-3-small")
    store = FAISS.from_documents(documents=documents, embedding=embeddings)
    store.save_local("./faiss_index")
    return store


def compare_retrieval(query: str, chroma_store, faiss_store, k: int = 5) -> dict:
    # Chroma retrieval
    start = time.time()
    chroma_results = chroma_store.similarity_search(query, k=k)
    chroma_latency = (time.time() - start) * 1000
    
    # FAISS retrieval
    start = time.time()
    faiss_results = faiss_store.similarity_search(query, k=k)
    faiss_latency = (time.time() - start) * 1000
    
    # Calculate overlap
    chroma_contents = set(d.page_content[:100] for d in chroma_results)
    faiss_contents = set(d.page_content[:100] for d in faiss_results)
    overlap = len(chroma_contents & faiss_contents) / max(len(chroma_contents | faiss_contents), 1)
    
    return {
        "query": query,
        "chroma": {
            "results": [{"content": d.page_content[:200], "metadata": d.metadata} for d in chroma_results],
            "latency_ms": round(chroma_latency, 2),
        },
        "faiss": {
            "results": [{"content": d.page_content[:200], "metadata": d.metadata} for d in faiss_results],
            "latency_ms": round(faiss_latency, 2),
        },
        "overlap_pct": round(overlap * 100, 1),
    }


def similarity_with_filters(store: Chroma, query: str, filters: dict) -> list:
    results = store.similarity_search(query, k=5, filter=filters)
    return results
```

---

## Part 3: Complete RAG Chain (30 pts)

```python
# rag_chain.py
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.runnables import RunnablePassthrough, RunnableLambda
from langchain_core.output_parsers import StrOutputParser
from langchain_openai import ChatOpenAI

def format_docs(docs: list) -> str:
    formatted = []
    for i, doc in enumerate(docs):
        source = doc.metadata.get("source", "unknown")
        page = doc.metadata.get("page", "N/A")
        formatted.append(f"[Source: {source}, Page {page}]\n{doc.page_content}")
    return "\n\n---\n\n".join(formatted)


def build_rag_chain(retriever):
    template = """Answer the question based only on the following context.
If you cannot answer from the context, say 'I don't have enough information to answer this question.'

Always cite your sources with [Source: filename, page X].

Context:
{context}

Question: {question}

Answer:"""
    
    prompt = ChatPromptTemplate.from_template(template)
    model = ChatOpenAI(model="gpt-4o-mini", temperature=0)
    
    chain = (
        {"context": retriever | format_docs, "question": RunnablePassthrough()}
        | prompt
        | model
        | StrOutputParser()
    )
    return chain


def build_rag_with_history(retriever):
    # Step 1: Rephrase question using history
    rephrase_template = """Given the chat history and a follow-up question, rephrase the
follow-up question to be a standalone question.

Chat History:
{chat_history}

Follow-up Question: {question}

Standalone Question:"""
    
    rephrase_prompt = ChatPromptTemplate.from_template(rephrase_template)
    model = ChatOpenAI(model="gpt-4o-mini", temperature=0)
    
    def format_history(history: list[tuple[str, str]]) -> str:
        return "\n".join([f"Human: {h}\nAI: {a}" for h, a in history])
    
    # Step 2: RAG answer
    answer_template = """Answer based on the context. Cite sources.
If you can't answer, say so.

Context: {context}
Question: {standalone_question}
Answer:"""
    
    answer_prompt = ChatPromptTemplate.from_template(answer_template)
    
    chain = (
        RunnablePassthrough.assign(
            chat_history=lambda x: format_history(x.get("chat_history", [])),
        )
        | RunnablePassthrough.assign(
            standalone_question=rephrase_prompt | model | StrOutputParser()
        )
        | RunnablePassthrough.assign(
            context=lambda x: format_docs(retriever.invoke(x["standalone_question"]))
        )
        | answer_prompt
        | model
        | StrOutputParser()
    )
    return chain
```

---

## Part 4: Evaluation (15 pts)

```python
# evaluate_rag.py
import time

def evaluate_retrieval(retriever, test_queries: list[dict]) -> dict:
    results = {"precision": [], "correctness": [], "latency": []}
    
    for tq in test_queries:
        query = tq["query"]
        expected_sources = tq.get("expected_sources", [])
        expected_phrases = tq.get("expected_answer_contains", [])
        
        start = time.time()
        docs = retriever.invoke(query)
        latency = (time.time() - start) * 1000
        results["latency"].append(latency)
        
        # Precision: how many retrieved docs are from expected sources
        if expected_sources:
            retrieved_sources = [d.metadata.get("source", "") for d in docs]
            hits = sum(1 for s in retrieved_sources if any(exp in s for exp in expected_sources))
            results["precision"].append(hits / len(docs) if docs else 0)
        
        # Correctness: check if expected phrases appear in retrieved content
        all_content = " ".join(d.page_content for d in docs).lower()
        if expected_phrases:
            phrase_hits = sum(1 for p in expected_phrases if p.lower() in all_content)
            results["correctness"].append(phrase_hits / len(expected_phrases))
    
    return {
        "avg_precision": round(sum(results["precision"]) / max(len(results["precision"]), 1), 3),
        "avg_correctness": round(sum(results["correctness"]) / max(len(results["correctness"]), 1), 3),
        "avg_latency_ms": round(sum(results["latency"]) / max(len(results["latency"]), 1), 1),
        "num_queries": len(test_queries),
    }
```
