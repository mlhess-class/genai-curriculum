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
