# HW1 Model Answers: Multi-Agent System Design

## Part A: Architecture Design

### Recommended Architecture: Hierarchical Orchestrator

**Agents:**
1. **Orchestrator** — Receives user query, decomposes into sub-tasks, delegates, synthesizes final answer
2. **Researcher** — Searches knowledge bases and web sources, returns structured findings
3. **Analyzer** — Performs reasoning over collected data, identifies patterns and contradictions
4. **Writer** — Produces final coherent response with citations

**Communication Flow:**
```
User → Orchestrator → [Researcher, Analyzer] → Orchestrator → Writer → User
```

**Design Justification:**
- Hierarchical over flat: reduces coordination complexity from O(n²) to O(n)
- Orchestrator maintains global state, preventing agents from duplicating work
- Specialized agents allow targeted prompts and smaller context windows
- Failure isolation: one agent failing doesn't crash the system; orchestrator can retry or skip

**Alternatives Considered:**
- *Flat peer-to-peer*: More flexible but harder to debug; no clear termination condition
- *Pipeline (sequential)*: Simpler but no parallelism; bottlenecked by slowest agent
- *Blackboard*: Good for loosely coupled problems but adds shared-state complexity

### Error Handling
- Timeout per agent: 30s default, configurable
- Retry with exponential backoff (max 3 attempts)
- Graceful degradation: if Analyzer fails, Orchestrator uses Researcher output directly

## Part B: Implementation

### Key Implementation Details

```python
# Message schema (structured, not free-text)
class AgentMessage(BaseModel):
    sender: str
    receiver: str
    task_id: str
    message_type: Literal["task", "result", "error"]
    payload: dict
    timestamp: datetime

# Orchestrator decomposition
class Orchestrator:
    async def process(self, query: str):
        plan = await self.decompose(query)  # LLM call to break into sub-tasks
        tasks = [self.delegate(agent, task) for agent, task in plan]
        results = await asyncio.gather(*tasks, return_exceptions=True)
        # Filter failures, retry if needed
        valid = [r for r in results if not isinstance(r, Exception)]
        return await self.synthesize(query, valid)
```

**Framework choice:** LangGraph — provides state machine semantics ideal for orchestration, with built-in retry and conditional routing.

**Docker setup:**
- `docker-compose.yml` with services: api, redis (message queue), worker
- Each agent runs as async task within worker process (not separate containers — overhead not justified for this scale)

## Part C: Evaluation

### Results Table

| Metric | Single Agent | Multi-Agent | Delta |
|--------|-------------|-------------|-------|
| Task Completion | 68% | 88% | +20% |
| Avg Latency | 4.2s | 7.8s | +3.6s |
| Token Usage | 2,100 | 4,800 | +2,700 |
| Answer Quality (1-5) | 3.2 | 4.1 | +0.9 |

**Analysis:**
- Multi-agent excels on complex, multi-step queries requiring synthesis
- Single agent is faster and cheaper for simple factual questions
- The latency increase is primarily from sequential orchestrator→agent→orchestrator round trips
- Token overhead comes from structured message passing and orchestrator reasoning
- **Recommendation:** Use model routing — simple queries go to single agent, complex to multi-agent
