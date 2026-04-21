# HW2 Answer Key: Prompt Engineering & Output Parsing

## Part 1: Advanced Prompt Templates (30 pts)

```python
# prompt_templates.py
from langchain_core.prompts import (
    ChatPromptTemplate, FewShotChatMessagePromptTemplate, MessagesPlaceholder
)
from langchain_openai import ChatOpenAI
from langchain_core.output_parsers import StrOutputParser

def build_few_shot_classifier() -> ChatPromptTemplate:
    examples = [
        {"ticket": "I was charged twice for my subscription", "output": "category: billing\nconfidence: 0.95\nreasoning: Duplicate charge is a billing issue"},
        {"ticket": "The app crashes when I upload photos", "output": "category: technical\nconfidence: 0.92\nreasoning: App crash is a technical bug"},
        {"ticket": "I need to change my email address on file", "output": "category: account\nconfidence: 0.90\nreasoning: Email change is account management"},
    ]
    
    example_prompt = ChatPromptTemplate.from_messages([
        ("human", "{ticket}"),
        ("ai", "{output}"),
    ])
    
    few_shot = FewShotChatMessagePromptTemplate(
        example_prompt=example_prompt,
        examples=examples,
    )
    
    final_prompt = ChatPromptTemplate.from_messages([
        ("system", "You are a customer support ticket classifier. Classify tickets into: billing, technical, account, feature_request, other. Provide category, confidence (0-1), and brief reasoning."),
        few_shot,
        ("human", "{ticket}"),
    ])
    
    return final_prompt


def build_dynamic_prompt(context_type: str) -> ChatPromptTemplate:
    system_messages = {
        "technical": "You are a technical expert. Use precise terminology, reference specifications, and be detailed.",
        "casual": "You are a friendly helper. Use simple language, analogies, and keep it conversational.",
        "academic": "You are an academic researcher. Use formal language, cite relevant literature, and be thorough.",
    }
    
    system_msg = system_messages.get(context_type, system_messages["casual"])
    
    return ChatPromptTemplate.from_messages([
        ("system", system_msg),
        MessagesPlaceholder(variable_name="chat_history", optional=True),
        ("human", "{question}"),
    ])
```

**Grading notes:**
- -5 if fewer than 3 few-shot examples
- -5 if MessagesPlaceholder not used for history
- -3 if examples don't use proper ChatPromptTemplate format

---

## Part 2: Pydantic Output Parsers (30 pts)

```python
# output_parsers.py
from langchain_core.output_parsers import PydanticOutputParser, JsonOutputParser
from langchain_core.prompts import ChatPromptTemplate
from langchain_openai import ChatOpenAI
from langchain.output_parsers import OutputFixingParser
from pydantic import BaseModel, Field, validator
from typing import Literal

class MovieReview(BaseModel):
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
    parser = PydanticOutputParser(pydantic_object=MovieReview)
    
    prompt = ChatPromptTemplate.from_messages([
        ("system", "You are a movie critic. Analyze the given movie and provide a structured review.\n{format_instructions}"),
        ("human", "Review the movie: {movie_name}")
    ])
    
    model = ChatOpenAI(model="gpt-4o-mini", temperature=0.3)
    
    chain = prompt | model | parser
    
    try:
        result = chain.invoke({
            "movie_name": movie_name,
            "format_instructions": parser.get_format_instructions()
        })
        return result
    except Exception:
        # Fallback to OutputFixingParser
        fixing_parser = OutputFixingParser.from_llm(parser=parser, llm=model)
        chain_fixed = prompt | model | fixing_parser
        return chain_fixed.invoke({
            "movie_name": movie_name,
            "format_instructions": parser.get_format_instructions()
        })


class ExtractedEntities(BaseModel):
    people: list[str] = Field(default_factory=list)
    organizations: list[str] = Field(default_factory=list)
    locations: list[str] = Field(default_factory=list)
    dates: list[str] = Field(default_factory=list)
    monetary_values: list[str] = Field(default_factory=list)


def extract_entities(text: str) -> ExtractedEntities:
    parser = JsonOutputParser(pydantic_object=ExtractedEntities)
    
    prompt = ChatPromptTemplate.from_messages([
        ("system", "Extract named entities from the text.\n{format_instructions}"),
        ("human", "{text}")
    ])
    
    model = ChatOpenAI(model="gpt-4o-mini", temperature=0)
    chain = prompt | model | parser
    
    max_retries = 2
    for attempt in range(max_retries + 1):
        try:
            result = chain.invoke({
                "text": text,
                "format_instructions": parser.get_format_instructions()
            })
            return ExtractedEntities(**result)
        except Exception as e:
            if attempt == max_retries:
                raise ValueError(f"Failed to parse entities after {max_retries + 1} attempts: {e}")
```

---

## Part 3: Sequential Chains (25 pts)

```python
# chains.py
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain_core.runnables import RunnablePassthrough, RunnableParallel, RunnableBranch, RunnableLambda
from langchain_openai import ChatOpenAI

def build_research_chain():
    model = ChatOpenAI(model="gpt-4o-mini", temperature=0.5)
    
    # Step 1: Generate questions
    q_prompt = ChatPromptTemplate.from_messages([
        ("system", "Generate exactly 3 research questions about the given topic. Return them numbered 1-3, one per line."),
        ("human", "{topic}")
    ])
    
    # Step 2: Answer each question
    a_prompt = ChatPromptTemplate.from_messages([
        ("system", "Answer this research question concisely in 2-3 sentences."),
        ("human", "{question}")
    ])
    answer_chain = a_prompt | model | StrOutputParser()
    
    # Step 3: Synthesize
    s_prompt = ChatPromptTemplate.from_messages([
        ("system", "Synthesize the following Q&A pairs into a coherent research summary paragraph."),
        ("human", "Questions and Answers:\n{qa_pairs}")
    ])
    
    def generate_and_answer(inputs):
        topic = inputs["topic"]
        q_chain = q_prompt | model | StrOutputParser()
        questions_text = q_chain.invoke({"topic": topic})
        questions = [q.strip().lstrip("0123456789.) ") for q in questions_text.strip().split("\n") if q.strip()][:3]
        
        answers = answer_chain.batch([{"question": q} for q in questions])
        
        qa_pairs = "\n\n".join([f"Q: {q}\nA: {a}" for q, a in zip(questions, answers)])
        
        summary_chain = s_prompt | model | StrOutputParser()
        summary = summary_chain.invoke({"qa_pairs": qa_pairs})
        
        return {"questions": questions, "answers": answers, "summary": summary}
    
    return RunnableLambda(generate_and_answer)


def build_router_chain():
    model = ChatOpenAI(model="gpt-4o-mini", temperature=0.3)
    
    code_prompt = ChatPromptTemplate.from_messages([
        ("system", "You are a code reviewer. Analyze code quality and suggest improvements."),
        ("human", "{content}")
    ])
    text_prompt = ChatPromptTemplate.from_messages([
        ("system", "Summarize and extract key points from the text."),
        ("human", "{content}")
    ])
    data_prompt = ChatPromptTemplate.from_messages([
        ("system", "Describe this dataset and suggest visualizations."),
        ("human", "{content}")
    ])
    
    code_chain = code_prompt | model | StrOutputParser()
    text_chain = text_prompt | model | StrOutputParser()
    data_chain = data_prompt | model | StrOutputParser()
    
    branch = RunnableBranch(
        (lambda x: x["input_type"] == "code", code_chain),
        (lambda x: x["input_type"] == "text", text_chain),
        (lambda x: x["input_type"] == "data", data_chain),
        text_chain,  # default
    )
    
    return branch
```

**Common bugs:**
- Using deprecated `SequentialChain` instead of LCEL `|`
- Not passing data between steps correctly
- RunnableBranch conditions must be callables, not strings

---

## Part 4: Transform Chain (15 pts)

```python
# transform.py
from langchain_core.runnables import RunnableLambda
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain_openai import ChatOpenAI
import re

def clean_text(input_dict: dict) -> dict:
    text = input_dict["text"]
    text = re.sub(r'\s+', ' ', text).strip()
    text = text.encode('utf-8', errors='ignore').decode('utf-8')
    input_dict["cleaned_text"] = text
    return input_dict

def detect_language(input_dict: dict) -> dict:
    text = input_dict["cleaned_text"]
    # Simple heuristic; production would use langdetect
    ascii_ratio = sum(1 for c in text if ord(c) < 128) / max(len(text), 1)
    input_dict["language"] = "en" if ascii_ratio > 0.9 else "unknown"
    return input_dict

def add_translation_instruction(input_dict: dict) -> dict:
    if input_dict["language"] != "en":
        input_dict["cleaned_text"] = f"[Translate to English first, then process]: {input_dict['cleaned_text']}"
    return input_dict

def format_as_markdown(text: str) -> str:
    lines = text.strip().split('\n')
    formatted = f"## Analysis\n\n{text.strip()}\n"
    return formatted

def build_preprocessing_chain():
    model = ChatOpenAI(model="gpt-4o-mini", temperature=0.3)
    prompt = ChatPromptTemplate.from_messages([
        ("system", "Analyze the following text. Provide key insights."),
        ("human", "{cleaned_text}")
    ])
    
    chain = (
        RunnableLambda(clean_text)
        | RunnableLambda(detect_language)
        | RunnableLambda(add_translation_instruction)
        | prompt
        | model
        | StrOutputParser()
        | RunnableLambda(format_as_markdown)
    )
    return chain
```
