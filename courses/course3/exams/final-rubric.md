# GENAI 301: Final Project Rubric

**Total Points: 200**

---

## 1. RAG Implementation (50 points)

| Criteria | Excellent (full) | Good (75%) | Adequate (50%) | Poor (25%) | Missing (0) |
|----------|-----------------|------------|----------------|------------|-------------|
| **Data ingestion & chunking** (12) | 50+ docs ingested; chunking strategy clearly justified with experimentation | Docs ingested; reasonable chunking with brief justification | Docs ingested; default chunking, no justification | Minimal docs; no chunking thought | Not implemented |
| **Vector database integration** (12) | Vector DB properly configured; efficient indexing; metadata stored | DB works; basic indexing | DB works but poorly configured | Partially working | Not implemented |
| **Retrieval quality** (14) | Advanced technique implemented (hybrid, re-ranking, multi-query); retrieval is accurate | One advanced technique attempted; retrieval mostly accurate | Basic similarity search only; acceptable results | Retrieval returns poor results | Not implemented |
| **Edge case handling** (12) | Handles empty results, irrelevant queries, and adversarial inputs gracefully | Handles most edge cases | Handles some edge cases | Minimal error handling | No edge case handling |

---

## 2. Agent Design (40 points)

| Criteria | Excellent (full) | Good (75%) | Adequate (50%) | Poor (25%) | Missing (0) |
|----------|-----------------|------------|----------------|------------|-------------|
| **Tool implementation** (15) | 3+ well-designed custom tools with clear docstrings, input validation, and error handling | 3 tools working; minor issues | 2 tools working | 1 tool or tools barely functional | No custom tools |
| **Agent reasoning** (15) | Agent autonomously selects correct tools for varied queries; handles multi-step tasks | Correct tool selection for most queries | Sometimes picks wrong tool; needs obvious prompts | Rarely selects correctly | No agent logic |
| **Error recovery** (10) | Agent handles tool failures, retries, and communicates issues to user | Handles most failures | Handles some failures | Crashes on tool errors | No error handling |

---

## 3. Memory Integration (30 points)

| Criteria | Excellent (full) | Good (75%) | Adequate (50%) | Poor (25%) | Missing (0) |
|----------|-----------------|------------|----------------|------------|-------------|
| **Memory implementation** (12) | Memory type chosen with justification; works correctly across conversation turns | Memory works; basic justification | Memory partially works | Memory configured but broken | Not implemented |
| **Contextual follow-ups** (10) | Follow-up questions correctly reference prior turns; pronouns resolved | Most follow-ups work | Some follow-ups work | Rarely works | Not tested |
| **Memory management** (8) | Handles long conversations gracefully (summarization or windowing); no context overflow | Mostly handles long conversations | Some issues with long conversations | Breaks on long conversations | No management |

---

## 4. Code Quality (30 points)

| Criteria | Excellent (full) | Good (75%) | Adequate (50%) | Poor (25%) | Missing (0) |
|----------|-----------------|------------|----------------|------------|-------------|
| **Organization & structure** (10) | Clean module structure; separation of concerns; LCEL throughout | Good structure; mostly LCEL | Acceptable structure; some LCEL | Disorganized; monolithic | Unreadable |
| **Python best practices** (10) | Type hints, docstrings, no hardcoded keys, env config, linting clean | Most best practices followed | Some best practices | Poor code quality | No standards |
| **Production patterns** (10) | Streaming, caching, cost tracking, retries, fallbacks all implemented | Most production patterns | Some production patterns | Minimal production readiness | None implemented |

---

## 5. Documentation (25 points)

| Criteria | Excellent (full) | Good (75%) | Adequate (50%) | Poor (25%) | Missing (0) |
|----------|-----------------|------------|----------------|------------|-------------|
| **README & setup** (8) | Clear README; one-command setup; architecture diagram; usage examples | Good README; minor gaps | Basic README; setup works | Incomplete README | No README |
| **Architecture document** (9) | Detailed system design; data flow diagram; component interaction explained | Good architecture doc; minor gaps | Basic architecture description | Incomplete | Not provided |
| **Reflection** (8) | Thoughtful reflection on decisions, trade-offs, failures, and lessons learned | Good reflection; some depth | Surface-level reflection | Minimal reflection | Not provided |

---

## 6. Evaluation & Testing (25 points)

| Criteria | Excellent (full) | Good (75%) | Adequate (50%) | Poor (25%) | Missing (0) |
|----------|-----------------|------------|----------------|------------|-------------|
| **Evaluation dataset** (8) | 20+ diverse test cases covering happy paths, edge cases, and failure modes | 20+ test cases; limited diversity | 10-19 test cases | Fewer than 10 | No dataset |
| **Metrics implementation** (9) | 3+ quantitative metrics implemented; results analyzed with strengths/weaknesses | 3 metrics; basic analysis | 2 metrics; minimal analysis | 1 metric | No metrics |
| **Evaluation report** (8) | Comprehensive report with methodology, results tables, failure analysis, improvement ideas | Good report; minor gaps | Basic report | Incomplete report | No report |

---

## Grade Scale

| Points | Letter Grade | Description |
|--------|-------------|-------------|
| 185–200 | A | Exceptional — exceeds expectations in multiple areas |
| 170–184 | A- | Excellent — strong across all categories |
| 155–169 | B+ | Very Good — solid work with minor gaps |
| 140–154 | B | Good — meets all core requirements competently |
| 125–139 | B- | Above Average — meets most requirements |
| 110–124 | C+ | Satisfactory — meets minimum requirements |
| 100–109 | C | Adequate — significant gaps but core concepts demonstrated |
| 80–99 | C- | Below Average — major components missing or broken |
| 60–79 | D | Poor — minimal effort or fundamental misunderstanding |
| 0–59 | F | Failing — incomplete or not submitted |

---

## Bonus Points (up to 15)

- **Deployed application** (Streamlit, Gradio, or FastAPI with UI): +5
- **Cross-session memory persistence** (database-backed): +3
- **Multi-modal support** (images, PDFs, or audio input): +4
- **CI/CD pipeline** with automated evaluation on push: +3

Bonus points cannot raise the total above 215.

---

## Presentation Rubric (included in milestone points, Week 16 — 80 pts)

| Criteria | Points |
|----------|--------|
| Live demo works end-to-end without major failures | 25 |
| Clear explanation of architecture and design decisions | 20 |
| Demonstrates agent tool selection, RAG, and memory | 20 |
| Answers Q&A questions confidently and accurately | 15 |

---

*Rubric version 1.0 — GENAI 301, 2026*
