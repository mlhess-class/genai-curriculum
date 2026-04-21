# HW6 Answers: Advanced Patterns

**GENAI 201 — Model Answers & Grading Notes**

---

## Part A: Sub-Workflows (30 pts)

### Extract a Sub-Workflow (15 pts)

**Example:** Extract the "AI content generation + validation" logic from HW4 into a sub-workflow.

**Sub-workflow: `generate-content`**
- Input: `{ "prompt": "...", "model": "gpt-4o-mini", "max_tokens": 800 }`
- Nodes: Validate input → OpenAI call → Parse response → Validate output length → Return
- Output: `{ "content": "...", "tokens_used": 450, "model": "gpt-4o-mini", "valid": true }`

**Parent workflow:**
```
Webhook → Prepare prompt → Execute Sub-Workflow (generate-content) → Format → Respond
```

**Grading notes:** Sub-workflow must accept parameters (not hardcoded). Must return structured output. Must show the Execute Sub-Workflow node in the parent with parameter mapping.

### Reuse Demo (10 pts)

Call `generate-content` from:
1. Blog post generator (topic → prompt → sub-workflow → format as blog)
2. Email responder (customer message → prompt → sub-workflow → format as email)

Same sub-workflow, different contexts. Both produce valid output.

**Grading notes:** Must show two distinct callers. Same sub-workflow, different inputs producing different outputs.

### Documentation (5 pts)

```
## Sub-Workflow: generate-content

**Purpose:** Sends a prompt to an LLM and returns validated output.

**Inputs:**
| Parameter | Type | Required | Description |
|---|---|---|---|
| prompt | string | Yes | The full prompt to send |
| model | string | No | Model name (default: gpt-4o-mini) |
| max_tokens | number | No | Max output tokens (default: 800) |

**Outputs:**
| Field | Type | Description |
|---|---|---|
| content | string | Generated text |
| tokens_used | number | Total tokens consumed |
| valid | boolean | Whether output passed validation |

**Error Behavior:** Returns `{ "error": true, "message": "..." }` on failure. Does not throw.
```

**Grading notes:** Must document inputs with types and required/optional. Must document outputs. Must describe error behavior.

## Part B: Loops & Batch Processing (30 pts)

### Item-by-Item Loop (10 pts)

```
Webhook (receives array of 10 items)
  → SplitInBatches (batch size: 1)
    → Code (process item — e.g., AI summarization)
    → IF (success?)
      → True: collect result
      → False: log error, continue
    → Loop back to SplitInBatches
  → Merge all results
  → Respond
```

Key: "Continue On Fail" enabled so one item's failure doesn't stop the batch.

**Grading notes:** Must process ≥10 items. Must handle individual failures. Must show timing.

### Batch Splitting (10 pts)

SplitInBatches node: batch size = 3. After each batch, a Wait node adds 2-second delay (rate limiting).

Execution log should show:
- Batch 1: items 1-3 (0:00)
- Batch 2: items 4-6 (0:02)
- Batch 3: items 7-9 (0:04)
- Batch 4: item 10 (0:06)

**Grading notes:** Must use SplitInBatches with size > 1. Must include inter-batch delay. Must show batch behavior in logs.

### Aggregation (10 pts)

After all batches complete:
```javascript
const results = $input.all();
const successes = results.filter(r => r.json.status === 'success');
const failures = results.filter(r => r.json.status === 'failed');

return [{
  json: {
    summary: {
      total: results.length,
      succeeded: successes.length,
      failed: failures.length,
      success_rate: `${((successes.length / results.length) * 100).toFixed(1)}%`
    },
    results: results.map(r => r.json)
  }
}];
```

**Grading notes:** Must count successes/failures. Must produce a summary. Must include both individual results and aggregate stats.

## Part C: Parallel Execution (25 pts)

### Parallel Branches (15 pts)

```
Webhook (receives text)
  ├→ OpenAI: "Summarize this text in 2 sentences"
  ├→ OpenAI: "Extract 5 keywords from this text"  
  └→ OpenAI: "Classify the sentiment: positive/negative/neutral"
  
All three → Merge node (mode: Combine) → Format combined result → Respond
```

**Grading notes:** Must have 3+ parallel paths from a single trigger. Must use Merge node to combine. All paths must process the same input independently.

### Performance Comparison (10 pts)

| Approach | Node A | Node B | Node C | Total |
|---|---|---|---|---|
| Sequential | 1.2s | 0.9s | 0.8s | **2.9s** |
| Parallel | 1.2s | 0.9s | 0.8s | **~1.2s** |

Speedup factor: 2.9 / 1.2 = **2.4x**

**Grading notes:** Must measure actual execution times for both approaches. Must calculate speedup. Times will vary — accept any reasonable measurements with correct math.

## Part D: Production Pattern (15 pts)

**Model combined workflow:**

```
Schedule Trigger (daily)
  → HTTP Request (fetch list of pending items)
  → SplitInBatches (batch size: 5)           ← Loop
    → Execute Sub-Workflow (process-item)     ← Sub-workflow
    → Wait (1s between batches)
  → Fan out to parallel branches:             ← Parallel
    ├→ Generate summary report
    ├→ Update dashboard metrics
    └→ Send notification
  → Merge all outputs
  → Final summary → Send email
```

**Grading notes:**
- Parent orchestration (5 pts): Clear main workflow structure
- Sub-workflow call (3 pts): At least one Execute Sub-Workflow node
- Loop/batch (3 pts): SplitInBatches or equivalent
- Parallel fan-out (2 pts): Multiple paths from one point
- Final aggregation (2 pts): Merge + clean summary

Must provide screenshot, exported JSON, and sample execution. Deduct proportionally for missing patterns.
