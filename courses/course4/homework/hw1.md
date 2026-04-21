# Homework 1: Multi-Agent System Design

**GENAI 401 — Advanced AI Systems & Architecture**
**Assigned:** Week 2 | **Due:** Week 5 | **Points:** 100

## Overview

Design and implement a multi-agent system that collaboratively solves a complex information-gathering task. Your system must demonstrate inter-agent coordination, task decomposition, and result synthesis.

## Requirements

### Part A: Architecture Design (30 pts)

1. Design a multi-agent system with at least 3 specialized agents (e.g., Researcher, Analyzer, Writer)
2. Produce an architecture diagram showing agent roles, communication flows, and shared state
3. Write a 2-page design document justifying your architecture choices, including:
   - Why you chose this decomposition
   - Alternative architectures considered and tradeoffs
   - How agents handle failures and retries

### Part B: Implementation (50 pts)

1. Implement the system using any framework (LangGraph, CrewAI, AutoGen, or custom)
2. Agents must communicate via structured messages (not free-text chaining)
3. Implement at least one of:
   - Hierarchical delegation (orchestrator → workers)
   - Peer-to-peer negotiation
   - Blackboard architecture
4. Include proper error handling and timeout logic
5. System must be runnable with `docker compose up`

### Part C: Evaluation (20 pts)

1. Run your system on 5 diverse test queries (provided in course repo)
2. Measure and report: latency, token usage, task completion rate, answer quality (self-evaluated rubric)
3. Compare single-agent baseline vs. your multi-agent approach with analysis

## Rubric

| Criteria | Excellent (90-100%) | Good (70-89%) | Needs Work (<70%) |
|----------|-------------------|---------------|-------------------|
| Architecture | Clear separation of concerns, justified tradeoffs, handles edge cases | Reasonable design with minor gaps | Monolithic or poorly justified |
| Implementation | Clean code, proper error handling, structured communication | Working but some rough edges | Broken or trivial agent separation |
| Evaluation | Thorough comparison with insights | Basic metrics reported | Missing or superficial |
| Documentation | Professional, clear, reproducible | Adequate | Incomplete |

## Submission

- GitHub repository link with README
- Architecture diagram (PDF or PNG)
- Design document (PDF)
- Evaluation report with metrics table
