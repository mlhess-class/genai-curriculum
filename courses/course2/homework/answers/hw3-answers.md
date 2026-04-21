# HW3 Answers: First n8n Workflow

**GENAI 201 — Model Answers & Grading Notes**

---

## Part A: Workflow Setup (25 pts)

### Model Workflow: Contact Form Processor

**Node 1 — Webhook (5 pts)**
- Type: Webhook
- Method: POST
- Path: `/contact-form`
- Expected body: `{ "name": "Jane", "email": "jane@example.com", "message": "I need help with..." }`

**Node 2 — Validate & Transform (5 pts)**
- Type: Code node
```javascript
const items = $input.all();
const results = [];

for (const item of items) {
  const { name, email, message } = item.json;
  
  if (!name || !email || !message) {
    results.push({
      json: { error: true, reason: "Missing required fields", received: item.json }
    });
    continue;
  }
  
  results.push({
    json: {
      name: name.trim(),
      email: email.trim().toLowerCase(),
      message: message.trim(),
      received_at: new Date().toISOString()
    }
  });
}

return results;
```

**Node 3 — Enrich (5 pts)**
- Type: Code node
- Extracts email domain, categorizes message by keywords:
```javascript
const item = $input.first().json;
const domain = item.email.split('@')[1];
const msg = item.message.toLowerCase();
const category = msg.includes('bug') ? 'bug_report'
  : msg.includes('feature') ? 'feature_request'
  : msg.includes('help') ? 'support'
  : 'general';

return [{ json: { ...item, domain, category } }];
```

**Node 4 — Format (5 pts)**
- Type: Code node
- Produces formatted summary text:
```javascript
const d = $input.first().json;
const summary = `📬 New Contact Submission
From: ${d.name} (${d.email})
Domain: ${d.domain}
Category: ${d.category}
Time: ${d.received_at}

Message:
${d.message}`;

return [{ json: { ...d, summary } }];
```

**Node 5 — Respond to Webhook (5 pts)**
- Type: Respond to Webhook
- Response body: `{ "status": "received", "category": "{{$json.category}}", "id": "{{$json.received_at}}" }`

**Grading notes:** Accept any valid 5-node flow. Nodes must connect logically — data must flow from one to the next. Deduct 5 pts for disconnected nodes. Deduct 3 pts if the webhook doesn't actually return a response or produce output.

## Part B: Testing (30 pts)

### Successful Test (10 pts)

```bash
curl -X POST http://localhost:5678/webhook/contact-form \
  -H "Content-Type: application/json" \
  -d '{"name": "Jane Doe", "email": "jane@startup.io", "message": "I need help with billing"}'
```

Expected response:
```json
{"status": "received", "category": "support", "id": "2026-04-15T14:30:00.000Z"}
```

**Grading notes:** Must show the actual curl command and the actual response received. Screenshot of n8n execution view is required.

### Edge Cases (10 pts)

| Test | Input | Expected Behavior |
|---|---|---|
| Missing field | `{"name": "Jane"}` | Returns error object, no crash |
| Empty strings | `{"name": "", "email": "", "message": ""}` | Caught by validation or treated as missing |
| Extra fields | `{"name": "Jane", "email": "j@x.com", "message": "hi", "phone": "555"}` | Extra fields ignored, processes normally |

**Grading notes:** Minimum 3 edge cases tested. Must show actual behavior, not just expected.

### Execution Log Analysis (10 pts)

Must show per-node input/output for at least one full execution. Should note data transformation at each step and execution time per node.

**Grading notes:** Screenshot of each node's data panel is ideal. Accept text description if clearly derived from actual execution.

## Part C: Documentation (25 pts)

**Grading notes:**
- Purpose (5 pts): Clear one-paragraph description
- Architecture (5 pts): Screenshot of canvas required
- Node descriptions (10 pts): Each node needs name, type, function, key config
- API contract (5 pts): Must document URL, method, body schema, response format

## Part D: Export & Iteration (20 pts)

**Improvement ideas (5 pts) — model answers:**
1. Add a database to store submissions for later retrieval
2. Send email notification to the team for high-priority categories
3. Add rate limiting to prevent webhook abuse

**6th Node (10 pts):** E.g., an IF node after enrichment that routes bug reports to a different output than general inquiries, or an HTTP Request node that logs to an external service.

**Grading notes:** The 6th node must add meaningful functionality, not just a pass-through. Deduct 5 pts for trivial additions.
