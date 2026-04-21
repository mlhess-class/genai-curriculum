# Homework 5: Security & Guardrails

**GENAI 401 — Advanced AI Systems & Architecture**
**Assigned:** Week 11 | **Due:** Week 13 | **Points:** 100

## Overview

Implement a comprehensive security and safety layer for an LLM-powered application. Your system must defend against adversarial attacks while maintaining usability.

## Requirements

### Part A: Threat Modeling (25 pts)

1. Produce a threat model for the provided application covering:
   - Prompt injection (direct and indirect)
   - Data exfiltration via prompt manipulation
   - Jailbreaking and alignment bypasses
   - PII leakage in responses
   - Supply chain risks (model poisoning, dependency attacks)
2. Classify each threat by likelihood and impact (risk matrix)
3. Propose mitigations for each identified threat

### Part B: Guardrail Implementation (50 pts)

Implement the following guardrails:

1. **Input validation** — Detect and block prompt injection attempts using at least 2 methods (classifier-based + rule-based)
2. **Output filtering** — PII detection and redaction (names, emails, SSNs, phone numbers)
3. **Content safety** — Block harmful content generation using a safety classifier
4. **Rate limiting** — Per-user token budget with sliding window
5. **Audit logging** — Structured logs for every request with redacted sensitive content
6. **Sandboxing** — If the app uses tool/function calling, implement proper permission boundaries

### Part C: Red Team Evaluation (25 pts)

1. Create an adversarial test suite of 30+ attack prompts covering:
   - Direct prompt injection (10+ variants)
   - Indirect injection via retrieved context
   - Multi-turn jailbreaks
   - Encoding-based bypasses (base64, rot13, unicode)
2. Run attacks against your guardrailed system and report:
   - Attack success rate (should be <10%)
   - False positive rate on benign queries (should be <5%)
   - Latency overhead from guardrails

## Rubric

| Criteria | Excellent (90-100%) | Good (70-89%) | Needs Work (<70%) |
|----------|-------------------|---------------|-------------------|
| Threat Model | Comprehensive, well-classified | Covers main threats | Superficial |
| Guardrails | All 6 implemented, tested | 4-5 implemented | Fewer than 4 |
| Red Team | Diverse attacks, low bypass rate | Basic attack set | Few or untested attacks |
| Analysis | Deep security analysis | Surface-level | Missing |

## Submission

- GitHub repo with guardrail implementation
- Threat model document (PDF)
- Red team report with attack/defense results (PDF, max 6 pages)
