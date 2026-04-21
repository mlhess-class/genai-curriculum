# HW4 Answers: AI Integration

**GENAI 201 — Model Answers & Grading Notes**

---

## Part A: AI Node Setup (20 pts)

### Configure Credentials (5 pts)

In n8n: Settings → Credentials → Add Credential → OpenAI API. Enter API key. Test connection.

**Grading notes:** Screenshot must show credential type created. Key must be redacted.

### Basic AI Call (10 pts)

Manual Trigger → OpenAI Chat Model node:
- Model: `gpt-4o-mini`
- Prompt: "Summarize the benefits of workflow automation in 3 bullet points."

Output:
```
• Saves time by eliminating repetitive manual tasks
• Reduces human error through consistent, rule-based execution
• Enables scaling operations without proportional headcount increase
```

**Grading notes:** Must show input prompt and AI output in execution view. Any reasonable prompt is fine.

### Model Comparison (5 pts)

| Metric | gpt-4o-mini | gpt-4o |
|---|---|---|
| Quality | Good, concise | More nuanced, detailed |
| Response time | ~0.8s | ~2.1s |
| Tokens (in/out) | 22 / 68 | 22 / 95 |
| Est. cost | $0.00004 | $0.0008 |
| Production pick | ✅ For simple tasks | For complex reasoning |

**Grading notes:** Must compare at least 3 metrics. Must justify model choice.

## Part B: Content Pipeline (40 pts)

### Model Answer: Blog Post Generator

**Node 1 — Webhook Trigger:** Accepts `{ "topic": "...", "audience": "...", "tone": "..." }`

**Node 2 — Input Processing (Code):** Validates inputs, sets defaults for missing optional fields, constructs context string.

**Node 3 — AI Generate Outline (OpenAI):**
```
You are a professional content strategist.

Create a blog post outline for the following:
- Topic: {{ $json.topic }}
- Target audience: {{ $json.audience }}
- Tone: {{ $json.tone }}

Return a JSON object with:
- "title": compelling blog title
- "sections": array of { "heading": "...", "key_points": ["...", "..."] }

Respond ONLY with valid JSON, no markdown fencing.
```

**Node 4 — AI Generate Draft (OpenAI):**
```
You are a skilled blog writer. Write a 500–800 word blog post following this outline:

{{ $json.outline }}

Target audience: {{ $json.audience }}
Tone: {{ $json.tone }}

Format in Markdown with proper headings. Include an introduction and conclusion.
```

**Node 5 — Post-Processing (Code):**
```javascript
const draft = $input.first().json.message.content;
const wordCount = draft.split(/\s+/).length;
const metadata = {
  generated_at: new Date().toISOString(),
  word_count: wordCount,
  within_range: wordCount >= 450 && wordCount <= 850
};
return [{ json: { draft, metadata } }];
```

**Node 6 — Respond to Webhook:** Returns draft + metadata.

### Prompt Engineering (15 pts)

**Grading notes:** Full marks require:
- Role/persona instruction (✓ "You are a professional content strategist")
- Output format specification (✓ JSON structure defined)
- Dynamic variables (✓ uses `{{ $json.topic }}` etc.)
- Constraints or examples (✓ word count range, Markdown format)

Deduct 5 pts for hardcoded prompts with no dynamic variables. Deduct 3 pts for missing output format spec.

### Multi-Step AI (10 pts)

Two AI calls: outline generation → draft writing. The outline constrains the draft, producing better structure than a single-shot approach.

**Grading notes:** Must use AI node at least twice with the output of one feeding the next.

### Post-Processing (10 pts)

Word count validation is the minimum. Better answers also: parse JSON from AI output with error handling, strip markdown fences if present, validate required sections exist.

### Working Demo (5 pts)

Must show 3 different inputs with 3 different outputs. Topics should be meaningfully different.

## Part C: Cost & Performance (20 pts)

### Token Tracking (10 pts)

| Metric | Outline Call | Draft Call | Total |
|---|---|---|---|
| Input tokens | ~120 | ~350 | ~470 |
| Output tokens | ~200 | ~700 | ~900 |
| Cost (gpt-4o-mini) | $0.00009 | $0.00032 | $0.00041 |
| Monthly (100/day) | — | — | **$1.23** |

**Grading notes:** Actual numbers will vary. Must show per-call and total. Must project to monthly.

### Optimization (10 pts)

Model answer: Use gpt-4o-mini for outline (structured, simpler task) and gpt-4o only if quality check fails. Or: cache outlines for repeated topics. Before/after comparison required.

## Part D: Prompt Versioning (20 pts)

**V1:** Basic "write a blog post about X" → generic, no structure
**V2:** Added role, audience, tone, output format → much better structure
**V3:** Added few-shot example of ideal output, word count constraints, Markdown formatting rules → consistent quality

**Grading notes:** Must show 3 distinct versions with clear rationale for each change and sample output comparison. Template must have clearly marked variables with documentation of required vs optional.
