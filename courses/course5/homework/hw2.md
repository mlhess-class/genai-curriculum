# Homework 2: Architecture Design Document

## GENAI 490 — Capstone: AI Solution Design

**Milestone Deliverable 2 of 6** | **Due: Week 5** | **100 Points**

---

## Overview

Translate your problem statement into a concrete technical architecture. This document should be detailed enough that a competent engineering team could begin implementation from it.

## Learning Objectives

1. Design an end-to-end generative AI system architecture
2. Make and justify technology selection decisions
3. Create clear architecture diagrams using standard notation
4. Plan for scalability, reliability, and security
5. Define data pipelines, model integration, and API contracts

## Instructions

### Part 1: System Overview (15 pts)

- **Solution summary** — One paragraph describing what the system does
- **High-level architecture diagram** — Show major components and data flow (use draw.io, Mermaid, or equivalent)
- **Key design decisions** — List 3–5 architectural choices and the alternatives you considered

### Part 2: Component Design (30 pts)

For each major component, provide:

1. **Data Layer**
   - Data sources and ingestion pipelines
   - Storage strategy (vector DB, relational, object store)
   - Data preprocessing and transformation steps

2. **AI/Model Layer**
   - Model selection and justification (which foundation models and why)
   - Fine-tuning vs. prompting vs. RAG strategy
   - Prompt engineering approach (include 2–3 example prompts)
   - Guardrails and output validation

3. **Application Layer**
   - API design (REST/GraphQL endpoints, request/response schemas)
   - Business logic and orchestration
   - Caching and optimization strategy

4. **Interface Layer**
   - User interaction flow (wireframes or mockups)
   - Input/output formats
   - Accessibility considerations

### Part 3: Infrastructure & Deployment (20 pts)

- **Cloud/on-prem strategy** with justification
- **Deployment architecture** (containers, serverless, etc.)
- **CI/CD pipeline** overview
- **Monitoring and observability** plan (logging, metrics, alerting)
- **Cost estimation** — Monthly projected costs at pilot and production scale

### Part 4: Security & Compliance (15 pts)

- **Authentication and authorization** model
- **Data privacy** measures (encryption, access controls, PII handling)
- **Model security** (prompt injection prevention, output filtering)
- **Compliance requirements** relevant to your domain (HIPAA, GDPR, SOC2, etc.)

### Part 5: Technical Risk Assessment (20 pts)

Create a risk register with **at least 5 technical risks**:

| Risk | Likelihood | Impact | Mitigation | Contingency |
|---|---|---|---|---|
| Example: Model hallucination in medical context | High | Critical | RAG with verified sources; confidence scoring | Human-in-the-loop review for all outputs |

Include:
- **Dependency risks** (API rate limits, vendor lock-in, model deprecation)
- **Performance risks** (latency, throughput, cost overruns)
- **Data risks** (quality, availability, drift)

## Submission Requirements

- **Format:** PDF or Markdown, 8–12 pages (excluding diagrams and appendices)
- **Diagrams:** Minimum 3 (system overview, data flow, deployment)
- **References:** Cite all tools, frameworks, and models referenced

## Rubric (100 Points)

| Criterion | Excellent (90-100%) | Proficient (70-89%) | Developing (50-69%) | Insufficient (<50%) |
|---|---|---|---|---|
| **System Overview (15)** | Clear diagram; well-justified decisions with alternatives | Adequate diagram; decisions listed but not deeply justified | Incomplete diagram; minimal justification | Missing or incoherent |
| **Component Design (30)** | Thorough design across all layers; specific model/tool choices justified | All layers addressed; some lack depth | Major gaps in one or more layers | Superficial or missing |
| **Infrastructure (20)** | Realistic deployment plan with cost estimates | Plan present but vague on costs or scaling | Incomplete infrastructure planning | Missing or unrealistic |
| **Security & Compliance (15)** | Comprehensive security model; domain-specific compliance addressed | Basic security covered; compliance mentioned | Surface-level security consideration | Missing or inadequate |
| **Risk Assessment (20)** | 5+ risks with realistic mitigations; covers all categories | 5 risks identified; some mitigations generic | Fewer than 5 or superficial analysis | Missing or trivial risks only |
