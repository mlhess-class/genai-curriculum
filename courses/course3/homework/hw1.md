# Homework 1: LangChain Foundations & LLM Integration

**Due:** End of Week 3 | **Points:** 100 | **Weight:** ~6.7% of final grade

## Objectives
- Set up a LangChain development environment
- Invoke LLMs using LCEL (LangChain Expression Language)
- Compare provider APIs: OpenAI, Anthropic, and Ollama
- Implement streaming and batch operations

---

## Part 1: Environment Setup (10 pts)

Create a new Python project with the following structure:

```
hw1/
├── pyproject.toml   # or requirements.txt
├── .env             # API keys (DO NOT COMMIT)
├── src/
│   ├── basic_invoke.py
│   ├── multi_provider.py
│   ├── streaming.py
│   └── batch_ops.py
└── tests/
    └── test_hw1.py
```

**Requirements:**
- Python 3.11+
- `langchain>=0.2.0`, `langchain-openai`, `langchain-anthropic`, `langchain-community`
- Use `python-dotenv` for API key management

## Part 2: Basic LLM Invocation with LCEL (25 pts)

In `basic_invoke.py`, implement the following:

```python
from langchain_openai import ChatOpenAI
from langchain_core.messages import HumanMessage, SystemMessage

# TODO: Create a function that takes a topic and returns a summary
def summarize_topic(topic: str, max_words: int = 100) -> str:
    """
    Use ChatOpenAI with gpt-4o-mini to summarize a topic.
    The system message should instruct the model to be concise.
    
    Args:
        topic: The topic to summarize
        max_words: Maximum word count for the summary
    
    Returns:
        A string summary of the topic
    """
    pass

# TODO: Create an LCEL chain that classifies text sentiment
def classify_sentiment(text: str) -> dict:
    """
    Build an LCEL chain: prompt | model | parser
    Return a dict with keys: sentiment (positive/negative/neutral), confidence (0-1)
    
    Use ChatOpenAI and a PydanticOutputParser.
    """
    pass
```

**Expected output for `summarize_topic("quantum computing")`:**
```
A concise 50-100 word summary about quantum computing...
```

**Expected output for `classify_sentiment("This product is amazing!")`:**
```python
{"sentiment": "positive", "confidence": 0.95}
```

## Part 3: Multi-Provider Comparison (30 pts)

In `multi_provider.py`, implement:

```python
from langchain_openai import ChatOpenAI
from langchain_anthropic import ChatAnthropic
from langchain_community.chat_models import ChatOllama
import time

def compare_providers(prompt: str) -> list[dict]:
    """
    Send the same prompt to OpenAI (gpt-4o-mini), Anthropic (claude-3-haiku),
    and Ollama (llama3.1:8b). Measure latency for each.
    
    Returns a list of dicts:
    [
        {"provider": "openai", "response": "...", "latency_ms": 523, "tokens": 87},
        {"provider": "anthropic", "response": "...", "latency_ms": 612, "tokens": 92},
        {"provider": "ollama", "response": "...", "latency_ms": 1834, "tokens": 78},
    ]
    
    Handle errors gracefully - if a provider is unavailable, include
    {"provider": "xxx", "error": "...", "latency_ms": 0, "tokens": 0}
    """
    pass

def create_fallback_chain():
    """
    Create an LCEL chain with fallbacks:
    Try OpenAI first -> fall back to Anthropic -> fall back to Ollama.
    
    Use the .with_fallbacks() method.
    Return the chain (don't invoke it).
    """
    pass
```

## Part 4: Streaming Implementation (20 pts)

In `streaming.py`:

```python
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate

async def stream_story(topic: str) -> None:
    """
    Create an LCEL chain that generates a short story about `topic`.
    Stream the output token by token, printing each chunk as it arrives.
    
    Use astream() for async streaming.
    Track and print the total token count at the end.
    """
    pass

def stream_with_callbacks(topic: str) -> str:
    """
    Same as above but synchronous, using the streaming=True parameter
    and collecting all chunks into a final string.
    
    Print each chunk as it arrives AND return the complete string.
    """
    pass
```

## Part 5: Batch Operations (15 pts)

In `batch_ops.py`:

```python
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate

def batch_classify(texts: list[str]) -> list[str]:
    """
    Classify a list of texts into categories:
    [tech, science, sports, politics, entertainment, other]
    
    Use chain.batch() with max_concurrency=3.
    
    Args:
        texts: List of text snippets to classify
    Returns:
        List of category strings
    """
    pass
```

**Test with:**
```python
texts = [
    "The new iPhone 16 features an A18 chip",
    "Scientists discover high-temperature superconductor",
    "Lakers win NBA championship in overtime thriller",
    "Senate passes new climate legislation",
    "Taylor Swift announces world tour dates"
]
# Expected: ["tech", "science", "sports", "politics", "entertainment"]
```

---

## Rubric

| Component | Points | Criteria |
|-----------|--------|----------|
| Environment setup | 10 | Clean project structure, deps install, .env works |
| Basic invocation | 25 | Both functions work, LCEL patterns used correctly, Pydantic parser works |
| Multi-provider | 30 | All 3 providers called, latency measured, fallback chain correct |
| Streaming | 20 | Async streaming works, sync streaming works, token counting |
| Batch ops | 15 | batch() used correctly, max_concurrency set, results accurate |

**Deductions:**
- -5 pts: API keys hardcoded (not in .env)
- -5 pts: No error handling
- -10 pts: Not using LCEL patterns (using legacy chain syntax)
- -5 pts: No type hints

## Submission
Push to your course GitHub repo under `hw1/`. Include a `README.md` with:
- Setup instructions
- Example outputs (screenshots or terminal paste)
- Any challenges you encountered
