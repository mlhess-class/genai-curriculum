# GENAI 301: Building with LangChain

## Course Information

| Field | Detail |
|---|---|
| **Course Number** | GENAI 301 |
| **Title** | Building with LangChain |
| **Credits** | 3 |
| **Prerequisites** | GENAI 201 |
| **Format** | Lecture + Lab (2 hrs lecture, 2 hrs lab per week) |

## Course Description

Students transition from no-code automation to code-based AI application development using Python and LangChain. The first three weeks establish Python fundamentals sufficient for AI development; students then progress through the LangChain framework—learning to compose chains, build agents, manage conversational memory, and implement Retrieval-Augmented Generation (RAG) with vector databases. Students build progressively complex AI applications culminating in a fully functional RAG-powered assistant. Emphasis is placed on understanding architectural decisions, debugging AI applications, and writing maintainable, well-structured code. Prior programming experience is helpful but not required.

## Learning Objectives

Upon successful completion, students will be able to:

1. Write Python programs that use variables, functions, control flow, file I/O, and package management to build AI applications.
2. Explain the LangChain architecture including models, prompts, chains, agents, memory, and retrievers and select appropriate components for given use cases.
3. Compose LangChain chains using LCEL (LangChain Expression Language) to build multi-step AI processing pipelines.
4. Implement tool-using agents that can plan, reason, and execute actions using external tools and APIs.
5. Build conversational applications with appropriate memory strategies (buffer, summary, vector-backed) for context management.
6. Design and implement RAG systems that retrieve relevant documents from vector databases to ground LLM responses in source material.
7. Configure and query vector databases (ChromaDB, Pinecone) including document chunking, embedding generation, and similarity search.
8. Debug, test, and iterate on LangChain applications using tracing, logging, and evaluation techniques.

## Week-by-Week Syllabus

| Week | Topic | Lab Activity |
|---|---|---|
| 1 | **Python Fundamentals I** — Variables, data types, strings, lists, dictionaries, control flow, functions | Set up Python environment (VS Code, venv); write basic scripts; complete coding exercises |
| 2 | **Python Fundamentals II** — File I/O, error handling, pip/packages, virtual environments, working with JSON and APIs | Build a script that calls an AI API, processes the response, and writes results to a file |
| 3 | **Python Fundamentals III** — Classes (basics), list comprehensions, f-strings, async intro, environment variables, project structure | Refactor previous scripts into a well-structured project with .env config |
| 4 | **Introduction to LangChain** — Architecture overview, models (ChatOpenAI, ChatAnthropic), prompt templates, output parsers | Install LangChain; make first LLM calls; parse structured output from models |
| 5 | **Chains & LCEL** — LangChain Expression Language, composing chains, RunnablePassthrough, RunnableLambda, sequential and parallel chains | Build a multi-step chain: analyze text → extract entities → generate summary |
| 6 | **Advanced Chains** — Branching (RunnableBranch), fallbacks, batch processing, streaming, chain debugging with LangSmith | Create a document processing pipeline with routing, fallback models, and streaming output |
| 7 | **Agents I — Fundamentals** — ReAct pattern, tool creation, AgentExecutor, built-in tools (search, calculator, code interpreter) | Build an agent that can search the web, do math, and answer complex questions |
| 8 | **Midterm Review & Exam** | Midterm: build a LangChain application from a specification |
| 9 | **Agents II — Custom Tools & Planning** — Custom tool creation, structured tools, agent types, planning strategies, agent limitations | Create an agent with custom tools that interact with a database and external APIs |
| 10 | **Memory & Conversation** — ConversationBufferMemory, ConversationSummaryMemory, ConversationTokenBufferMemory, chat history management | Build a chatbot with switchable memory strategies; compare behavior across memory types |
| 11 | **Embeddings & Vector Databases** — What are embeddings, embedding models, ChromaDB setup, Pinecone, similarity search, distance metrics | Generate embeddings for a document corpus; store in ChromaDB; perform similarity searches |
| 12 | **RAG I — Foundations** — Document loaders, text splitters (chunking strategies), retriever types, basic RAG chain | Build a RAG system over a set of PDF documents: load → chunk → embed → retrieve → answer |
| 13 | **RAG II — Advanced Patterns** — Multi-query retriever, contextual compression, parent document retriever, hybrid search, re-ranking | Improve the RAG system with multi-query retrieval and re-ranking; measure quality improvement |
| 14 | **Putting It Together** — Application architecture, API serving (FastAPI), error handling in production, LangSmith tracing | Wrap a LangChain RAG application in a FastAPI endpoint; add tracing and error handling |
| 15 | **Final Project Presentations** | Present and demonstrate final LangChain applications; peer review and code review |

## Required Readings & Resources

- Harrison Chase et al. LangChain Documentation. python.langchain.com (current version).
- Swyx & Alessio. *AI Engineering* (2024). O'Reilly. (Selected chapters on RAG and agents.)
- Matthes, E. *Python Crash Course*, 3rd Edition (2023). No Starch Press. (Chapters 1–11 for Python fundamentals.)
- ChromaDB Documentation. docs.trychroma.com.
- LangSmith Documentation. docs.smith.langchain.com.
- Weekly Jupyter notebooks and code templates provided on LMS.

## Assessment Breakdown

| Component | Weight | Description |
|---|---|---|
| Weekly Lab Assignments | 20% | Jupyter notebooks and Python scripts demonstrating weekly concepts |
| Python Proficiency Assessment | 10% | Weeks 1–3 coding assessment ensuring foundational Python skills |
| Midterm Practical | 15% | Build a LangChain application from a specification under time constraints |
| RAG System Project | 20% | Design and implement a complete RAG system with evaluation metrics |
| Final Project | 25% | Full-stack LangChain application with API, documentation, and demo |
| Participation & Code Review | 10% | In-class engagement, peer code reviews, discussion contributions |

## Key Tools & Technologies

- Python 3.11+
- LangChain / LangChain Expression Language (LCEL)
- LangSmith (tracing and debugging)
- OpenAI API / Anthropic API
- ChromaDB (vector database)
- Pinecone (managed vector database)
- FastAPI
- Jupyter Notebooks
- VS Code
- Git / GitHub
