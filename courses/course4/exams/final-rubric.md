# Final Project Rubric

**GENAI 401 — Advanced AI Systems & Architecture**
**Total Points: 250**

## 1. Architecture & Design (50 pts)

| Criteria | Excellent (45-50) | Good (35-44) | Adequate (25-34) | Needs Work (<25) |
|----------|------------------|--------------|------------------|-----------------|
| Agent decomposition | Clear, justified roles with minimal overlap; compelling rationale for multi-agent | Reasonable roles, mostly justified | Basic separation but questionable rationale | Monolithic or arbitrary |
| Communication design | Structured protocols, well-defined message schemas, handles async | Structured messages, basic flow | Some structure | Free-text chaining |
| Failure handling | Comprehensive: retries, timeouts, fallbacks, circuit breakers | Handles common failures | Basic try/catch | No error handling |
| Design document | Professional, thorough, clear tradeoff analysis | Good coverage with minor gaps | Covers basics | Incomplete or superficial |

## 2. Implementation (75 pts)

| Criteria | Excellent (68-75) | Good (53-67) | Adequate (38-52) | Needs Work (<38) |
|----------|------------------|--------------|------------------|-----------------|
| Code quality | Clean, well-documented, typed, tested | Good quality, minor issues | Functional but messy | Hard to read or broken |
| Agent interaction | Rich coordination, shared state, proper sequencing | Working multi-agent flow | Basic chaining | Agents barely interact |
| RAG component | Advanced pattern (corrective/self-RAG), hybrid search, reranking | Solid RAG with hybrid search | Basic vector search | No or broken RAG |
| Fine-tuning / model choice | Effective fine-tune with measured improvement, or rigorous justification for base models | Fine-tune attempted with some improvement | Minimal fine-tuning | Not addressed |
| Reproducibility | `docker compose up` works first try, clear README | Works with minor tweaks | Needs significant setup | Can't reproduce |
| Testing | Unit + integration + eval tests | Unit tests for core | Some tests | No tests |

## 3. Security & Guardrails (30 pts)

| Criteria | Excellent (27-30) | Good (21-26) | Adequate (15-20) | Needs Work (<15) |
|----------|------------------|--------------|------------------|-----------------|
| Input protection | ML + rule-based injection detection, tested against adversarial set | One detection method, mostly effective | Basic input sanitization | No protection |
| Output safety | PII redaction, content filtering, citation verification | PII redaction working | Basic output checks | No filtering |
| Audit & limits | Structured logging, rate limits, token budgets | Logging present, basic limits | Some logging | No observability |
| Threat model | Specific to system, risk-classified, mitigations mapped | Generic but reasonable | Brief threat list | Missing |

## 4. Deployment & Operations (45 pts)

| Criteria | Excellent (41-45) | Good (32-40) | Adequate (23-31) | Needs Work (<23) |
|----------|------------------|--------------|------------------|-----------------|
| Infrastructure | IaC, auto-scaling, load balancing, health checks | Docker Compose with health checks | Basic containerization | Local-only |
| Monitoring | Dashboard with LLM-specific metrics, alerting configured | Basic metrics dashboard | Some metric collection | No monitoring |
| Tracing | End-to-end distributed tracing across agents | Tracing on main path | Basic request logging | No tracing |
| Load testing | Sustained test with throughput/latency/error analysis | Brief load test | Manual testing only | Untested |

## 5. Evaluation & Analysis (50 pts)

| Criteria | Excellent (45-50) | Good (35-44) | Adequate (25-34) | Needs Work (<25) |
|----------|------------------|--------------|------------------|-----------------|
| Eval framework | Custom metrics, automated scoring, ground truth comparison | Good metrics on test set | Basic accuracy measurement | Ad-hoc evaluation |
| Ablation study | Each component measured, clear contribution analysis | Most components measured | Partial ablation | No ablation |
| Cost analysis | Per-request breakdown, optimization plan with projected savings | Basic cost estimate | Rough cost mention | Not addressed |
| Baseline comparison | Multi-agent vs single-agent with statistical significance | Basic comparison | Mentioned but not measured | No baseline |
| Limitations | Honest, specific, with improvement roadmap | Acknowledges key limitations | Brief mention | Claims no limitations |

## Presentation (included in above scores)

- **Demo:** Working system demonstrated live (not just screenshots)
- **Clarity:** Architecture clearly explained, audience can follow
- **Depth:** Technical questions answered confidently
- **Time:** Within 15-minute limit

## Peer Review (separate, 25 bonus pts available)

Each student reviews another team's project:
- Run their system following their README
- Test with 5 custom queries
- Write 1-page assessment covering: what works well, what doesn't, suggestions
- Thoughtful reviews earn up to 25 bonus points

## Grade Mapping

| Points | Grade |
|--------|-------|
| 225-250 | A |
| 200-224 | A- |
| 175-199 | B+ |
| 150-174 | B |
| 125-149 | B- |
| <125 | C or below |
