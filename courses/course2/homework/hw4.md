# Homework 4: AI Integration

**GENAI 201: AI-Powered Workflows & Automation**
**Due:** End of Week 8 | **Points:** 100

## Learning Objectives

- Connect an LLM (OpenAI/Anthropic) within an n8n workflow
- Design effective prompts for automated pipelines
- Build a content generation workflow with human-quality output
- Handle AI API responses, token limits, and costs

## Prerequisites

- Working n8n instance
- OpenAI API key (or Anthropic/other supported LLM)
- Completed HW3

## Instructions

### Part A: AI Node Setup (20 pts)

1. **Configure Credentials** (5 pts) — Set up OpenAI (or equivalent) credentials in n8n. Screenshot the credential setup (redact keys).

2. **Basic AI Call** (10 pts) — Create a simple workflow:
   - Manual trigger → OpenAI node → Output
   - Send a test prompt, receive a response
   - Screenshot the execution showing input prompt and AI output

3. **Model Selection** (5 pts) — Test the same prompt with two different models (e.g., gpt-4o-mini vs gpt-4o). Compare:
   - Response quality
   - Response time
   - Token usage / estimated cost
   - Which would you use in production and why?

### Part B: Content Pipeline (40 pts)

Build a **content generation pipeline** with at least 6 nodes:

**Trigger → Input Processing → AI Generation → Post-Processing → Quality Check → Output**

Choose one scenario:

**Option 1: Blog Post Generator**
- Input: topic + target audience + tone
- AI generates: title, outline, full draft (500–800 words)
- Post-processing: format as Markdown, add metadata
- Output: save to file or Google Doc

**Option 2: Customer Email Responder**
- Input: customer email text + category
- AI generates: professional response draft
- Post-processing: add greeting/signature, check length
- Output: formatted email ready for review

**Option 3: Product Description Writer**
- Input: product name + features list + target market
- AI generates: marketing description + SEO keywords
- Post-processing: character count validation, format for platform
- Output: structured JSON with all fields

Requirements for full credit:

1. **Prompt Engineering** (15 pts) — Your AI prompt must include:
   - Clear role/persona instruction
   - Specific output format requirements
   - At least one example (few-shot) or detailed constraints
   - Dynamic variables from previous nodes (not hardcoded)

2. **Multi-Step AI** (10 pts) — Use the AI node at least twice in the workflow (e.g., generate then review, or outline then expand)

3. **Post-Processing** (10 pts) — At least one node that validates or transforms the AI output (length check, format parsing, JSON extraction)

4. **Working Demo** (5 pts) — Show 3 different inputs producing 3 different quality outputs

### Part C: Cost & Performance Analysis (20 pts)

1. **Token Tracking** (10 pts) — For your pipeline, document:
   - Input tokens per request (average)
   - Output tokens per request (average)
   - Cost per execution at current API pricing
   - Projected monthly cost at 100 executions/day

2. **Optimization** (10 pts) — Propose and implement at least one optimization:
   - Reduce token usage while maintaining quality
   - Cache repeated requests
   - Use cheaper models for simpler subtasks
   - Show before/after comparison

### Part D: Prompt Versioning (20 pts)

1. **Version Your Prompts** (10 pts) — Create 3 versions of your main prompt, each improving on the last. For each version, document:
   - What you changed
   - Why you changed it
   - Sample output comparison

2. **Prompt Template** (10 pts) — Extract your final prompt into a reusable template with clear variable placeholders. Document which variables are required vs optional and what happens with edge-case inputs (empty strings, very long inputs).

## Submission

- Markdown/PDF with all screenshots, prompts, and analysis
- Exported n8n workflow JSON
- Sample inputs and outputs for 3 test runs

## Rubric

| Component | Points |
|---|---|
| AI Node Setup — credentials, basic call, model comparison | 20 |
| Content Pipeline — 6+ nodes, prompt engineering, multi-step | 40 |
| Cost & Performance — token tracking, optimization | 20 |
| Prompt Versioning — 3 versions, reusable template | 20 |
| **Total** | **100** |
