# Homework 5: Error Handling & Reliability

**GENAI 201: AI-Powered Workflows & Automation**
**Due:** End of Week 10 | **Points:** 100

## Learning Objectives

- Implement retry logic for transient failures
- Build error branches that gracefully handle failures
- Add monitoring and alerting to workflows
- Design workflows that fail safely and recover automatically

## Prerequisites

- Working n8n instance with a multi-node workflow (HW3 or HW4)
- Understanding of HTTP status codes (HW2)

## Instructions

### Part A: Error Branches (30 pts)

Take your workflow from HW3 or HW4 and add error handling:

1. **Error Trigger Node** (10 pts) — Add an Error Trigger workflow that:
   - Catches any workflow failure
   - Logs: workflow name, node that failed, error message, timestamp
   - Sends a notification (email, Slack, Discord, or writes to a file)
   - Screenshot the error workflow and demonstrate it firing

2. **Per-Node Error Branches** (10 pts) — For at least 2 nodes in your main workflow:
   - Add error output connections
   - Route errors to a handler that logs the failure and continues (or stops gracefully)
   - Show the visual branching in a screenshot

3. **Validation Gate** (10 pts) — Add an IF node that checks data quality before a critical step:
   - Define at least 3 validation rules
   - Route invalid data to a separate "rejection" path
   - Route valid data forward
   - Test with both valid and invalid inputs

### Part B: Retry Logic (25 pts)

1. **Built-in Retry** (10 pts) — Configure retry settings on an HTTP Request node:
   - Set retry count and delay
   - Document the settings you chose and why
   - Simulate a failure (bad URL or timeout) and show retry behavior in execution logs

2. **Custom Retry Pattern** (15 pts) — Build a retry mechanism using a loop:
   - Attempt an operation up to 3 times
   - Implement exponential backoff (wait 1s, 2s, 4s)
   - Track attempt count
   - Exit loop on success or max retries
   - Log each attempt with timestamp
   - Show execution of both success-after-retry and max-retries-exhausted scenarios

### Part C: Monitoring & Observability (25 pts)

1. **Execution Logging** (10 pts) — Create a logging mechanism that records for every workflow run:
   - Execution ID, start time, end time, duration
   - Status (success/failure)
   - Key data points processed
   - Store logs in a Google Sheet, file, or database

2. **Health Check Workflow** (10 pts) — Build a separate scheduled workflow that:
   - Runs every hour (or on a cron trigger)
   - Checks that your main workflow's dependencies are available (API endpoints respond, credentials work)
   - Sends an alert if any check fails

3. **Dashboard Sketch** (5 pts) — Design (sketch or mockup) a monitoring dashboard showing:
   - Executions per day (success vs failure)
   - Average execution time
   - Error rate trend
   - Most common error types

### Part D: Failure Scenarios (20 pts)

Document how your workflow handles each scenario:

1. **API Timeout** (5 pts) — What happens? How does it recover?
2. **Invalid AI Response** (5 pts) — AI returns unexpected format. How do you detect and handle it?
3. **Rate Limiting** (5 pts) — You hit 429. What's your strategy?
4. **Partial Failure** (5 pts) — Node 3 of 6 fails. What happens to already-processed data? How do you resume?

For each: describe the failure, show your handling mechanism, and demonstrate with a test.

## Submission

- Markdown/PDF with screenshots, configurations, and analysis
- Exported n8n workflow JSON (updated with error handling)
- Execution logs showing error handling in action

## Rubric

| Component | Points |
|---|---|
| Error Branches — trigger, per-node, validation gate | 30 |
| Retry Logic — built-in and custom with backoff | 25 |
| Monitoring — logging, health check, dashboard sketch | 25 |
| Failure Scenarios — 4 scenarios documented and tested | 20 |
| **Total** | **100** |
