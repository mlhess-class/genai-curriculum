# Certificate in Generative AI Engineering

## Program Overview

The Certificate in Generative AI Engineering is a 15-credit, five-course program that takes students from zero AI knowledge to building and deploying production-grade AI systems. Students progress through foundational concepts and prompt engineering, workflow automation with n8n, code-based application development with LangChain and Python, advanced architecture and production operations, and a capstone project demonstrating mastery of the full stack.

### Program Learning Outcomes

Graduates of this certificate will be able to:

1. Evaluate and effectively use generative AI tools and APIs for diverse professional applications.
2. Design and build automated workflows integrating AI models with business data sources using n8n.
3. Develop AI applications in Python using LangChain, including RAG systems, agents, and conversational interfaces.
4. Architect, deploy, and operate production-grade AI systems with appropriate evaluation, monitoring, and security.
5. Communicate AI solution designs to technical and non-technical stakeholders through documentation and presentations.
6. Apply ethical reasoning and responsible AI frameworks to technology decisions.

### Program Structure

| Course | Title | Credits | Prerequisites |
|---|---|---|---|
| GENAI 101 | Foundations of Generative AI | 3 | None |
| GENAI 201 | AI-Powered Workflows & Automation | 3 | GENAI 101 |
| GENAI 301 | Building with LangChain | 3 | GENAI 201 |
| GENAI 401 | Advanced AI Systems & Architecture | 3 | GENAI 301 |
| GENAI 490 | Capstone - AI Solution Design | 3 | GENAI 401 |
| | **Total** | **15** | |

### Recommended Sequence

The courses are designed to be taken sequentially over 2–3 semesters. A typical full-time path completes in two semesters (101+201 in semester 1, 301+401 in semester 2, 490 in summer or semester 3). Part-time students may take one course per semester.

---

# GENAI 101: Foundations of Generative AI

## Course Information

| Field | Detail |
|---|---|
| **Course Number** | GENAI 101 |
| **Title** | Foundations of Generative AI |
| **Credits** | 3 |
| **Prerequisites** | None |
| **Format** | Lecture + Lab (2 hrs lecture, 2 hrs lab per week) |

## Course Description

An introduction to generative artificial intelligence for students with no prior AI experience. Students explore the core concepts behind large language models, image generators, and other generative systems. Through hands-on work with commercial tools including ChatGPT, Claude, and Gemini, students develop practical prompt engineering skills while critically examining the ethical, societal, and professional implications of generative AI. Topics include transformer architecture at a conceptual level, token economics, hallucination and reliability, bias and fairness, intellectual property considerations, and responsible use frameworks. Students complete the course able to evaluate GenAI tools, craft effective prompts for diverse tasks, and articulate informed positions on AI governance.

## Learning Objectives

Upon successful completion, students will be able to:

1. Explain how large language models generate text, including the roles of training data, tokens, and probability in output generation.
2. Compare the capabilities, limitations, and pricing models of at least three major GenAI platforms (OpenAI, Anthropic, Google).
3. Apply structured prompt engineering techniques—including role assignment, few-shot prompting, chain-of-thought, and constraint specification—to produce reliable outputs.
4. Evaluate GenAI outputs for accuracy, bias, hallucination, and fitness for purpose using systematic rubrics.
5. Analyze ethical dilemmas arising from generative AI in professional, academic, and creative contexts.
6. Construct multi-turn conversations that leverage context windows effectively for complex tasks.
7. Identify appropriate and inappropriate use cases for generative AI across business, education, healthcare, and creative domains.
8. Develop a personal responsible-use framework grounded in current AI governance literature.

## Week-by-Week Syllabus

| Week | Topic | Lab Activity |
|---|---|---|
| 1 | **What Is Generative AI?** — History of AI, narrow vs. general AI, the generative paradigm, landscape of GenAI tools | Set up accounts on ChatGPT, Claude, Gemini; first prompt experiments |
| 2 | **How LLMs Work (Conceptual)** — Transformers, attention, training data, pre-training vs. fine-tuning, tokens and context windows | Token counting exercises; compare outputs across temperature settings |
| 3 | **The GenAI Ecosystem** — OpenAI, Anthropic, Google, Meta, open-source models; APIs vs. consumer products; pricing models | Side-by-side platform comparison: same prompt across 3+ tools |
| 4 | **Prompt Engineering Fundamentals** — Zero-shot, few-shot, role prompting, instruction clarity, output formatting | Prompt challenge: extract structured data from unstructured text |
| 5 | **Advanced Prompt Techniques** — Chain-of-thought, self-consistency, tree-of-thought, meta-prompting, system prompts | Build a multi-step reasoning prompt for a complex analysis task |
| 6 | **Working with Long Contexts** — Context window management, document analysis, summarization strategies | Upload and analyze a 20+ page document; iterative summarization |
| 7 | **Multimodal AI** — Image generation (DALL·E, Midjourney), vision models, audio/video generation, emerging modalities | Generate images from prompts; use vision models to analyze images |
| 8 | **Midterm Review & Exam** | Midterm practical: timed prompt engineering challenges |
| 9 | **Hallucination & Reliability** — Why models hallucinate, detection strategies, grounding techniques, citation and verification | Hallucination audit: identify and document failures across platforms |
| 10 | **Bias, Fairness & Representation** — Training data bias, stereotyping, mitigation strategies, red-teaming basics | Red-team exercise: probe models for bias across demographic dimensions |
| 11 | **Intellectual Property & Copyright** — Training data provenance, fair use, model output ownership, emerging case law | Case study analysis: Evaluate 3 real IP disputes involving GenAI |
| 12 | **Privacy & Security** — Data leakage, prompt injection, PII handling, enterprise vs. consumer safety profiles | Prompt injection workshop; draft a data handling policy for GenAI use |
| 13 | **AI in the Workplace** — Use cases by industry, augmentation vs. automation, job impact, change management | Interview a professional about AI adoption; present findings |
| 14 | **Governance & Responsible Use** — EU AI Act, NIST AI RMF, organizational AI policies, personal frameworks | Draft a responsible AI use policy for a hypothetical organization |
| 15 | **Final Project Presentations & Course Wrap-Up** | Present final projects; peer review; course retrospective |

## Required Readings & Resources

- Mollick, E. *Co-Intelligence: Living and Working with AI* (2024). Portfolio/Penguin.
- OpenAI. "Prompt Engineering Guide." docs.openai.com (current version).
- Anthropic. "Prompt Engineering Documentation." docs.anthropic.com (current version).
- NIST. "AI Risk Management Framework (AI RMF 1.0)." 2023.
- Selected articles from MIT Technology Review, The Verge, and ArXiv (provided weekly on LMS).

## Assessment Breakdown

| Component | Weight | Description |
|---|---|---|
| Weekly Lab Exercises | 20% | Hands-on prompt engineering and analysis tasks |
| Prompt Engineering Portfolio | 20% | Curated collection of 10 prompt-response pairs with reflective annotations |
| Midterm Exam | 15% | Practical + short-answer covering Weeks 1–7 |
| Ethics Case Study Paper | 15% | 2,000-word analysis of an ethical dilemma in GenAI |
| Final Project | 20% | Design and demonstrate a GenAI-assisted workflow for a real-world problem |
| Participation & Discussion | 10% | In-class engagement, peer feedback, discussion board contributions |

## Key Tools & Technologies

- ChatGPT (GPT-4o)
- Claude (Anthropic)
- Gemini (Google)
- DALL·E / Midjourney (image generation)
- OpenAI Playground
- Tokenizer tools (tiktoken)

---

# GENAI 201: AI-Powered Workflows & Automation

## Course Information

| Field | Detail |
|---|---|
| **Course Number** | GENAI 201 |
| **Title** | AI-Powered Workflows & Automation |
| **Credits** | 3 |
| **Prerequisites** | GENAI 101 |
| **Format** | Lecture + Lab (2 hrs lecture, 2 hrs lab per week) |

## Course Description

Students learn to design and build automated workflows that integrate generative AI into business processes using n8n, a powerful open-source workflow automation platform. Beginning with workflow thinking and systems design, the course progresses through API fundamentals, data transformation, conditional logic, and error handling. Students connect AI models to real-world data sources including email, databases, spreadsheets, and web services to build end-to-end automated pipelines. No prior programming experience is required; the course emphasizes visual, no-code/low-code approaches while introducing foundational concepts that prepare students for code-based development in subsequent courses. Students complete multiple production-ready workflows addressing authentic business scenarios.

## Learning Objectives

Upon successful completion, students will be able to:

1. Decompose complex business processes into discrete, automatable workflow steps using systems thinking principles.
2. Build, test, and deploy multi-step automated workflows in n8n that integrate AI model APIs with external data sources.
3. Explain how REST APIs function—including authentication, HTTP methods, request/response formats, and rate limiting—and connect to third-party APIs within workflows.
4. Implement conditional logic, branching, looping, and error handling to create robust, fault-tolerant automations.
5. Transform and map data between different formats (JSON, CSV, XML) as it flows between workflow nodes.
6. Integrate OpenAI, Anthropic, and Google AI APIs into workflows for text generation, classification, summarization, and extraction tasks.
7. Apply security best practices including credential management, input validation, and access controls to workflow deployments.
8. Document workflows with clear specifications covering purpose, data flow, failure modes, and maintenance requirements.

## Week-by-Week Syllabus

| Week | Topic | Lab Activity |
|---|---|---|
| 1 | **Workflow Thinking** — Process mapping, input/output analysis, automation candidates, ROI estimation | Map a manual business process; identify automation opportunities |
| 2 | **Introduction to n8n** — Architecture, UI tour, nodes, connections, executions, self-hosted vs. cloud | Install n8n locally; build a "Hello World" workflow with manual trigger + HTTP request |
| 3 | **API Fundamentals** — REST concepts, HTTP methods, headers, authentication (API keys, OAuth), JSON basics | Use n8n HTTP Request node to call a public API; parse JSON responses |
| 4 | **Core n8n Nodes** — Set, If, Switch, Merge, Split In Batches, Code (expressions), Function nodes | Build a workflow that fetches data, filters it, and routes to different outputs |
| 5 | **Data Transformation** — JSON manipulation, field mapping, data type conversion, expressions, JMESPath | Transform messy API data into clean structured output; CSV ↔ JSON conversion |
| 6 | **Connecting AI Models** — OpenAI node, HTTP requests to Anthropic/Google, prompt templates, dynamic variables | Build a workflow that takes input text and sends it through 3 different AI models |
| 7 | **AI-Powered Email Processing** — Gmail/IMAP triggers, email parsing, AI classification, automated responses | Create an email triage system: classify incoming emails and draft responses |
| 8 | **Midterm Review & Exam** | Midterm practical: build a complete workflow from a requirements spec |
| 9 | **Database & Spreadsheet Integration** — Google Sheets, Airtable, PostgreSQL nodes, CRUD operations | Build an AI-powered data enrichment pipeline: spreadsheet → AI → database |
| 10 | **Webhooks & Event-Driven Workflows** — Webhook triggers, payload handling, response nodes, external integrations | Create a webhook-triggered workflow that processes form submissions with AI |
| 11 | **Error Handling & Reliability** — Try/Catch patterns, retry logic, error workflows, logging, monitoring | Add comprehensive error handling to a previous workflow; build alerting |
| 12 | **Document Processing Workflows** — PDF extraction, OCR, AI summarization, structured data extraction from documents | Build a document intake pipeline: upload → extract → AI analyze → store results |
| 13 | **Multi-Step AI Pipelines** — Chaining AI calls, context passing, output-as-input patterns, quality gates | Create a content pipeline: research → draft → review → refine → publish |
| 14 | **Deployment & Operations** — n8n in production, environment variables, credential management, versioning, backup | Deploy a workflow to a production n8n instance; set up monitoring |
| 15 | **Final Project Presentations** | Present and demonstrate final workflow projects; peer review |

## Required Readings & Resources

- n8n Documentation. docs.n8n.io (current version).
- Postman. "Introduction to APIs." postman.com/api-first (selected chapters).
- OpenAI. "API Reference." platform.openai.com/docs/api-reference.
- Hohpe, G. & Woolf, B. *Enterprise Integration Patterns* (selected chapters provided as PDF).
- Weekly tutorial videos and reference sheets provided on LMS.

## Assessment Breakdown

| Component | Weight | Description |
|---|---|---|
| Weekly Lab Workflows | 25% | Completed n8n workflows demonstrating each week's concepts |
| Midterm Practical | 15% | Timed build of a workflow from requirements specification |
| Workflow Documentation Portfolio | 15% | Professional documentation for 3 workflows including diagrams and specs |
| Integration Challenge | 15% | Connect 3+ external services with AI processing in a single workflow |
| Final Project | 20% | End-to-end automated workflow solving a real business problem |
| Participation | 10% | In-class engagement, peer feedback, discussion contributions |

## Key Tools & Technologies

- n8n (self-hosted and/or cloud)
- OpenAI API
- Anthropic API
- Google AI API
- Postman (API testing)
- Google Sheets / Airtable
- PostgreSQL
- Gmail / IMAP
- Webhook.site (testing)
- Docker (for n8n deployment)

---

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

---

# GENAI 401: Advanced AI Systems & Architecture

## Course Information

| Field | Detail |
|---|---|
| **Course Number** | GENAI 401 |
| **Title** | Advanced AI Systems & Architecture |
| **Credits** | 3 |
| **Prerequisites** | GENAI 301 |
| **Format** | Lecture + Lab (2 hrs lecture, 2 hrs lab per week) |

## Course Description

Students design and build production-grade AI systems, moving beyond prototypes to robust, scalable, and secure deployments. Topics include multi-agent orchestration, advanced RAG architectures (graph RAG, agentic RAG, CRAG), evaluation frameworks, cost optimization, observability, and security hardening. Students work with LangGraph for stateful agent workflows, implement comprehensive evaluation pipelines, and deploy systems with proper monitoring, logging, and failure recovery. The course emphasizes architectural decision-making, trade-off analysis, and the operational realities of maintaining AI systems in production. Students complete the course prepared to architect and operate enterprise AI solutions.

## Learning Objectives

Upon successful completion, students will be able to:

1. Design multi-agent systems using LangGraph, implementing state machines, handoffs, and human-in-the-loop patterns for complex workflows.
2. Implement advanced RAG architectures including graph RAG, corrective RAG (CRAG), self-RAG, and agentic retrieval strategies.
3. Build comprehensive evaluation frameworks using automated metrics (RAGAS, faithfulness, relevance) and human evaluation protocols.
4. Deploy AI applications to production with containerization, CI/CD pipelines, health checks, and rollback strategies.
5. Implement cost optimization strategies including model routing, caching, prompt compression, and token budgeting.
6. Apply security best practices including prompt injection defense, output filtering, PII detection, and access control to AI systems.
7. Design observability stacks for AI applications covering tracing, logging, metrics dashboards, and alerting.
8. Evaluate architectural trade-offs (latency vs. quality, cost vs. capability, complexity vs. maintainability) and justify design decisions with data.

## Week-by-Week Syllabus

| Week | Topic | Lab Activity |
|---|---|---|
| 1 | **Production AI Architecture** — System design patterns, monolith vs. microservice AI, latency budgets, scaling strategies | Diagram the architecture of 3 real-world AI products; identify patterns and trade-offs |
| 2 | **LangGraph Fundamentals** — State machines, nodes, edges, conditional routing, checkpointing, state management | Build a stateful conversational agent with LangGraph; implement branching logic |
| 3 | **Multi-Agent Systems I** — Agent roles, supervisor patterns, hierarchical agents, inter-agent communication | Create a supervisor agent that delegates to specialist agents (researcher, writer, critic) |
| 4 | **Multi-Agent Systems II** — Human-in-the-loop, approval workflows, agent handoffs, collaborative agent patterns | Add human approval gates and handoff protocols to the multi-agent system |
| 5 | **Advanced RAG I — Graph & Hybrid** — Knowledge graphs, graph RAG, hybrid search (sparse + dense), metadata filtering | Build a graph RAG system: extract entities → build graph → graph-enhanced retrieval |
| 6 | **Advanced RAG II — Agentic & Corrective** — CRAG, self-RAG, agentic retrieval, query planning, iterative retrieval | Implement CRAG with fallback to web search when retrieval confidence is low |
| 7 | **Evaluation Frameworks I** — RAGAS metrics, faithfulness, answer relevancy, context precision/recall, automated eval pipelines | Build an evaluation pipeline: generate test set → run RAG → score with RAGAS → report |
| 8 | **Midterm Review & Exam** | Midterm: design and justify an architecture for a given business scenario |
| 9 | **Evaluation Frameworks II** — Human evaluation protocols, A/B testing, LLM-as-judge, custom metrics, regression testing | Implement LLM-as-judge evaluation; compare with human ratings; build regression test suite |
| 10 | **Deployment & Infrastructure** — Docker, Docker Compose, cloud deployment (AWS/GCP), CI/CD for AI apps, environment management | Containerize a LangChain app; deploy to cloud with CI/CD; run smoke tests |
| 11 | **Cost Optimization** — Model routing (cheap → expensive), semantic caching, prompt compression, token budgets, batch vs. real-time | Implement a model router that uses GPT-4o-mini for simple queries, GPT-4o for complex ones |
| 12 | **Observability & Monitoring** — LangSmith in production, custom metrics, Prometheus/Grafana, alerting, trace analysis | Set up a monitoring dashboard: track latency, cost, error rate, and quality metrics |
| 13 | **Security & Safety** — Prompt injection defense (input/output guards), PII detection, content filtering, access control, audit logging | Implement a security layer: input sanitization → processing → output filtering → audit log |
| 14 | **Resilience & Operations** — Circuit breakers, graceful degradation, rate limiting, failover, incident response, runbooks | Add circuit breakers and fallback behavior to a production app; write an incident runbook |
| 15 | **Final Project Presentations** | Present production-ready AI system; architecture review with peers |

## Required Readings & Resources

- LangGraph Documentation. langchain-ai.github.io/langgraph (current version).
- Chip Huyen. *AI Engineering* (2025). O'Reilly. (Chapters on evaluation, deployment, and monitoring.)
- RAGAS Documentation. docs.ragas.io.
- OWASP. "LLM Top 10." owasp.org/www-project-top-10-for-large-language-model-applications.
- Selected papers: "Corrective RAG" (Yan et al., 2024), "Self-RAG" (Asai et al., 2023), "Graph RAG" (Microsoft, 2024).
- Weekly architecture case studies and code templates on LMS.

## Assessment Breakdown

| Component | Weight | Description |
|---|---|---|
| Weekly Lab Assignments | 15% | Implementation of weekly concepts with code and documentation |
| Architecture Design Document | 15% | Detailed system design for a complex AI application with trade-off analysis |
| Midterm Exam | 15% | Architecture design and justification under time constraints |
| Evaluation Pipeline Project | 15% | Build a comprehensive eval framework for a RAG system with automated and human metrics |
| Final Project | 30% | Production-deployed AI system with monitoring, security, and documentation |
| Participation & Peer Review | 10% | In-class engagement, architecture reviews, code reviews |

## Key Tools & Technologies

- LangGraph
- LangChain / LCEL
- LangSmith
- RAGAS (evaluation)
- Docker / Docker Compose
- FastAPI
- PostgreSQL / pgvector
- Redis (caching)
- Prometheus / Grafana (monitoring)
- GitHub Actions (CI/CD)
- AWS or GCP (cloud deployment)
- Neo4j (knowledge graphs)

---

# GENAI 490: Capstone - AI Solution Design

## Course Information

| Field | Detail |
|---|---|
| **Course Number** | GENAI 490 |
| **Title** | Capstone - AI Solution Design |
| **Credits** | 3 |
| **Prerequisites** | GENAI 401 |
| **Format** | Seminar + Studio (1 hr seminar, 3 hrs studio per week) |

## Course Description

The capstone integrates all prior coursework into a semester-long project in which students design, build, deploy, and present a production-quality AI solution addressing a real-world problem. Working individually or in pairs, students engage the full product lifecycle—from problem discovery and stakeholder analysis through architecture, implementation, testing, deployment, and documentation. Weekly seminars cover professional skills including project management, technical writing, presentation delivery, and portfolio development. Students produce a comprehensive project portfolio suitable for professional use. The course culminates in a public demo day where students present their solutions to faculty, industry guests, and peers.

## Learning Objectives

Upon successful completion, students will be able to:

1. Identify a real-world problem suitable for an AI solution and validate the opportunity through stakeholder interviews and requirements analysis.
2. Produce a professional project proposal including problem statement, solution architecture, technology selection rationale, timeline, and risk assessment.
3. Execute a structured development plan using agile practices including sprint planning, standups, retrospectives, and iterative delivery.
4. Build and deploy a complete AI system integrating techniques from across the certificate (prompt engineering, n8n workflows, LangChain applications, and/or multi-agent systems).
5. Write professional technical documentation including architecture decision records, API documentation, user guides, and maintenance runbooks.
6. Deliver a compelling technical presentation that communicates complex AI systems to both technical and non-technical audiences.
7. Construct a professional portfolio showcasing the capstone project and selected work from prior courses.
8. Reflect critically on design decisions, trade-offs made, lessons learned, and areas for future improvement.

## Week-by-Week Syllabus

| Week | Topic (Seminar) | Studio Activity |
|---|---|---|
| 1 | **Problem Discovery** — Identifying AI-solvable problems, scoping, feasibility analysis | Brainstorm project ideas; initial feasibility assessment; form teams |
| 2 | **Stakeholder Analysis & Requirements** — User research, requirements gathering, success criteria, acceptance testing | Conduct stakeholder interviews (real or simulated); draft requirements document |
| 3 | **Project Proposals** — Proposal writing, architecture overview, technology selection, risk assessment | Write and submit project proposal; peer review of proposals |
| 4 | **Agile for AI Projects** — Sprint planning, Kanban, estimation for AI work, managing uncertainty | Set up project board; define sprint 1 backlog; begin development |
| 5 | **Technical Writing** — Architecture decision records, documentation standards, README best practices | Write architecture decision records for key technology choices |
| 6 | **Sprint 1 Review** — Progress demos, feedback integration, pivot decisions | Demo sprint 1 deliverables; instructor and peer feedback; plan sprint 2 |
| 7 | **Testing AI Systems** — Unit testing, integration testing, prompt regression testing, user acceptance testing | Write test suites for core functionality; set up CI pipeline |
| 8 | **Sprint 2 Review** — Mid-project check-in, scope management, risk mitigation | Demo sprint 2 deliverables; identify and mitigate risks; plan sprint 3 |
| 9 | **Presentation Skills** — Storytelling with data, demo preparation, handling Q&A, audience adaptation | Practice 5-minute elevator pitch; peer feedback on delivery |
| 10 | **Sprint 3 Review** — Feature freeze guidance, polish vs. new features, technical debt | Demo sprint 3 deliverables; decide feature freeze boundary |
| 11 | **Portfolio Development** — Showcasing technical work, GitHub profile optimization, case study writing | Begin portfolio assembly; write project case study |
| 12 | **Sprint 4 Review & Feature Freeze** — Final functionality review, deployment preparation | Final feature demos; begin deployment and documentation sprint |
| 13 | **Documentation & Deployment Sprint** — Final documentation, deployment verification, user guide creation | Complete all documentation; verify production deployment; write user guide |
| 14 | **Dress Rehearsal** — Practice presentations, demo dry runs, feedback integration | Full dress rehearsal presentations; final feedback round |
| 15 | **Demo Day & Course Wrap-Up** — Public presentations to faculty, industry guests, and peers | Demo Day presentations; portfolio submission; course retrospective |

## Required Readings & Resources

- Cagan, M. *Inspired: How to Create Tech Products Customers Love*, 2nd Edition (2018). Wiley. (Selected chapters on discovery and delivery.)
- Kleppmann, M. "Designing Data-Intensive Applications" — Chapter 1: Reliable, Scalable, and Maintainable Applications. O'Reilly.
- Fowler, M. "Architecture Decision Records." cognitect.com/blog (reference template).
- Selected readings on technical presentations and portfolio building (provided on LMS).
- All documentation from prior courses as reference material.

## Assessment Breakdown

| Component | Weight | Description |
|---|---|---|
| Project Proposal | 10% | Problem statement, architecture, timeline, risk assessment |
| Sprint Reviews (4×) | 20% | Demonstrated progress at each sprint review (5% each) |
| Working System | 25% | Functional, deployed AI solution meeting requirements |
| Documentation Package | 15% | Architecture docs, API docs, user guide, maintenance runbook |
| Demo Day Presentation | 15% | Public presentation and live demonstration |
| Professional Portfolio | 10% | Polished portfolio showcasing capstone and prior work |
| Peer Evaluation | 5% | Teammate and peer assessment of collaboration and contribution |

## Key Tools & Technologies

- All technologies from prior courses as appropriate to the project
- Git / GitHub (version control and project management)
- GitHub Projects or Linear (project management)
- Markdown / MkDocs (documentation)
- Vercel / Railway / AWS (deployment)
- Figma (optional, for UI mockups)
- Loom or similar (demo recordings)

---

