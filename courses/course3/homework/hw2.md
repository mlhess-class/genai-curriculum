# Homework 2: Prompt Engineering & Output Parsing

**Due:** End of Week 5 | **Points:** 100 | **Weight:** ~6.7% of final grade

## Objectives
- Master ChatPromptTemplate and few-shot prompting
- Build robust output parsers with Pydantic
- Construct sequential and router chains using LCEL

---

## Part 1: Advanced Prompt Templates (30 pts)

```python
# prompt_templates.py
from langchain_core.prompts import (
    ChatPromptTemplate, FewShotChatMessagePromptTemplate,
    MessagesPlaceholder
)
from langchain_openai import ChatOpenAI

def build_few_shot_classifier() -> ChatPromptTemplate:
    """
    Build a few-shot prompt for classifying customer support tickets.
    
    Categories: billing, technical, account, feature_request, other
    
    Provide at least 3 examples. The prompt should:
    1. Include a system message with role instructions
    2. Use FewShotChatMessagePromptTemplate with example_prompt
    3. Accept a 'ticket' input variable
    4. Return category + confidence + brief reasoning
    
    Return the complete prompt template (don't invoke).
    """
    pass

def build_dynamic_prompt(context_type: str) -> ChatPromptTemplate:
    """
    Build a prompt that adapts based on context_type.
    
    If context_type == "technical": use technical jargon, be precise
    If context_type == "casual": use simple language, be friendly  
    If context_type == "academic": use formal language, cite sources
    
    The prompt should accept 'question' as input and include
    a MessagesPlaceholder for chat history.
    """
    pass
```

## Part 2: Pydantic Output Parsers (30 pts)

```python
# output_parsers.py
from langchain_core.output_parsers import PydanticOutputParser, JsonOutputParser
from langchain_core.pydantic_v1 import BaseModel, Field, validator
from typing import Literal

class MovieReview(BaseModel):
    """Structured movie review output."""
    title: str = Field(description="Movie title")
    rating: float = Field(description="Rating from 0-10", ge=0, le=10)
    genre: list[str] = Field(description="List of genres")
    sentiment: Literal["positive", "negative", "mixed"] = Field(description="Overall sentiment")
    summary: str = Field(description="One-paragraph review summary")
    recommended: bool = Field(description="Whether you'd recommend this movie")
    
    @validator("rating")
    def round_rating(cls, v):
        return round(v, 1)

def analyze_movie(movie_name: str) -> MovieReview:
    """
    Build an LCEL chain: prompt | model | PydanticOutputParser
    
    The prompt should include format_instructions from the parser.
    Use gpt-4o-mini. Parse the output into a MovieReview object.
    
    Handle parsing errors with OutputFixingParser as fallback.
    """
    pass

class ExtractedEntities(BaseModel):
    """Named entities extracted from text."""
    people: list[str] = Field(default_factory=list)
    organizations: list[str] = Field(default_factory=list)
    locations: list[str] = Field(default_factory=list)
    dates: list[str] = Field(default_factory=list)
    monetary_values: list[str] = Field(default_factory=list)

def extract_entities(text: str) -> ExtractedEntities:
    """
    Extract named entities from arbitrary text.
    Use JsonOutputParser with the ExtractedEntities schema.
    Include retry logic with max 2 retries on parse failure.
    """
    pass
```

## Part 3: Sequential Chains (25 pts)

```python
# chains.py
from langchain_core.runnables import RunnablePassthrough, RunnableParallel

def build_research_chain():
    """
    Build a 3-step sequential chain using LCEL pipe syntax:
    
    Step 1: Generate 3 research questions about a topic
    Step 2: For each question, generate a brief answer (use RunnableParallel)
    Step 3: Synthesize all Q&A pairs into a research summary
    
    Input: {"topic": "..."}
    Output: {"questions": [...], "answers": [...], "summary": "..."}
    
    Use RunnablePassthrough to carry forward intermediate results.
    """
    pass

def build_router_chain():
    """
    Build a router chain that routes to different processing chains
    based on the input type:
    
    - "code" -> code review chain (analyze code quality, suggest improvements)
    - "text" -> text analysis chain (summarize, extract key points)  
    - "data" -> data analysis chain (describe dataset, suggest visualizations)
    
    Use RunnableBranch for routing.
    Input: {"input_type": "code"|"text"|"data", "content": "..."}
    """
    pass
```

## Part 4: Transform Chain (15 pts)

```python
# transform.py
from langchain_core.runnables import RunnableLambda

def build_preprocessing_chain():
    """
    Build a chain that preprocesses text before sending to an LLM:
    
    1. RunnableLambda: Clean text (remove extra whitespace, fix encoding)
    2. RunnableLambda: Detect language (return lang code)
    3. RunnableLambda: If not English, prepend translation instruction
    4. Prompt | Model: Process the cleaned text
    5. RunnableLambda: Post-process (format as markdown)
    
    Chain everything with | operator.
    """
    pass
```

---

## Rubric

| Component | Points | Criteria |
|-----------|--------|----------|
| Few-shot & dynamic prompts | 30 | Correct template structure, examples work, MessagesPlaceholder used |
| Output parsers | 30 | Pydantic models correct, parsers work, error handling included |
| Sequential chains | 25 | LCEL pipe syntax, RunnableParallel used, data flows correctly |
| Transform chain | 15 | RunnableLambda used, preprocessing logic sound, chain composes |

## Submission
Push to `hw2/` with working code and example outputs in README.
