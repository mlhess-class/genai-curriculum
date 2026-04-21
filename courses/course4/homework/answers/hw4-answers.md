# HW4 Model Answers: Cost Optimization & Deployment

## Part A: Cost Analysis

### Baseline Application Profile: Customer Support Chatbot

| Metric | Value |
|--------|-------|
| Avg input tokens/req | 1,850 (system prompt + history + query) |
| Avg output tokens/req | 420 |
| Latency p50 | 2.1s |
| Latency p95 | 4.8s |
| Latency p99 | 8.3s |
| Model | GPT-4-turbo ($10/1M input, $30/1M output) |

### Monthly Cost Projections

| Scale | Input Cost | Output Cost | Total/Month |
|-------|-----------|-------------|-------------|
| 10K req/day | $555 | $3,780 | $4,335 |
| 100K req/day | $5,550 | $37,800 | $43,350 |
| 1M req/day | $55,500 | $378,000 | $433,500 |

### Top 3 Cost Drivers
1. **Output tokens on GPT-4** (87% of cost) — 3x price of input tokens
2. **Bloated system prompt** (800 tokens of rarely-used instructions)
3. **No caching** — 40% of queries are near-duplicates (FAQ-type questions)

## Part B: Optimizations Implemented

### 1. Prompt Optimization
- Compressed system prompt from 800 → 340 tokens (removed redundant instructions, used abbreviations)
- Switched to structured output format (shorter responses)
- **Result:** -28% token cost, no quality degradation

### 2. Semantic Caching (Redis + embeddings)
```python
async def cached_generate(query, threshold=0.92):
    embedding = embed(query)
    cached = redis.ft_search(embedding, k=1)
    if cached and cached.score > threshold:
        return cached.response  # Cache hit
    response = await llm.generate(query)
    redis.store(embedding, response, ttl=3600)
    return response
```
- **Result:** 38% cache hit rate → 38% reduction in LLM calls

### 3. Model Routing
```python
def route_query(query):
    complexity = classify_complexity(query)  # Small classifier
    if complexity == "simple":  # FAQ, greetings, simple lookups
        return "gpt-3.5-turbo"  # $0.50/$1.50 per 1M
    return "gpt-4-turbo"
```
- 55% of queries routed to GPT-3.5 — quality maintained (validated on eval set)
- **Result:** -62% cost on routed queries

### 4. Context Window Management
- Sliding window: keep last 5 turns instead of full history
- Summarize older context into 100-token summary
- **Result:** -35% avg input tokens

### Combined Impact

| Metric | Baseline | Optimized | Improvement |
|--------|----------|-----------|-------------|
| Avg cost/request | $0.0144 | $0.0031 | -78% |
| Monthly (100K/day) | $43,350 | $9,300 | -$34,050 |
| Latency p50 | 2.1s | 0.8s | -62% |
| Quality score | 4.2/5 | 4.1/5 | -2% (acceptable) |

## Part C: Deployment

### Infrastructure
- **Load balancer:** nginx with least-connections routing
- **Auto-scaling:** Scale on queue depth > 50 or p95 latency > 3s
- **Health checks:** `/health` endpoint every 10s, 3 failures = remove from pool
- **Graceful degradation:** If GPT-4 is down, all traffic routes to GPT-3.5 with disclaimer

### Load Test Results (k6, 10 minutes)
| Metric | Value |
|--------|-------|
| Peak throughput | 285 req/sec |
| Avg latency | 890ms |
| Error rate | 0.12% |
| Cache hit rate | 41% |
