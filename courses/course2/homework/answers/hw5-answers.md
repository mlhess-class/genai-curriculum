# HW5 Answers: Error Handling & Reliability

**GENAI 201 — Model Answers & Grading Notes**

---

## Part A: Error Branches (30 pts)

### Error Trigger Node (10 pts)

Create a separate workflow with an Error Trigger node as the start:

```
Error Trigger → Code (format error details) → Send Email/Slack notification
```

Code node:
```javascript
const error = $input.first().json;
return [{
  json: {
    workflow: error.workflow?.name || 'Unknown',
    node: error.execution?.lastNodeExecuted || 'Unknown',
    message: error.execution?.error?.message || 'No message',
    timestamp: new Date().toISOString()
  }
}];
```

Then set this as the Error Workflow in your main workflow's settings.

**Grading notes:** Must show the error workflow configured in main workflow settings. Must demonstrate it actually firing on a real error.

### Per-Node Error Branches (10 pts)

In n8n, click a node → Settings → "Continue On Fail" or add an error output:

- HTTP Request node → error output → Code node (log failure, set fallback data)
- AI node → error output → Code node (use cached/default response)

**Grading notes:** Must show error output connections on at least 2 nodes in the canvas screenshot. Must show both the error path and the success path.

### Validation Gate (10 pts)

IF node configuration:
```
Condition 1: {{ $json.email }} contains "@"
Condition 2: {{ $json.name }}.length > 0
Condition 3: {{ $json.message }}.length > 10
```

True path → continue processing
False path → Respond with 400 error + specific validation failure

**Grading notes:** At least 3 validation rules required. Must test with both passing and failing data.

## Part B: Retry Logic (25 pts)

### Built-in Retry (10 pts)

HTTP Request node → Settings:
- Retry On Fail: Enabled
- Max Retries: 3
- Wait Between Retries: 1000ms

To test: point at a URL that intermittently fails, or use `https://httpstat.us/500` to force failures.

**Grading notes:** Must show the retry settings in a screenshot. Must show execution logs with retry attempts visible.

### Custom Retry Pattern (15 pts)

Using a loop with SplitInBatches (batch size 1) and a counter:

```javascript
// Code node: Retry Controller
const maxRetries = 3;
const item = $input.first().json;
const attempt = (item._retryCount || 0) + 1;
const backoffMs = Math.pow(2, attempt - 1) * 1000; // 1s, 2s, 4s

if (item._lastError && attempt > maxRetries) {
  // Max retries exhausted
  return [{ json: { ...item, status: 'failed', attempts: attempt - 1, error: item._lastError } }];
}

return [{ json: { ...item, _retryCount: attempt, _backoffMs: backoffMs, _attemptTimestamp: new Date().toISOString() } }];
```

Flow: Code (retry controller) → Wait (backoff) → HTTP Request → IF (success?) → True: done / False: loop back to retry controller

**Grading notes:** Must implement exponential backoff (not constant delay). Must handle both success-after-retry and exhausted-retries cases. Must log each attempt with timestamp.

## Part C: Monitoring (25 pts)

### Execution Logging (10 pts)

After each workflow run, append to a Google Sheet or file:

| Execution ID | Start | End | Duration | Status | Items Processed |
|---|---|---|---|---|---|
| 1234 | 14:30:00 | 14:30:03 | 3.1s | success | 1 |
| 1235 | 14:35:00 | 14:35:08 | 8.2s | failed | 0 |

**Grading notes:** Must capture at minimum: ID, timestamp, status, duration. Additional fields earn bonus consideration.

### Health Check Workflow (10 pts)

```
Schedule Trigger (every 1h) → HTTP Request (ping API) → IF (status 200?) 
  → True: log "healthy"
  → False: Send alert notification
```

Check multiple dependencies: API endpoints, credential validity, external services.

**Grading notes:** Must be a separate workflow with a schedule trigger. Must check at least one external dependency.

### Dashboard Sketch (5 pts)

Should include: executions over time chart, success/failure pie chart, avg duration trend line, error type breakdown.

**Grading notes:** Mockup, wireframe, or description all acceptable. Must include the 4 specified metrics.

## Part D: Failure Scenarios (20 pts)

**API Timeout (5 pts):**
- Set HTTP timeout to 10s. If exceeded, retry with backoff. After 3 retries, log error and notify. Already-processed items are safe since they passed before this node.

**Invalid AI Response (5 pts):**
- Wrap JSON.parse in try/catch. If AI returns non-JSON or missing fields, retry with a stricter prompt. After 2 retries, use a default/template response and flag for human review.

**Rate Limiting (5 pts):**
- Check for 429 status and Retry-After header. Pause workflow for the specified duration. Implement request queuing with delays between calls. Use batch processing (HW6) to control throughput.

**Partial Failure (5 pts):**
- Use "Continue On Fail" so subsequent items still process. Failed items are collected separately. After batch completes, report: X succeeded, Y failed. Optionally retry only failed items.

**Grading notes:** Each scenario: describe failure (1 pt), show handling mechanism (2 pts), demonstrate with test (2 pts). Accept description-only for scenarios that are hard to simulate, but prefer actual demonstrations.
