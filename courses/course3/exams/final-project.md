# GENAI 301: Final Project — Building a Full-Stack LangChain Application

**Course:** GENAI 301 — Building with LangChain
**Weight:** 30% of final grade
**Timeline:** Weeks 11–16 (6 weeks)

---

## Project Description

Design and build a complete LangChain application that demonstrates mastery of the core concepts covered in this course. Your application must integrate **Retrieval-Augmented Generation (RAG)** with a vector database, at least one **custom agent with tools**, **conversation memory**, and **quantitative evaluation metrics**.

You may choose any domain (legal Q&A, medical triage assistant, codebase navigator, research paper analyzer, customer support bot, etc.), but the application must be functional, well-tested, and professionally documented.

This is an individual project. You will present your work in a 10-minute demo during finals week.

---

## Core Requirements

### 1. RAG Pipeline with Vector Database
- Ingest a meaningful corpus (minimum 50 documents or equivalent)
- Implement document loading, chunking (with justification for strategy), and embedding
- Use a vector database (Chroma, Pinecone, Weaviate, Qdrant, or FAISS)
- Support similarity search with configurable `k` and optional metadata filtering
- Implement at least one advanced retrieval technique: hybrid search, re-ranking, multi-query retrieval, or parent-document retrieval

### 2. Custom Agent with Tools
- Build at least one LangChain agent using the tool-calling or ReAct pattern
- Implement a minimum of **3 custom tools** (e.g., database lookup, API call, calculator, web search, file reader)
- Agent must decide which tools to use based on user input (not hardcoded routing)
- Include proper error handling for tool failures

### 3. Conversation Memory
- Integrate conversation memory so the application maintains context across turns
- Support at least one memory type: `ConversationBufferMemory`, `ConversationSummaryMemory`, or `ConversationBufferWindowMemory`
- Demonstrate that follow-up questions reference prior context correctly
- Memory should persist across at least a single session (bonus for cross-session persistence)

### 4. Evaluation Metrics
- Create an evaluation dataset with at least 20 test cases
- Implement or integrate at least **3 quantitative metrics** (e.g., answer correctness, faithfulness, relevance, latency, cost)
- Use LangSmith or an equivalent evaluation framework
- Report results with analysis of strengths and weaknesses

### 5. Production Readiness
- Streaming support for LLM responses
- Cost tracking (token usage and estimated USD)
- Error handling with retries and fallbacks
- Configuration via environment variables (no hardcoded API keys)

---

## Milestones

| Week | Milestone | Deliverable | Points |
|------|-----------|-------------|--------|
| 11 | **Proposal** | 1-page project proposal: domain, data sources, architecture diagram, tool descriptions | 10 |
| 12 | **RAG Pipeline** | Working RAG with ingested data, retrieval demo notebook | 30 |
| 13 | **Agent + Tools** | Agent with 3+ tools, demo showing autonomous tool selection | 30 |
| 14 | **Memory + Integration** | Full pipeline with memory; end-to-end conversation demo | 20 |
| 15 | **Evaluation + Polish** | Evaluation results, error handling, streaming, documentation | 30 |
| 16 | **Final Presentation** | 10-minute live demo + Q&A, final code submission | 80 |

**Total: 200 points**

---

## Deliverables

### Code Repository
- Clean, well-organized GitHub repository
- `README.md` with setup instructions, architecture overview, and usage examples
- `requirements.txt` or `pyproject.toml` with pinned dependencies
- `.env.example` with required environment variables (no actual keys)

### Documentation
- **Architecture document** (1–2 pages): system design, component interactions, data flow diagram
- **Evaluation report** (2–3 pages): methodology, results, analysis of failure modes
- **Reflection** (1 page): what worked, what didn't, what you'd do differently

### Presentation
- 10-minute live demo during finals week
- Show the application working end-to-end
- Demonstrate agent tool selection, RAG retrieval, and memory in action
- Be prepared for 5 minutes of Q&A

---

## Timeline

| Date | Event |
|------|-------|
| Week 11, Monday | Project proposal due |
| Week 11, Wednesday | Proposal feedback returned |
| Week 12, Friday | RAG milestone check-in (in-class demo) |
| Week 13, Friday | Agent milestone check-in |
| Week 14, Friday | Integration milestone — full working prototype |
| Week 15, Friday | Final code + documentation due (GitHub) |
| Week 16 | Final presentations (schedule TBD) |

Late submissions: -10% per day, maximum 3 days. Milestones cannot be submitted late (they are check-ins).

---

## Technical Constraints

- **Language:** Python 3.10+
- **Framework:** LangChain (latest stable) — LCEL required for chain composition
- **LLM:** Any supported model (OpenAI, Anthropic, local via Ollama). Document your choice and reasoning.
- **Vector DB:** Any supported vector store. Justify your choice.
- **Deployment:** Local execution is fine. Bonus points for a deployed demo (Streamlit, Gradio, FastAPI).

---

## Academic Integrity

- This is individual work. You may discuss high-level approaches with classmates but all code must be your own.
- You may use AI coding assistants (Copilot, ChatGPT, etc.) but must disclose their use and understand every line of submitted code.
- Copied code from tutorials or repos must be attributed with a comment linking the source.
- During the presentation, you must be able to explain any part of your codebase.

---

## Grading

See **final-rubric.md** for the detailed 200-point rubric.
