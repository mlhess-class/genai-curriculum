# HW4 Answer Key: Agents & Tools

## Part 1: Custom Tool Development (30 pts)

```python
# custom_tools.py
from langchain_core.tools import tool, StructuredTool
from pydantic import BaseModel, Field
import requests
import ast
import math
import sqlite3
import os

@tool
def web_search(query: str) -> str:
    """Search the web for current information about a topic."""
    try:
        resp = requests.get(
            "https://api.duckduckgo.com/",
            params={"q": query, "format": "json", "no_html": 1, "skip_disambig": 1},
            timeout=10
        )
        data = resp.json()
        results = []
        
        if data.get("AbstractText"):
            results.append(f"Summary: {data['AbstractText']}")
        
        for topic in data.get("RelatedTopics", [])[:3]:
            if isinstance(topic, dict) and "Text" in topic:
                results.append(f"- {topic['Text']}")
        
        return "\n".join(results) if results else "No results found."
    except Exception as e:
        return f"Search error: {e}"


class CalculatorInput(BaseModel):
    expression: str = Field(description="Mathematical expression to evaluate")

@tool(args_schema=CalculatorInput)
def calculator(expression: str) -> str:
    """Safely evaluate a mathematical expression."""
    allowed_names = {
        "sqrt": math.sqrt, "sin": math.sin, "cos": math.cos,
        "tan": math.tan, "log": math.log, "pi": math.pi, "e": math.e,
        "abs": abs, "round": round,
    }
    
    # Remove dangerous characters
    for char in ["import", "exec", "eval", "open", "__", "os", "sys"]:
        if char in expression.lower():
            return f"Error: '{char}' not allowed in expressions"
    
    try:
        # Use compile + eval with restricted globals
        code = compile(expression, "<string>", "eval")
        result = eval(code, {"__builtins__": {}}, allowed_names)
        return str(result)
    except Exception as e:
        return f"Calculation error: {e}"


@tool
def weather_lookup(city: str) -> str:
    """Get current weather for a city."""
    try:
        resp = requests.get(f"https://wttr.in/{city}?format=j1", timeout=10)
        data = resp.json()
        current = data["current_condition"][0]
        return (
            f"Weather in {city}: {current['weatherDesc'][0]['value']}, "
            f"Temp: {current['temp_F']}°F ({current['temp_C']}°C), "
            f"Humidity: {current['humidity']}%, "
            f"Wind: {current['windspeedMiles']} mph"
        )
    except Exception as e:
        return f"Weather lookup error: {e}"


class DatabaseQueryInput(BaseModel):
    table: str = Field(description="Table name to query")
    conditions: dict = Field(description="Filter conditions as key-value pairs")
    limit: int = Field(default=10, description="Max rows to return")

def create_db_tool(db_path: str) -> StructuredTool:
    def query_db(table: str, conditions: dict, limit: int = 10) -> str:
        # Validate table name (prevent SQL injection)
        if not table.isalnum():
            return "Error: Invalid table name"
        
        conn = sqlite3.connect(db_path)
        conn.row_factory = sqlite3.Row
        cursor = conn.cursor()
        
        try:
            # Check table exists
            cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name=?", (table,))
            if not cursor.fetchone():
                return f"Error: Table '{table}' not found"
            
            # Build parameterized query
            where_clauses = []
            params = []
            for key, value in conditions.items():
                if not key.isalnum():
                    return f"Error: Invalid column name '{key}'"
                where_clauses.append(f"{key} = ?")
                params.append(value)
            
            query = f"SELECT * FROM {table}"
            if where_clauses:
                query += " WHERE " + " AND ".join(where_clauses)
            query += f" LIMIT ?"
            params.append(limit)
            
            cursor.execute(query, params)
            rows = cursor.fetchall()
            
            if not rows:
                return "No results found."
            
            headers = [desc[0] for desc in cursor.description]
            result = " | ".join(headers) + "\n" + "-" * 40 + "\n"
            for row in rows:
                result += " | ".join(str(v) for v in row) + "\n"
            return result
        finally:
            conn.close()
    
    return StructuredTool.from_function(
        func=query_db,
        name="database_query",
        description="Query a SQLite database with filters",
        args_schema=DatabaseQueryInput,
    )
```

**Grading notes:**
- -10 if using `eval()` without safety restrictions in calculator
- -5 if SQL injection possible (string formatting instead of parameterized queries)
- -3 if no timeout on HTTP requests

---

## Part 2: ReAct Agent (35 pts)

```python
# react_agent.py
from langchain_openai import ChatOpenAI
from langchain.agents import create_tool_calling_agent, AgentExecutor
from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder
import time

def build_research_agent() -> AgentExecutor:
    tools = [web_search, calculator, weather_lookup]
    
    prompt = ChatPromptTemplate.from_messages([
        ("system", """You are a helpful research assistant with access to web search,
a calculator, and weather lookup. Think step by step. If you need
multiple pieces of information, gather them one at a time.
Cite your sources when using web search."""),
        MessagesPlaceholder(variable_name="chat_history", optional=True),
        ("human", "{input}"),
        MessagesPlaceholder(variable_name="agent_scratchpad"),
    ])
    
    model = ChatOpenAI(model="gpt-4o-mini", temperature=0)
    agent = create_tool_calling_agent(model, tools, prompt)
    
    executor = AgentExecutor(
        agent=agent,
        tools=tools,
        verbose=True,
        max_iterations=10,
        handle_parsing_errors=True,
        return_intermediate_steps=True,
    )
    return executor


def run_agent_with_tracing(agent: AgentExecutor, query: str) -> dict:
    start = time.time()
    result = agent.invoke({"input": query})
    elapsed = time.time() - start
    
    steps = result.get("intermediate_steps", [])
    tool_calls = []
    for action, observation in steps:
        tool_calls.append({
            "tool": action.tool,
            "input": str(action.tool_input),
            "output": str(observation)[:500],
        })
    
    return {
        "answer": result["output"],
        "tool_calls": tool_calls,
        "num_iterations": len(steps),
        "elapsed_seconds": round(elapsed, 2),
    }
```

---

## Part 3: Error Handling & Guardrails (20 pts)

```python
# agent_safety.py
from langchain.agents import AgentExecutor, create_tool_calling_agent
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder
from langchain_core.tools import tool
from langchain_core.callbacks import BaseCallbackHandler
import os
import re
import time

class SafetyCallbackHandler(BaseCallbackHandler):
    def __init__(self, max_tool_calls: int = 5, max_cost_usd: float = 0.10):
        self.tool_call_count = 0
        self.max_tool_calls = max_tool_calls
        self.estimated_cost = 0.0
        self.max_cost = max_cost_usd
    
    def on_tool_start(self, serialized, input_str, **kwargs):
        self.tool_call_count += 1
        if self.tool_call_count > self.max_tool_calls:
            raise RuntimeError(f"Tool call limit exceeded ({self.max_tool_calls})")
    
    def on_llm_end(self, response, **kwargs):
        # Rough cost estimation
        self.estimated_cost += 0.002  # ~$0.002 per call for gpt-4o-mini
        if self.estimated_cost > self.max_cost:
            raise RuntimeError(f"Budget exceeded: ${self.estimated_cost:.4f} > ${self.max_cost}")


def validate_input(text: str) -> str:
    if len(text) > 2000:
        raise ValueError("Input exceeds 2000 character limit")
    injection_patterns = [r"ignore previous", r"system prompt", r"you are now"]
    for pattern in injection_patterns:
        if re.search(pattern, text, re.IGNORECASE):
            raise ValueError(f"Potential prompt injection detected")
    return text


def build_safe_agent(tools: list, max_cost_usd: float = 0.10) -> AgentExecutor:
    prompt = ChatPromptTemplate.from_messages([
        ("system", "You are a helpful, safe assistant."),
        ("human", "{input}"),
        MessagesPlaceholder(variable_name="agent_scratchpad"),
    ])
    
    model = ChatOpenAI(model="gpt-4o-mini", temperature=0)
    agent = create_tool_calling_agent(model, tools, prompt)
    
    safety_handler = SafetyCallbackHandler(max_tool_calls=5, max_cost_usd=max_cost_usd)
    
    return AgentExecutor(
        agent=agent,
        tools=tools,
        callbacks=[safety_handler],
        max_iterations=10,
        max_execution_time=60,
        handle_parsing_errors=True,
    )


@tool
def restricted_file_read(filepath: str) -> str:
    """Read a file from the allowed directory only."""
    allowed_dir = os.path.abspath("./data")
    abs_path = os.path.abspath(os.path.join(allowed_dir, filepath))
    
    if not abs_path.startswith(allowed_dir):
        return "Error: Access denied. Path traversal detected."
    
    if not os.path.exists(abs_path):
        return f"Error: File not found: {filepath}"
    
    try:
        with open(abs_path, 'r') as f:
            content = f.read(10000)  # Cap at 10KB
        return content
    except Exception as e:
        return f"Error reading file: {e}"
```

---

## Part 4: Multi-Agent Conversation (15 pts)

```python
# multi_agent.py
from langchain_openai import ChatOpenAI
from langchain.agents import create_tool_calling_agent, AgentExecutor
from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder

def build_specialist_agents() -> dict:
    model = ChatOpenAI(model="gpt-4o-mini", temperature=0.3)
    
    def make_agent(system_msg, tools):
        prompt = ChatPromptTemplate.from_messages([
            ("system", system_msg),
            ("human", "{input}"),
            MessagesPlaceholder(variable_name="agent_scratchpad"),
        ])
        if tools:
            agent = create_tool_calling_agent(model, tools, prompt)
            return AgentExecutor(agent=agent, tools=tools, verbose=True, max_iterations=5)
        else:
            # No-tool agent is just a chain
            from langchain_core.output_parsers import StrOutputParser
            return prompt | model | StrOutputParser()
    
    return {
        "researcher": make_agent("You are a research specialist. Find relevant info.", [web_search]),
        "analyst": make_agent("You are a data analyst. Analyze numbers and data.", [calculator]),
        "writer": make_agent("You are a technical writer. Synthesize info into clear reports.", []),
    }


def orchestrate(query: str, agents: dict) -> str:
    # Step 1: Research
    research = agents["researcher"].invoke({"input": f"Research: {query}"})
    research_output = research["output"] if isinstance(research, dict) else research
    
    # Step 2: Analyze
    analysis = agents["analyst"].invoke({
        "input": f"Analyze the following research and extract key data points:\n{research_output}"
    })
    analysis_output = analysis["output"] if isinstance(analysis, dict) else analysis
    
    # Step 3: Write report
    report_input = f"Write a report based on:\n\nResearch:\n{research_output}\n\nAnalysis:\n{analysis_output}"
    report = agents["writer"].invoke({"input": report_input})
    
    return report if isinstance(report, str) else report.get("output", str(report))
```
