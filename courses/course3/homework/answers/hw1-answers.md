# HW1 Answer Key: LangChain Foundations & LLM Integration

## Part 1: Environment Setup (10 pts)

**requirements.txt:**
```
langchain>=0.2.0
langchain-openai>=0.1.0
langchain-anthropic>=0.1.0
langchain-community>=0.2.0
python-dotenv>=1.0.0
```

**.env:**
```
OPENAI_API_KEY=sk-...
ANTHROPIC_API_KEY=sk-ant-...
```

Full points: project structure matches spec, `pip install -r requirements.txt` runs clean, .env present with placeholder keys.

---

## Part 2: Basic LLM Invocation (25 pts)

```python
# basic_invoke.py
from langchain_openai import ChatOpenAI
from langchain_core.messages import HumanMessage, SystemMessage
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import PydanticOutputParser
from pydantic import BaseModel, Field
from dotenv import load_dotenv

load_dotenv()

def summarize_topic(topic: str, max_words: int = 100) -> str:
    model = ChatOpenAI(model="gpt-4o-mini", temperature=0.3)
    messages = [
        SystemMessage(content=f"You are a concise summarizer. Summarize topics in {max_words} words or fewer."),
        HumanMessage(content=f"Summarize: {topic}")
    ]
    response = model.invoke(messages)
    return response.content


class SentimentResult(BaseModel):
    sentiment: str = Field(description="One of: positive, negative, neutral")
    confidence: float = Field(description="Confidence score from 0 to 1", ge=0, le=1)


def classify_sentiment(text: str) -> dict:
    parser = PydanticOutputParser(pydantic_object=SentimentResult)
    
    prompt = ChatPromptTemplate.from_messages([
        ("system", "Classify the sentiment of the text. {format_instructions}"),
        ("human", "{text}")
    ])
    
    model = ChatOpenAI(model="gpt-4o-mini", temperature=0)
    
    chain = prompt | model | parser
    result = chain.invoke({
        "text": text,
        "format_instructions": parser.get_format_instructions()
    })
    return result.dict()


if __name__ == "__main__":
    print(summarize_topic("quantum computing"))
    print(classify_sentiment("This product is amazing!"))
```

**Grading notes:**
- -5 if not using LCEL pipe syntax for classify_sentiment
- -3 if PydanticOutputParser not used (raw string parsing instead)
- -2 if format_instructions not injected into prompt

---

## Part 3: Multi-Provider Comparison (30 pts)

```python
# multi_provider.py
from langchain_openai import ChatOpenAI
from langchain_anthropic import ChatAnthropic
from langchain_community.chat_models import ChatOllama
from langchain_core.messages import HumanMessage
import time
from dotenv import load_dotenv

load_dotenv()

def compare_providers(prompt: str) -> list[dict]:
    providers = [
        ("openai", ChatOpenAI(model="gpt-4o-mini", temperature=0)),
        ("anthropic", ChatAnthropic(model="claude-3-haiku-20240307", temperature=0)),
        ("ollama", ChatOllama(model="llama3.1:8b", temperature=0)),
    ]
    
    results = []
    for name, model in providers:
        try:
            start = time.time()
            response = model.invoke([HumanMessage(content=prompt)])
            latency = int((time.time() - start) * 1000)
            
            token_usage = response.response_metadata.get("token_usage", {})
            total_tokens = token_usage.get("total_tokens", 0)
            
            results.append({
                "provider": name,
                "response": response.content,
                "latency_ms": latency,
                "tokens": total_tokens,
            })
        except Exception as e:
            results.append({
                "provider": name,
                "error": str(e),
                "latency_ms": 0,
                "tokens": 0,
            })
    
    return results


def create_fallback_chain():
    primary = ChatOpenAI(model="gpt-4o-mini")
    fallback1 = ChatAnthropic(model="claude-3-haiku-20240307")
    fallback2 = ChatOllama(model="llama3.1:8b")
    
    chain = primary.with_fallbacks([fallback1, fallback2])
    return chain


if __name__ == "__main__":
    results = compare_providers("Explain quantum entanglement in 2 sentences.")
    for r in results:
        print(f"{r['provider']}: {r.get('response', r.get('error', 'N/A'))[:100]}... ({r['latency_ms']}ms)")
```

**Common bugs:**
- Ollama not running locally → should be caught by try/except
- `response_metadata` key varies by provider — Anthropic uses `usage`, OpenAI uses `token_usage`
- Students forget `load_dotenv()` and get auth errors

---

## Part 4: Streaming (20 pts)

```python
# streaming.py
import asyncio
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser

async def stream_story(topic: str) -> None:
    prompt = ChatPromptTemplate.from_messages([
        ("system", "You are a creative storyteller. Write a short 3-paragraph story."),
        ("human", "Write a story about: {topic}")
    ])
    model = ChatOpenAI(model="gpt-4o-mini", streaming=True)
    chain = prompt | model | StrOutputParser()
    
    total_chars = 0
    async for chunk in chain.astream({"topic": topic}):
        print(chunk, end="", flush=True)
        total_chars += len(chunk)
    
    print(f"\n\n--- Total characters: {total_chars} ---")


def stream_with_callbacks(topic: str) -> str:
    prompt = ChatPromptTemplate.from_messages([
        ("system", "You are a creative storyteller. Write a short 3-paragraph story."),
        ("human", "Write a story about: {topic}")
    ])
    model = ChatOpenAI(model="gpt-4o-mini", streaming=True)
    chain = prompt | model | StrOutputParser()
    
    collected = []
    for chunk in chain.stream({"topic": topic}):
        print(chunk, end="", flush=True)
        collected.append(chunk)
    
    complete = "".join(collected)
    print(f"\n\n--- Total length: {len(complete)} chars ---")
    return complete


if __name__ == "__main__":
    asyncio.run(stream_story("a robot learning to paint"))
    print("\n" + "="*50 + "\n")
    stream_with_callbacks("a cat in space")
```

---

## Part 5: Batch Operations (15 pts)

```python
# batch_ops.py
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser

def batch_classify(texts: list[str]) -> list[str]:
    prompt = ChatPromptTemplate.from_messages([
        ("system", "Classify the text into exactly one category: tech, science, sports, politics, entertainment, other. Respond with only the category word."),
        ("human", "{text}")
    ])
    model = ChatOpenAI(model="gpt-4o-mini", temperature=0)
    chain = prompt | model | StrOutputParser()
    
    inputs = [{"text": t} for t in texts]
    results = chain.batch(inputs, config={"max_concurrency": 3})
    
    return [r.strip().lower() for r in results]


if __name__ == "__main__":
    texts = [
        "The new iPhone 16 features an A18 chip",
        "Scientists discover high-temperature superconductor",
        "Lakers win NBA championship in overtime thriller",
        "Senate passes new climate legislation",
        "Taylor Swift announces world tour dates"
    ]
    categories = batch_classify(texts)
    for text, cat in zip(texts, categories):
        print(f"  {cat:15s} | {text}")
```

**Grading notes:**
- -5 if using a loop with individual invoke() calls instead of batch()
- -3 if max_concurrency not set
- -2 if no post-processing (strip/lower) on results
