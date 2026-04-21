# HW5 Answer Key: Memory Systems & LangGraph

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
from langchain_core.output_parsers import StrOutputParser
from langchain_core.runnables import RunnablePassthrough, RunnableLambda

def build_buffer_memory_chain():
    memory = ConversationBufferMemory(return_messages=True, memory_key="chat_history")
    
    prompt = ChatPromptTemplate.from_messages([
        ("system", "You are a helpful assistant. Use the chat history to maintain context."),
        MessagesPlaceholder(variable_name="chat_history"),
        ("human", "{input}"),
    ])
    
    model = ChatOpenAI(model="gpt-4o-mini", temperature=0.3)
    
    chain = (
        RunnablePassthrough.assign(
            chat_history=RunnableLambda(lambda x: memory.load_memory_variables({})["chat_history"])
        )
        | prompt
        | model
        | StrOutputParser()
    )
    
    def invoke_with_memory(input_text: str) -> str:
        result = chain.invoke({"input": input_text})
        memory.save_context({"input": input_text}, {"output": result})
        return result
    
    return invoke_with_memory, memory


def build_summary_memory_chain():
    llm = ChatOpenAI(model="gpt-4o-mini", temperature=0)
    memory = ConversationSummaryMemory(llm=llm, return_messages=True, memory_key="chat_history")
    
    prompt = ChatPromptTemplate.from_messages([
        ("system", "You are a helpful assistant."),
        MessagesPlaceholder(variable_name="chat_history"),
        ("human", "{input}"),
    ])
    
    model = ChatOpenAI(model="gpt-4o-mini", temperature=0.3)
    
    chain = (
        RunnablePassthrough.assign(
            chat_history=RunnableLambda(lambda x: memory.load_memory_variables({})["chat_history"])
        )
        | prompt
        | model
        | StrOutputParser()
    )
    
    def invoke_with_memory(input_text: str) -> str:
        result = chain.invoke({"input": input_text})
        memory.save_context({"input": input_text}, {"output": result})
        print(f"  [Summary buffer]: {memory.buffer}")
        return result
    
    return invoke_with_memory, memory


def build_entity_memory_chain():
    llm = ChatOpenAI(model="gpt-4o-mini", temperature=0)
    memory = ConversationEntityMemory(llm=llm, return_messages=True)
    
    prompt = ChatPromptTemplate.from_messages([
        ("system", "You are a helpful assistant. Known entities: {entities}"),
        MessagesPlaceholder(variable_name="history"),
        ("human", "{input}"),
    ])
    
    model = ChatOpenAI(model="gpt-4o-mini", temperature=0.3)
    
    def invoke_with_memory(input_text: str) -> str:
        mem_vars = memory.load_memory_variables({"input": input_text})
        result_msg = (prompt | model | StrOutputParser()).invoke({
            "input": input_text,
            "entities": mem_vars.get("entities", ""),
            "history": mem_vars.get("history", []),
        })
        memory.save_context({"input": input_text}, {"output": result_msg})
        print(f"  [Entity store]: {dict(memory.entity_store.store)}")
        return result_msg
    
    return invoke_with_memory, memory


def compare_memory_systems(conversation: list[str]) -> dict:
    import tiktoken
    enc = tiktoken.encoding_for_model("gpt-4o-mini")
    
    results = {}
    for name, builder in [("buffer", build_buffer_memory_chain),
                           ("summary", build_summary_memory_chain),
                           ("entity", build_entity_memory_chain)]:
        invoke_fn, memory = builder()
        tokens_per_turn = []
        
        for msg in conversation:
            # Count tokens in memory before call
            mem_vars = memory.load_memory_variables({"input": msg}) if name == "entity" else memory.load_memory_variables({})
            mem_content = str(mem_vars)
            tokens_per_turn.append(len(enc.encode(mem_content)))
            invoke_fn(msg)
        
        results[name] = {
            "tokens_per_turn": tokens_per_turn,
            "total_tokens": sum(tokens_per_turn),
        }
    
    return results
```

---

## Part 2: Persistent Memory (20 pts)

```python
# persistent_memory.py
import json
from pathlib import Path
from datetime import datetime
from langchain_core.messages import HumanMessage, AIMessage

class FileChatMemory:
    def __init__(self, session_id: str, storage_dir: str = "./chat_history"):
        self.session_id = session_id
        self.storage_dir = Path(storage_dir)
        self.storage_dir.mkdir(parents=True, exist_ok=True)
        self.filepath = self.storage_dir / f"{session_id}.json"
        
        if not self.filepath.exists():
            self._write({"session_id": session_id, "created_at": datetime.now().isoformat(), "messages": []})
    
    def _read(self) -> dict:
        return json.loads(self.filepath.read_text())
    
    def _write(self, data: dict):
        self.filepath.write_text(json.dumps(data, indent=2))
    
    def save_context(self, input_msg: str, output_msg: str):
        data = self._read()
        now = datetime.now().isoformat()
        data["messages"].append({"role": "human", "content": input_msg, "timestamp": now})
        data["messages"].append({"role": "ai", "content": output_msg, "timestamp": now})
        self._write(data)
    
    def load_memory_variables(self) -> dict:
        data = self._read()
        messages = []
        for m in data["messages"]:
            if m["role"] == "human":
                messages.append(HumanMessage(content=m["content"]))
            else:
                messages.append(AIMessage(content=m["content"]))
        return {"chat_history": messages}
    
    def clear(self):
        self._write({"session_id": self.session_id, "created_at": datetime.now().isoformat(), "messages": []})
    
    def get_summary(self, llm) -> str:
        data = self._read()
        if not data["messages"]:
            return "No conversation history."
        
        transcript = "\n".join([f"{m['role']}: {m['content']}" for m in data["messages"]])
        response = llm.invoke(f"Summarize this conversation:\n\n{transcript}")
        return response.content
```

---

## Part 3: LangGraph Workflows (35 pts)

```python
# langgraph_workflow.py
from langgraph.graph import StateGraph, END
from typing import TypedDict, Annotated, Sequence
from langchain_core.messages import BaseMessage, HumanMessage
from langchain_openai import ChatOpenAI
import operator

class WritingState(TypedDict):
    messages: Annotated[Sequence[BaseMessage], operator.add]
    topic: str
    research_data: str
    outline: str
    draft: str
    review_feedback: str
    quality_score: float
    final_output: str
    iteration_count: int

llm = ChatOpenAI(model="gpt-4o-mini", temperature=0.5)

def research_node(state: WritingState) -> dict:
    topic = state["topic"]
    response = llm.invoke(f"Research the topic '{topic}'. Provide 5 key facts, statistics, and insights.")
    return {"research_data": response.content}

def outline_node(state: WritingState) -> dict:
    response = llm.invoke(
        f"Create a detailed outline for an article about '{state['topic']}'.\n\nResearch: {state['research_data']}"
    )
    return {"outline": response.content}

def draft_node(state: WritingState) -> dict:
    response = llm.invoke(
        f"Write a complete article draft.\n\nOutline: {state['outline']}\n\nResearch: {state['research_data']}"
    )
    return {"draft": response.content}

def review_node(state: WritingState) -> dict:
    response = llm.invoke(
        f"""Review this article draft. Score quality 1-10 and provide specific feedback.
Format: SCORE: X/10\nFEEDBACK: ...

Draft:
{state['draft']}"""
    )
    content = response.content
    # Parse score
    try:
        score_line = [l for l in content.split('\n') if 'SCORE' in l.upper()][0]
        score = float(score_line.split(':')[1].strip().split('/')[0])
    except (IndexError, ValueError):
        score = 5.0
    
    return {
        "review_feedback": content,
        "quality_score": score,
        "iteration_count": state.get("iteration_count", 0) + 1,
    }

def revise_node(state: WritingState) -> dict:
    response = llm.invoke(
        f"Revise this draft based on feedback.\n\nDraft: {state['draft']}\n\nFeedback: {state['review_feedback']}"
    )
    return {"draft": response.content}

def finalize_node(state: WritingState) -> dict:
    response = llm.invoke(f"Polish and format this article for publication:\n\n{state['draft']}")
    return {"final_output": response.content}

def should_revise(state: WritingState) -> str:
    if state.get("quality_score", 0) >= 7:
        return "finalize"
    if state.get("iteration_count", 0) >= 3:
        return "finalize"  # Max iterations reached
    return "revise"

def build_writing_workflow() -> StateGraph:
    workflow = StateGraph(WritingState)
    
    workflow.add_node("research", research_node)
    workflow.add_node("outline", outline_node)
    workflow.add_node("draft", draft_node)
    workflow.add_node("review", review_node)
    workflow.add_node("revise", revise_node)
    workflow.add_node("finalize", finalize_node)
    
    workflow.set_entry_point("research")
    workflow.add_edge("research", "outline")
    workflow.add_edge("outline", "draft")
    workflow.add_edge("draft", "review")
    workflow.add_conditional_edges("review", should_revise, {"revise": "revise", "finalize": "finalize"})
    workflow.add_edge("revise", "review")
    workflow.add_edge("finalize", END)
    
    return workflow.compile()


# Customer support workflow
class SupportState(TypedDict):
    messages: Annotated[Sequence[BaseMessage], operator.add]
    ticket_text: str
    category: str
    confidence: float
    handler_response: str
    final_response: str

def classify_ticket(state: SupportState) -> dict:
    response = llm.invoke(
        f"""Classify this support ticket. Return category and confidence.
Format: CATEGORY: billing|technical|account|other\nCONFIDENCE: 0.X

Ticket: {state['ticket_text']}"""
    )
    content = response.content
    try:
        cat = [l for l in content.split('\n') if 'CATEGORY' in l.upper()][0].split(':')[1].strip()
        conf = float([l for l in content.split('\n') if 'CONFIDENCE' in l.upper()][0].split(':')[1].strip())
    except:
        cat, conf = "other", 0.5
    return {"category": cat, "confidence": conf}

def billing_handler(state: SupportState) -> dict:
    r = llm.invoke(f"Handle this billing issue helpfully:\n{state['ticket_text']}")
    return {"handler_response": r.content}

def technical_handler(state: SupportState) -> dict:
    r = llm.invoke(f"Provide technical support for:\n{state['ticket_text']}")
    return {"handler_response": r.content}

def account_handler(state: SupportState) -> dict:
    r = llm.invoke(f"Handle this account issue:\n{state['ticket_text']}")
    return {"handler_response": r.content}

def escalate_handler(state: SupportState) -> dict:
    return {"handler_response": "This ticket has been escalated to a human agent. Ticket reference: ESC-" + str(hash(state['ticket_text']))[:6]}

def respond_node(state: SupportState) -> dict:
    return {"final_response": state["handler_response"]}

def route_ticket(state: SupportState) -> str:
    if state.get("confidence", 0) < 0.7:
        return "escalate"
    return state.get("category", "escalate")

def build_customer_support_workflow() -> StateGraph:
    workflow = StateGraph(SupportState)
    
    workflow.add_node("classify", classify_ticket)
    workflow.add_node("billing", billing_handler)
    workflow.add_node("technical", technical_handler)
    workflow.add_node("account", account_handler)
    workflow.add_node("escalate", escalate_handler)
    workflow.add_node("respond", respond_node)
    
    workflow.set_entry_point("classify")
    workflow.add_conditional_edges("classify", route_ticket, {
        "billing": "billing", "technical": "technical",
        "account": "account", "other": "escalate", "escalate": "escalate",
    })
    for node in ["billing", "technical", "account", "escalate"]:
        workflow.add_edge(node, "respond")
    workflow.add_edge("respond", END)
    
    return workflow.compile()
```

---

## Part 4: Checkpointing (15 pts)

```python
# checkpointing.py
from langgraph.checkpoint.sqlite import SqliteSaver

def build_persistent_workflow():
    with SqliteSaver.from_conn_string(":memory:") as checkpointer:
        # Reuse writing workflow but add interrupt
        workflow = StateGraph(WritingState)
        # ... (same nodes as above)
        
        app = workflow.compile(
            checkpointer=checkpointer,
            interrupt_before=["finalize"],  # Pause for human review
        )
        
        # Start workflow
        config = {"configurable": {"thread_id": "writing-1"}}
        result = app.invoke({"topic": "AI in Healthcare", "iteration_count": 0}, config)
        
        # At this point, workflow is paused before finalize
        print("Draft for review:", result.get("draft", "")[:500])
        
        # Resume with human feedback
        app.update_state(config, {"review_feedback": "Looks good, please finalize."})
        final = app.invoke(None, config)
        
        return final
```

**Common bugs:**
- Forgetting `operator.add` annotation on messages (causes overwrite instead of append)
- Conditional edge function returning value not in the edge mapping
- Not setting max iterations on review loop → infinite loop
