# Homework 3: First n8n Workflow

**GENAI 201: AI-Powered Workflows & Automation**
**Due:** End of Week 6 | **Points:** 100

## Learning Objectives

- Navigate the n8n workflow editor
- Connect nodes with proper data flow
- Build a functional 5+ node workflow
- Test and debug workflows using execution logs
- Understand triggers, transformations, and outputs

## Prerequisites

- n8n running locally (`npx n8n`) or via n8n.cloud free tier
- Completed HW2 (API fundamentals)

## Instructions

### Part A: Workflow Setup (25 pts)

Build a workflow with **at minimum 5 nodes** following this pattern:

**Webhook → Transform → Enrich → Format → Output**

Specifically:

1. **Webhook Trigger** (5 pts) — Create a webhook node that accepts POST requests with a JSON body containing at least: `name`, `email`, `message`

2. **Validate/Transform** (5 pts) — Add a Function/Code node that:
   - Checks all required fields are present
   - Trims whitespace from strings
   - Adds a `received_at` timestamp
   - Passes data forward (or returns an error object if validation fails)

3. **Enrich** (5 pts) — Add a node that adds data. Options:
   - HTTP Request node to look up the email domain
   - A Code node that categorizes the message (e.g., by keyword matching)
   - Date/time formatting of the timestamp

4. **Format** (5 pts) — Add a node that structures the final output (e.g., creates a formatted text summary or builds a specific JSON schema)

5. **Output** (5 pts) — Choose one:
   - Respond to Webhook (send formatted response back to caller)
   - Write to a Google Sheet
   - Send a Slack/Discord message
   - Save to a file

### Part B: Testing (30 pts)

1. **Successful Test** (10 pts) — Send a valid request to your webhook using curl or Postman. Include:
   - The curl command you used
   - Screenshot of the successful execution in n8n
   - The output/response received

2. **Edge Case Tests** (10 pts) — Test with:
   - Missing required field
   - Empty string values
   - Extra unexpected fields
   - Document the behavior for each

3. **Execution Log Analysis** (10 pts) — For one execution:
   - Screenshot each node's input/output data
   - Explain the data transformation at each step
   - Identify how long each node took to execute

### Part C: Documentation (25 pts)

Create a README for your workflow that includes:

1. **Purpose** (5 pts) — What does this workflow do? One paragraph.
2. **Architecture Diagram** (5 pts) — Screenshot of the n8n canvas showing all nodes and connections
3. **Node Descriptions** (10 pts) — For each node: name, type, what it does, configuration details
4. **API Contract** (5 pts) — Document the webhook: URL, method, expected body schema, response format

### Part D: Export & Iteration (20 pts)

1. **Export** (5 pts) — Export your workflow as JSON. Include the file in your submission.
2. **Improvement Ideas** (5 pts) — List 3 ways you'd improve this workflow if it were going to production.
3. **Add a 6th Node** (10 pts) — Extend your workflow with one more node that adds meaningful functionality. Explain what it does and why you added it.

## Submission

- Markdown/PDF document with all screenshots, commands, and documentation
- Exported n8n workflow JSON file
- All curl commands used for testing

## Rubric

| Component | Points |
|---|---|
| Workflow Setup — 5+ nodes, correct flow | 25 |
| Testing — valid, edge cases, log analysis | 30 |
| Documentation — README quality | 25 |
| Export & Iteration — JSON, improvements, 6th node | 20 |
| **Total** | **100** |
