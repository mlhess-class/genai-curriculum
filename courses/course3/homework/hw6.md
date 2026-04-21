# Homework 6: Evaluation & Production Patterns

**Due:** End of Week 14 | **Points:** 100 | **Weight:** ~6.7% of final grade

## Objectives
- Evaluate LLM applications with LangSmith
- Implement production patterns: streaming, caching, cost management
- Build robust error handling and deployment configurations

---

## Part 1: LangSmith Evaluation (35 pts)

```python
# evaluation.py
from langsmith import Client
from langsmith.evaluation import evaluate
from langchain_openai import ChatOpenAI

def create_evaluation_dataset():
    """
    Create a LangSmith dataset with 20+ test cases for a Q&A RAG system.
    
    Each example should have:
    - input: question string
    - expected_output: reference answer
    - metadata: difficulty (easy/medium/hard), category
    
    Cover edge cases:
    - Questions answerable from context
    - Questions NOT answerable (should say "I don't know")
    - Multi-hop reasoning questions
    - Questions requiring numerical answers
    """
    client = Client()
    dataset = client.create_dataset("hw6-rag-eval", description="RAG evaluation dataset")
    
    examples = [
        {
            "input": "What is the maximum context window for GPT-4 Turbo?",
            "expected": "128,000 tokens",
            "metadata": {"difficulty": "easy", "category": "factual"}
        },
        # TODO: Add 19+ more examples covering all edge cases
    ]
    # TODO: Upload examples to dataset
    pass

def build_custom_evaluators():
    """
    Create 4 custom evaluators:
    
    1. answer_correctness: Compare generated answer to reference (use LLM-as-judge)
    2. faithfulness: Check if answer is grounded in retrieved context
    3. relevance: Score how relevant the answer is to the question (0-1)
    4. toxicity: Flag toxic or inappropriate outputs
    
    Each evaluator should return: {"key": str, "score": float, "comment": str}
    """
    pass

def run_evaluation(chain, dataset_name: str) -> dict:
    """
    Run evaluation using langsmith.evaluation.evaluate().
    
    Configure:
    - All 4 custom evaluators
    - 3 concurrent workers
    - Store results in LangSmith project "hw6-eval"
    
    Return summary with mean scores for each metric.
    """
    pass
```

## Part 2: Streaming Implementation (20 pts)

```python
# streaming.py
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser
from fastapi import FastAPI
from fastapi.responses import StreamingResponse

app = FastAPI()

def build_streaming_chain():
    """Build an LCEL chain configured for streaming."""
    prompt = ChatPromptTemplate.from_messages([
        ("system", "You are a helpful assistant."),
        ("human", "{question}")
    ])
    model = ChatOpenAI(model="gpt-4o-mini", streaming=True)
    return prompt | model | StrOutputParser()

@app.post("/chat/stream")
async def chat_stream(question: str):
    """
    FastAPI endpoint that streams LLM responses as Server-Sent Events.
    
    Use chain.astream() to yield chunks.
    Format as SSE: "data: {chunk}\n\n"
    Send "data: [DONE]\n\n" when complete.
    """
    chain = build_streaming_chain()
    
    async def event_generator():
        async for chunk in chain.astream({"question": question}):
            yield f"data: {chunk}\n\n"
        yield "data: [DONE]\n\n"
    
    return StreamingResponse(event_generator(), media_type="text/event-stream")

@app.post("/chat/stream-events")
async def chat_stream_events(question: str):
    """
    Use astream_events() v2 to stream structured events:
    - on_chat_model_start
    - on_chat_model_stream  
    - on_chat_model_end
    
    Return events as JSON stream with type, content, and metadata.
    """
    pass
```

## Part 3: Caching & Cost Management (25 pts)

```python
# caching.py
from langchain_core.globals import set_llm_cache
from langchain_community.cache import SQLiteCache, InMemoryCache
from langchain_openai import ChatOpenAI
from langchain_core.callbacks import BaseCallbackHandler
import tiktoken

def setup_sqlite_cache(db_path: str = ".langchain_cache.db"):
    """Set up SQLite-based LLM response cache."""
    set_llm_cache(SQLiteCache(database_path=db_path))

class CostTracker(BaseCallbackHandler):
    """
    Callback handler that tracks API costs per model.
    
    Track:
    - Total tokens (prompt + completion) per call
    - Estimated cost in USD (use current pricing)
    - Cumulative totals across calls
    - Per-model breakdown
    
    Pricing (per 1M tokens):
    - gpt-4o-mini: $0.15 input / $0.60 output
    - gpt-4o: $2.50 input / $10.00 output
    - claude-3-haiku: $0.25 input / $1.25 output
    """
    
    def __init__(self):
        self.calls = []
        self.total_cost = 0.0
        self.total_tokens = {"prompt": 0, "completion": 0}
    
    def on_llm_end(self, response, **kwargs):
        # TODO: Extract token counts from response
        # TODO: Calculate cost based on model
        # TODO: Log the call
        pass
    
    def get_report(self) -> dict:
        """Return cost report with per-model breakdown."""
        pass

def count_tokens(text: str, model: str = "gpt-4o-mini") -> int:
    """Count tokens using tiktoken."""
    enc = tiktoken.encoding_for_model(model)
    return len(enc.encode(text))

class BudgetLimiter:
    """
    Middleware that enforces a budget limit.
    
    - Set max budget in USD
    - Track spending via CostTracker
    - Raise BudgetExceededError when limit reached
    - Support per-query and total budget limits
    """
    
    def __init__(self, max_budget_usd: float = 1.0, max_per_query_usd: float = 0.05):
        pass
    
    def check_budget(self, estimated_tokens: int, model: str) -> bool:
        pass
    
    def wrap_chain(self, chain):
        """Wrap an LCEL chain with budget checking."""
        pass
```

## Part 4: Error Handling & Retry Logic (20 pts)

```python
# error_handling.py
from langchain_core.runnables import RunnableConfig
from langchain_core.runnables.retry import RunnableRetry
import asyncio

def build_resilient_chain():
    """
    Build a chain with production-grade error handling:
    
    1. Retry logic: max 3 retries with exponential backoff (1s, 2s, 4s)
    2. Timeout: 30 second max per LLM call
    3. Fallback: if primary model fails, use fallback model
    4. Rate limiting: max 10 requests per minute
    5. Circuit breaker: after 5 consecutive failures, fail fast for 60s
    
    Use RunnableRetry and .with_fallbacks() and .with_config()
    """
    pass

class CircuitBreaker:
    """
    Circuit breaker pattern for LLM calls.
    
    States: CLOSED (normal) -> OPEN (failing) -> HALF_OPEN (testing)
    
    - CLOSED: calls pass through normally
    - OPEN: calls fail immediately (fast fail)
    - HALF_OPEN: allow one test call to check if service recovered
    
    Transitions:
    - CLOSED -> OPEN: after `failure_threshold` consecutive failures
    - OPEN -> HALF_OPEN: after `recovery_timeout` seconds
    - HALF_OPEN -> CLOSED: if test call succeeds
    - HALF_OPEN -> OPEN: if test call fails
    """
    
    def __init__(self, failure_threshold: int = 5, recovery_timeout: int = 60):
        pass
    
    async def call(self, func, *args, **kwargs):
        pass
```

---

## Rubric

| Component | Points | Criteria |
|-----------|--------|----------|
| LangSmith evaluation | 35 | Dataset created, 4 evaluators work, evaluation runs |
| Streaming | 20 | SSE endpoint works, astream_events implemented |
| Caching & cost | 25 | Cache works, CostTracker accurate, BudgetLimiter enforces limits |
| Error handling | 20 | Retry + fallback + circuit breaker all implemented |

## Submission
Push to `hw6/` with cost report output and evaluation results in README.
