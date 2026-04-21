# Final Project: AI-Powered Automation System

**GENAI 201: AI-Powered Workflows & Automation**
**Due:** End of Week 14 | **Points:** 200

## Overview

Design and build a complete AI-powered automation system in n8n that solves a real business problem. This project demonstrates mastery of all course concepts: workflow design, API integration, AI/LLM usage, error handling, and advanced patterns.

## Requirements

### Core Requirements (must meet all)

1. **Real Problem** — Your automation must address an identifiable business or personal productivity problem. Toy examples will not receive full credit.

2. **Minimum 10 Nodes** — The complete system (including sub-workflows) must contain at least 10 functional nodes.

3. **AI Integration** — At least 2 nodes must call an LLM (OpenAI, Anthropic, or equivalent) with well-engineered prompts.

4. **External API** — At least 1 integration with an external service (Google Sheets, Slack, email, database, third-party API, etc.).

5. **Error Handling** — The system must include:
   - At least 1 error branch with recovery/notification
   - Input validation
   - Retry logic on at least 1 external call

6. **Advanced Pattern** — Use at least 1 of: sub-workflow, loop/batch processing, or parallel execution.

7. **Trigger** — A realistic trigger (webhook, schedule, or event-based — not just manual trigger).

### Deliverables

1. **Project Proposal** (submitted Week 12 for feedback)
   - Problem statement (200 words)
   - Proposed architecture diagram
   - List of APIs and services to be used
   - Risk assessment: what could go wrong?

2. **Working System**
   - Exported n8n workflow JSON (all workflows)
   - Demonstrated working with real or realistic test data
   - At minimum 5 successful end-to-end executions logged

3. **Documentation (2000–3000 words)** including:
   - Problem & motivation
   - Architecture overview with diagram
   - Node-by-node walkthrough
   - Prompt engineering decisions (show prompt iterations)
   - Error handling strategy
   - Cost analysis (per-execution and projected monthly)
   - Performance metrics (execution times, success rates)
   - Limitations and future improvements

4. **Demo Video or Live Demo** (5–10 minutes)
   - Walk through the workflow visually
   - Trigger a live execution
   - Show a failure scenario and recovery
   - Discuss design decisions

## Suggested Project Ideas

Choose one or propose your own (get instructor approval):

- **Content Pipeline** — RSS feed → AI summarization → newsletter draft → email distribution with scheduling
- **Customer Feedback Analyzer** — Form/survey intake → sentiment analysis → categorization → routing → dashboard update
- **Meeting Assistant** — Calendar trigger → pull agenda → AI generates prep notes → distributes to attendees → post-meeting summary
- **Code Review Bot** — GitHub webhook → pull diff → AI reviews code → posts comments → tracks metrics
- **Invoice Processor** — Email intake → extract invoice data (AI) → validate → update spreadsheet → send approval request
- **Social Media Manager** — Schedule trigger → AI generates posts for multiple platforms → adapts tone per platform → queues for review → publishes
- **Knowledge Base Builder** — Document intake → AI extracts Q&A pairs → categorizes → updates FAQ → notifies team of new entries

## Timeline

| Week | Milestone |
|---|---|
| 12 | Submit project proposal for feedback |
| 13 | Working prototype (core flow functional) |
| 14 | Final submission: polished system, docs, demo |

## Evaluation

See `final-rubric.md` for the detailed 200-point rubric.

## Academic Integrity

- All work must be your own
- You may use AI tools to help write code and prompts (document this usage)
- You may not submit a workflow copied from a tutorial without significant modification
- Cite any external resources, tutorials, or templates used
