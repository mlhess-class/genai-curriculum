# HW6 Model Answers: MLOps Pipeline for LLMs

## Part A: CI/CD Pipeline

### CI Pipeline (GitHub Actions)

```yaml
name: LLM App CI
on: [pull_request]
jobs:
  eval:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run eval suite
        run: |
          python eval/run_golden_set.py --dataset eval/golden_50.jsonl
          python eval/check_regression.py --baseline results/baseline.json --threshold 0.95
      - name: Latency regression
        run: python eval/latency_bench.py --max-p95 3000  # 3s max
      - name: Cost regression
        run: python eval/cost_check.py --max-avg-tokens 2500
      - name: Security tests
        run: python eval/security_suite.py --max-bypass-rate 0.10
```

### CD Pipeline: Canary Deployment

```python
# Canary controller
async def deploy_canary(new_version: str):
    # Phase 1: 10% traffic
    await update_routing(new=0.10, old=0.90)
    await asyncio.sleep(600)  # 10 min observation

    metrics = await get_canary_metrics()
    if metrics.error_rate > 0.05 or metrics.quality_score < 3.5:
        await rollback(new_version)
        alert("Canary failed — rolled back")
        return

    # Phase 2: 50% traffic
    await update_routing(new=0.50, old=0.50)
    await asyncio.sleep(600)

    metrics = await get_canary_metrics()
    if metrics.error_rate > 0.03 or metrics.quality_score < 3.8:
        await rollback(new_version)
        return

    # Phase 3: Full rollout
    await update_routing(new=1.0, old=0.0)
    alert(f"Canary {new_version} fully deployed")
```

### Prompt Version Control
```
prompts/
  v1.0.0/
    system.txt
    config.yaml  # model, temperature, max_tokens
  v1.1.0/
    system.txt
    config.yaml
    CHANGELOG.md
```
- Prompts stored in git with semantic versioning
- Config references prompt version; deployment pins specific version
- Rollback = redeploy previous prompt version

## Part B: Monitoring & Observability

### Metrics Dashboard (Grafana)

**Panels:**
1. Request rate (req/sec) with success/error breakdown
2. Latency heatmap (p50, p95, p99)
3. Token usage per hour (input vs output, by endpoint)
4. Cost burn rate ($/hour, $/day with projection)
5. Quality score distribution (from automated eval sampling)
6. Hallucination rate (sampled, NLI-based detection)
7. Cache hit rate
8. Model routing distribution

### Alerting Rules

```yaml
alerts:
  - name: high_latency
    condition: p99_latency > 5000ms for 5m
    severity: warning
  - name: error_spike
    condition: error_rate > 5% for 2m
    severity: critical
    action: page_oncall
  - name: cost_anomaly
    condition: hourly_cost > 2x rolling_7d_avg
    severity: warning
  - name: quality_degradation
    condition: avg_quality_score < 3.5 for 1h
    severity: critical
    action: pause_canary
```

### Distributed Tracing (OpenTelemetry)

```python
from opentelemetry import trace
tracer = trace.get_tracer("llm-app")

async def process_request(query):
    with tracer.start_as_current_span("process_request") as span:
        span.set_attribute("query_length", len(query))
        with tracer.start_as_current_span("retrieval"):
            docs = await retrieve(query)
        with tracer.start_as_current_span("generation"):
            response = await generate(query, docs)
            span.set_attribute("output_tokens", count_tokens(response))
        with tracer.start_as_current_span("guardrails"):
            safe_response = await apply_guardrails(response)
        return safe_response
```

## Part C: Feedback & Improvement Loop

### Feedback Collection
- Thumbs up/down on every response + optional text field
- Automatically tag low-confidence responses (model logprob < threshold)

### Data Flywheel
1. Negative feedback → queue for human review
2. Review UI: show query, response, context, reviewer can label (correct/incorrect/partial) and provide gold answer
3. Reviewed examples added to eval golden set (grows over time)
4. Monthly: if golden set > 200 new examples, trigger eval suite refresh

### Retraining Trigger (Design)
- **Signal:** Quality score drops below threshold for 7 consecutive days AND 500+ new reviewed examples available
- **Process:** Auto-create fine-tuning job with new data, eval against current model, deploy as canary if improved
- **Safeguard:** Human approval required before production deployment of retrained model
