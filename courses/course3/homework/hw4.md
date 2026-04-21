# Homework 4: Agents & Tools

**Due:** End of Week 10 | **Points:** 100 | **Weight:** ~6.7% of final grade

## Objectives
- Build custom tools for LangChain agents
- Implement ReAct agents with function calling
- Handle agent errors, timeouts, and loops
- Create a multi-tool agent system

---

## Part 1: Custom Tool Development (30 pts)

```python
# custom_tools.py
from langchain_core.tools import tool, StructuredTool
from langchain_core.pydantic_v1 import BaseModel, Field
import requests

@tool
def web_search(query: str) -> str:
    """Search the web for current information about a topic.
    
    Args:
        query: The search query string
    Returns:
        Top 3 search results with titles and snippets
    """
    # TODO: Implement using a free search API (e.g., DuckDuckGo)
    # Return formatted results
    pass

class CalculatorInput(BaseModel):
    expression: str = Field(description="Mathematical expression to evaluate")

@tool(args_schema=CalculatorInput)
def calculator(expression: str) -> str:
    """Safely evaluate a mathematical expression.
    
    Supports: +, -, *, /, **, sqrt, sin, cos, tan, log
    """
    # TODO: Use ast.literal_eval or a safe math parser
    # Do NOT use eval()
    pass

@tool
def weather_lookup(city: str) -> str:
    """Get current weather for a city.
    
    Args:
        city: City name (e.g., 'San Francisco, CA')
    Returns:
        Current temperature, conditions, humidity
    """
    # TODO: Use wttr.in or similar free API
    pass

class DatabaseQueryInput(BaseModel):
    table: str = Field(description="Table name to query")
    conditions: dict = Field(description="Filter conditions as key-value pairs")
    limit: int = Field(default=10, description="Max rows to return")

def create_db_tool(db_path: str) -> StructuredTool:
    """
    Create a StructuredTool for querying a SQLite database.
    
    The tool should:
    1. Accept table name, conditions, and limit
    2. Build a safe SQL query (NO SQL injection!)
    3. Return results as formatted string
    4. Handle errors gracefully
    """
    pass
```

## Part 2: ReAct Agent (35 pts)

```python
# react_agent.py
from langchain_openai import ChatOpenAI
from langchain.agents import create_tool_calling_agent, AgentExecutor
from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder

def build_research_agent() -> AgentExecutor:
    """
    Build a ReAct agent with the following tools:
    - web_search
    - calculator
    - weather_lookup
    
    The agent should:
    1. Use gpt-4o-mini with function calling
    2. Have a system prompt that makes it a helpful research assistant
    3. Include MessagesPlaceholder for chat_history
    4. Set max_iterations=10 to prevent infinite loops
    5. Set handle_parsing_errors=True
    6. Return intermediate steps for debugging
    
    Return the AgentExecutor.
    """
    prompt = ChatPromptTemplate.from_messages([
        ("system", """You are a helpful research assistant. You have access to tools 
        for searching the web, doing calculations, and checking weather.
        
        Always think step by step. If you need multiple pieces of information,
        gather them one at a time. Cite your sources when using web search."""),
        MessagesPlaceholder(variable_name="chat_history", optional=True),
        ("human", "{input}"),
        MessagesPlaceholder(variable_name="agent_scratchpad"),
    ])
    # TODO: Complete the implementation
    pass

def run_agent_with_tracing(agent: AgentExecutor, query: str) -> dict:
    """
    Run the agent and capture:
    - Final answer
    - All intermediate steps (tool calls and results)
    - Total tokens used
    - Total time elapsed
    - Number of iterations
    
    Return as structured dict.
    """
    pass
```

## Part 3: Error Handling & Guardrails (20 pts)

```python
# agent_safety.py
from langchain_core.runnables import RunnableLambda
from langchain_core.tools import tool

def build_safe_agent(tools: list, max_cost_usd: float = 0.10) -> AgentExecutor:
    """
    Build an agent with safety guardrails:
    
    1. Input validation: reject prompts > 2000 chars, flag injection attempts
    2. Tool call limits: max 5 tool calls per query
    3. Cost tracking: estimate and cap at max_cost_usd
    4. Timeout: 60 second max per query
    5. Output filtering: check for PII before returning
    
    Implement using callbacks and custom exception handling.
    """
    pass

@tool
def restricted_file_read(filepath: str) -> str:
    """Read a file from the allowed directory only.
    
    SECURITY: Only reads from ./data/ directory. 
    Rejects paths with .. or absolute paths.
    """
    # TODO: Implement with path validation
    pass
```

## Part 4: Multi-Agent Conversation (15 pts)

```python
# multi_agent.py

def build_specialist_agents() -> dict:
    """
    Create 3 specialist agents:
    
    1. researcher: Has web_search tool, finds information
    2. analyst: Has calculator + db_tool, analyzes data
    3. writer: No tools, synthesizes info into reports
    
    Return dict: {"researcher": agent, "analyst": agent, "writer": agent}
    """
    pass

def orchestrate(query: str, agents: dict) -> str:
    """
    Simple orchestration:
    1. Researcher gathers info about the query
    2. Analyst processes any numerical data
    3. Writer synthesizes everything into a final report
    
    Pass context between agents via their inputs.
    Return the final report.
    """
    pass
```

---

## Rubric

| Component | Points | Criteria |
|-----------|--------|----------|
| Custom tools | 30 | 4 tools work, type safety, error handling, no eval() |
| ReAct agent | 35 | Agent reasons correctly, tools called appropriately, tracing works |
| Safety | 20 | Input validation, cost tracking, path safety, timeout |
| Multi-agent | 15 | 3 agents created, orchestration flows, report generated |

## Submission
Push to `hw4/` with working agents and example conversation logs in README.
