# Homework 5: Memory Systems & LangGraph

**Due:** End of Week 12 | **Points:** 100 | **Weight:** ~6.7% of final grade

## Objectives
- Implement and compare LangChain memory systems
- Build stateful workflows with LangGraph
- Create persistent conversation agents

---

## Part 1: Memory Implementations (30 pts)

```python
# memory_systems.py
from langchain.memory import (
    ConversationBufferMemory,
    ConversationSummaryMemory,
    ConversationBufferWindowMemory,
    ConversationEntityMemory
)
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder

def build_buffer_memory_chain():
    """
    Build a conversational chain with ConversationBufferMemory.
    
    - Stores full message history
    - Uses MessagesPlaceholder for history injection
    - Demonstrate that it remembers exact earlier messages
    
    Return: (chain, memory) tuple
    """
    pass

def build_summary_memory_chain():
    """
    Build a chain with ConversationSummaryMemory.
    
    - Uses gpt-4o-mini to summarize conversation history
    - Show token savings vs buffer memory after 10+ exchanges
    - Print the running summary after each exchange
    
    Return: (chain, memory) tuple
    """
    pass

def build_entity_memory_chain():
    """
    Build a chain with ConversationEntityMemory.
    
    - Tracks entities mentioned in conversation
    - Can recall facts about specific people/things
    - Print entity store after each exchange
    
    Return: (chain, memory) tuple
    """
    pass

def compare_memory_systems(conversation: list[str]) -> dict:
    """
    Run the same conversation through all 3 memory systems.
    
    Compare:
    - Token usage per turn
    - Recall accuracy (can it answer questions about earlier turns?)
    - Memory size growth over time
    
    conversation: list of alternating user messages
    
    Return: {
        "buffer": {"tokens_per_turn": [...], "total_tokens": int, "recall_score": float},
        "summary": {"tokens_per_turn": [...], "total_tokens": int, "recall_score": float},
        "entity": {"tokens_per_turn": [...], "total_tokens": int, "recall_score": float},
    }
    """
    pass
```

## Part 2: Persistent Memory (20 pts)

```python
# persistent_memory.py
import json
from pathlib import Path

class FileChatMemory:
    """
    Custom persistent memory that saves to JSON files.
    
    Implement:
    - save_context(input, output) -> appends to file
    - load_memory_variables() -> loads from file
    - clear() -> resets file
    - get_summary(llm) -> summarizes stored history
    
    File format:
    {
        "session_id": "...",
        "created_at": "...",
        "messages": [
            {"role": "human", "content": "...", "timestamp": "..."},
            {"role": "ai", "content": "...", "timestamp": "..."}
        ]
    }
    """
    
    def __init__(self, session_id: str, storage_dir: str = "./chat_history"):
        pass
    
    def save_context(self, input_msg: str, output_msg: str):
        pass
    
    def load_memory_variables(self) -> dict:
        pass
    
    def clear(self):
        pass
    
    def get_summary(self, llm) -> str:
        pass
```

## Part 3: LangGraph Workflows (35 pts)

```python
# langgraph_workflow.py
from langgraph.graph import StateGraph, END
from typing import TypedDict, Annotated, Sequence
from langchain_core.messages import BaseMessage
import operator

# State definition
class AgentState(TypedDict):
    messages: Annotated[Sequence[BaseMessage], operator.add]
    current_step: str
    research_data: str
    draft: str
    review_feedback: str
    final_output: str
    iteration_count: int

def build_writing_workflow() -> StateGraph:
    """
    Build a LangGraph workflow for an AI writing assistant:
    
    Nodes:
    1. research: Gather information about the topic
    2. outline: Create an outline from research
    3. draft: Write a first draft
    4. review: Self-review the draft for quality
    5. revise: Revise based on review feedback
    6. finalize: Polish and format the final output
    
    Edges:
    - research -> outline -> draft -> review
    - review -> revise (if quality < threshold) 
    - review -> finalize (if quality >= threshold)
    - revise -> review (loop back, max 3 iterations)
    
    Each node should use an LLM call with appropriate prompting.
    Use conditional edges for the review decision.
    """
    pass

def build_customer_support_workflow() -> StateGraph:
    """
    Build a customer support workflow:
    
    1. classify: Determine ticket type (billing/technical/account/other)
    2. route: Send to appropriate specialist node
    3. billing_handler: Handle billing issues
    4. technical_handler: Handle technical issues  
    5. account_handler: Handle account issues
    6. escalate: Escalate complex issues to human
    7. respond: Generate final response
    
    Include conditional routing based on classification.
    Include escalation when confidence < 0.7.
    """
    pass
```

## Part 4: LangGraph with Checkpointing (15 pts)

```python
# checkpointing.py
from langgraph.checkpoint.sqlite import SqliteSaver

def build_persistent_workflow():
    """
    Extend the writing workflow with checkpointing:
    
    1. Use SqliteSaver for checkpoint storage
    2. Enable interruption and resumption mid-workflow
    3. Implement a "human-in-the-loop" step after review:
       - Pause workflow
       - Present draft to user
       - Resume with user's feedback
    
    Demonstrate:
    - Starting a workflow
    - Interrupting at the review step
    - Resuming with user feedback
    - Completing the workflow
    """
    pass
```

---

## Rubric

| Component | Points | Criteria |
|-----------|--------|----------|
| Memory implementations | 30 | 3 types work, comparison metrics calculated, recall tested |
| Persistent memory | 20 | File I/O works, session management, summary generation |
| LangGraph workflows | 35 | Both workflows compile and run, conditional edges work, loops bounded |
| Checkpointing | 15 | Persistence works, human-in-the-loop demonstrated |

## Submission
Push to `hw5/` with workflow diagrams (use `graph.get_graph().draw_mermaid()`) and example runs.
