# Homework 4: Cost Optimization & Deployment

**GENAI 401 — Advanced AI Systems & Architecture**
**Assigned:** Week 9 | **Due:** Week 12 | **Points:** 100

## Overview

Take an existing LLM-powered application and optimize it for production cost efficiency while maintaining quality. Deploy with proper infrastructure.

## Requirements

### Part A: Cost Analysis (25 pts)

1. Profile the provided baseline application's costs:
   - Token usage per request (input/output breakdown)
   - Latency distribution (p50/p95/p99)
   - Monthly projected cost at 10K, 100K, 1M requests/day
2. Identify the top 3 cost drivers with evidence

### Part B: Optimization (45 pts)

Implement at least 4 of the following optimization techniques:

1. **Prompt optimization** — Reduce token count while maintaining quality
2. **Caching** — Semantic cache with similarity threshold tuning
3. **Model routing** — Route simple queries to smaller/cheaper models
4. **Batching** — Implement request batching for throughput
5. **Streaming** — Progressive response delivery
6. **Quantization** — Serve quantized model variant (GPTQ/AWQ)
7. **Speculative decoding** — Draft model + verification
8. **Context window management** — Sliding window, compression, or summarization

Each technique must include before/after metrics.

### Part C: Deployment (30 pts)

1. Deploy the optimized system with:
   - Load balancing across model replicas
   - Auto-scaling based on queue depth or latency
   - Health checks and graceful degradation
2. Run a 10-minute load test (locust or k6) and report:
   - Throughput (req/sec), latency, error rate
   - Cost per request comparison vs. baseline
3. Infrastructure as code (Terraform, Pulumi, or docker-compose)

## Rubric

| Criteria | Excellent (90-100%) | Good (70-89%) | Needs Work (<70%) |
|----------|-------------------|---------------|-------------------|
| Analysis | Thorough profiling with clear cost attribution | Basic cost breakdown | Incomplete analysis |
| Optimization | 4+ techniques with measured improvements | 3 techniques working | Fewer than 3 or unmeasured |
| Deployment | Full infra with auto-scaling, load tested | Basic deployment | Not deployable |
| Documentation | Clear, reproducible, professional | Adequate | Incomplete |

## Submission

- GitHub repo with IaC and application code
- Cost analysis spreadsheet
- Load test results and optimization report (PDF, max 6 pages)
