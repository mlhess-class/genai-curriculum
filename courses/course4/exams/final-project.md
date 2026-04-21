# Final Project: Production Multi-Agent System

**GENAI 401 — Advanced AI Systems & Architecture**
**Assigned:** Week 10 | **Due:** Week 14 | **Presentation:** Week 15 | **Points:** 250

## Overview

Design, implement, deploy, and evaluate a production-grade multi-agent AI system that solves a real-world problem. This capstone project integrates skills from the entire course: agent architectures, RAG, fine-tuning, evaluation, deployment, security, observability, and cost optimization.

## Project Options

Choose one of the following domains (or propose your own with instructor approval by Week 11):

### Option A: Autonomous Research Assistant
Multi-agent system that takes a research question, searches academic papers, synthesizes findings, identifies contradictions, and produces a structured literature review with citations.

### Option B: Enterprise Document Intelligence
System that ingests a corpus of enterprise documents (contracts, reports, emails), builds a knowledge graph, and supports natural language queries with multi-hop reasoning and provenance tracking.

### Option C: AI-Powered Code Review Pipeline
Multi-agent system that reviews pull requests: security scanning agent, performance analysis agent, style/best-practices agent, and a synthesis agent that produces prioritized, actionable feedback.

### Option D: Customer Support Orchestrator
Intelligent routing and resolution system with specialized agents for billing, technical support, escalation, and sentiment monitoring, integrated with mock CRM and ticketing systems.

## Requirements

### 1. Architecture & Design (50 pts)

- Minimum 3 specialized agents with clear role separation
- Architecture diagram with data flow, communication patterns, and failure handling
- Design document (4-6 pages) covering:
  - Problem analysis and why multi-agent is the right approach
  - Agent roles, capabilities, and interaction protocols
  - State management strategy
  - Failure modes and recovery mechanisms
  - Alternative architectures considered with tradeoff analysis

### 2. Implementation (75 pts)

- Clean, well-documented codebase with README
- Structured inter-agent communication (not raw string passing)
- At least one advanced RAG component (hybrid search, reranking, or corrective RAG)
- At least one fine-tuned model component (LoRA/QLoRA) OR justified argument for why base models suffice
- Comprehensive error handling and graceful degradation
- Runnable with `docker compose up` (provide all configs)
- Test coverage: unit tests for core logic, integration tests for agent interactions

### 3. Security & Guardrails (30 pts)

- Input validation and prompt injection defense
- Output filtering (PII, harmful content)
- Audit logging for all agent interactions
- Rate limiting / token budgets
- Threat model document specific to your system

### 4. Deployment & Operations (45 pts)

- Infrastructure as code (Docker Compose minimum; Kubernetes or Terraform for bonus)
- Health checks and readiness probes
- Monitoring dashboard with key metrics (latency, throughput, errors, cost)
- Distributed tracing across agent calls
- Load test results (minimum 5-minute sustained load)

### 5. Evaluation & Analysis (50 pts)

- Custom evaluation framework with domain-specific metrics
- Benchmark on at least 50 test cases with ground truth
- Ablation study: measure contribution of each agent / component
- Cost analysis: per-request cost breakdown with optimization recommendations
- Comparison against single-agent baseline
- Honest discussion of limitations and failure modes

## Deliverables

1. **GitHub Repository** — All code, configs, IaC, documentation
2. **Design Document** (PDF, 4-6 pages)
3. **Evaluation Report** (PDF, 6-8 pages)
4. **15-Minute Presentation** (Week 15) — Demo + architecture walkthrough + findings
5. **Peer Review** — Each student reviews one other team's system (rubric provided)

## Teams

- Teams of 2-3 students
- Individual submissions accepted with reduced scope (2 agents minimum)
- Each member must document their specific contributions

## Timeline

| Week | Milestone |
|------|-----------|
| 10 | Project kickoff, team formation |
| 11 | Design document due, proposal approval |
| 12 | Implementation checkpoint (working prototype) |
| 13 | Security review + monitoring setup |
| 14 | Final submission: code, reports, documentation |
| 15 | Presentations + peer review |
