# Homework 6: MLOps Pipeline for LLMs

**GENAI 401 — Advanced AI Systems & Architecture**
**Assigned:** Week 13 | **Due:** Week 14 | **Points:** 100

## Overview

Build an end-to-end MLOps pipeline for continuous evaluation, monitoring, and updating of an LLM-powered application in production.

## Requirements

### Part A: CI/CD for LLM Apps (30 pts)

1. Build a CI pipeline that runs on every PR:
   - Automated eval suite (accuracy, latency, cost regression tests)
   - Prompt regression testing (golden set of 50+ test cases)
   - Guardrail validation (security tests from HW5)
2. CD pipeline that deploys on merge with:
   - Canary deployment (10% traffic → full rollout)
   - Automatic rollback on quality degradation
3. Version control for prompts, configs, and model artifacts

### Part B: Monitoring & Observability (40 pts)

1. Implement production monitoring covering:
   - Request/response logging with sampling
   - Latency, throughput, and error rate dashboards (Grafana or equivalent)
   - Token usage and cost tracking per endpoint
   - LLM-specific metrics: hallucination rate, refusal rate, response quality scores
2. Set up alerting rules for:
   - Latency p99 > threshold
   - Error rate spike
   - Cost anomaly detection
   - Quality score degradation
3. Implement distributed tracing for multi-step LLM chains (OpenTelemetry)

### Part C: Feedback & Improvement Loop (30 pts)

1. Build a feedback collection system (thumbs up/down + optional text)
2. Implement automated data flywheel:
   - Collect low-confidence or negatively-rated responses
   - Human-in-the-loop review interface (simple web UI)
   - Pipeline to incorporate reviewed examples into eval set
3. Design (document, not necessarily implement) an automated retraining trigger

## Rubric

| Criteria | Excellent (90-100%) | Good (70-89%) | Needs Work (<70%) |
|----------|-------------------|---------------|-------------------|
| CI/CD | Full pipeline with canary + rollback | Basic CI with eval | No automation |
| Monitoring | Comprehensive dashboards + alerting | Basic metrics | Minimal monitoring |
| Feedback Loop | Working flywheel with review UI | Basic feedback collection | Missing |
| Integration | All components work together seamlessly | Mostly integrated | Disjointed |

## Submission

- GitHub repo with pipeline configs and monitoring setup
- Dashboard screenshots
- Architecture diagram of full MLOps pipeline
- Report (PDF, max 6 pages)
