# HW5 Model Answers: Security & Guardrails

## Part A: Threat Model

### Risk Matrix

| Threat | Likelihood | Impact | Risk Level | Mitigation |
|--------|-----------|--------|------------|------------|
| Direct prompt injection | High | High | **Critical** | Input classifier + instruction hierarchy |
| Indirect injection (via RAG) | Medium | High | **High** | Content sanitization + privileged context separation |
| PII leakage | Medium | High | **High** | Output regex filter + NER-based detection |
| Jailbreaking | High | Medium | **High** | Multi-layer safety classifiers |
| Data exfiltration | Low | Critical | **High** | No external tool access without allowlist |
| Model poisoning | Low | Critical | **Medium** | Supply chain verification, model checksums |
| DoS via token abuse | Medium | Medium | **Medium** | Per-user rate limiting + token budgets |

## Part B: Guardrail Implementation

### 1. Input Validation (Prompt Injection Detection)

```python
# Method 1: Classifier-based
injection_classifier = pipeline("text-classification",
    model="protectai/deberta-v3-base-prompt-injection-v2")

def detect_injection_ml(text: str) -> bool:
    result = injection_classifier(text)
    return result[0]['label'] == 'INJECTION' and result[0]['score'] > 0.85

# Method 2: Rule-based
INJECTION_PATTERNS = [
    r"ignore (?:all |previous |above )instructions",
    r"you are now",
    r"system:\s*",
    r"<\|im_start\|>",
    r"ADMIN OVERRIDE",
    r"```system",
]

def detect_injection_rules(text: str) -> bool:
    return any(re.search(p, text, re.IGNORECASE) for p in INJECTION_PATTERNS)

def validate_input(text: str) -> tuple[bool, str]:
    if detect_injection_ml(text):
        return False, "Potential prompt injection detected (ML)"
    if detect_injection_rules(text):
        return False, "Potential prompt injection detected (rules)"
    return True, "OK"
```

### 2. Output Filtering (PII Redaction)

```python
PII_PATTERNS = {
    "SSN": r"\b\d{3}-\d{2}-\d{4}\b",
    "EMAIL": r"\b[\w.-]+@[\w.-]+\.\w+\b",
    "PHONE": r"\b(?:\+1[-.\s]?)?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}\b",
    "CREDIT_CARD": r"\b(?:\d{4}[-\s]?){3}\d{4}\b",
}

def redact_pii(text: str) -> str:
    for pii_type, pattern in PII_PATTERNS.items():
        text = re.sub(pattern, f"[REDACTED_{pii_type}]", text)
    # Also use spaCy NER for names
    doc = nlp(text)
    for ent in reversed(doc.ents):
        if ent.label_ == "PERSON":
            text = text[:ent.start_char] + "[REDACTED_NAME]" + text[ent.end_char:]
    return text
```

### 3. Content Safety
- OpenAI moderation API as first pass
- Local classifier (LlamaGuard) for custom categories
- Block if either flags content; log for review

### 4. Rate Limiting
```python
# Redis sliding window: 100K tokens/user/hour
async def check_token_budget(user_id: str, tokens: int) -> bool:
    key = f"budget:{user_id}"
    current = await redis.get(key) or 0
    if int(current) + tokens > 100_000:
        return False
    await redis.incrby(key, tokens)
    await redis.expire(key, 3600)
    return True
```

### 5. Audit Logging
- Structured JSON logs: timestamp, user_id, request_hash, redacted input/output, guardrail decisions, latency
- Shipped to centralized logging (ELK stack)
- Retention: 90 days, encrypted at rest

### 6. Tool Sandboxing
- Allowlist of permitted functions with parameter schemas
- No filesystem or network access from tool calls
- All tool outputs sanitized before returning to LLM context

## Part C: Red Team Results

| Attack Category | Attempts | Blocked | Bypass | Success Rate |
|----------------|----------|---------|--------|-------------|
| Direct injection | 12 | 11 | 1 | 8.3% |
| Indirect injection | 8 | 7 | 1 | 12.5% |
| Multi-turn jailbreak | 5 | 5 | 0 | 0% |
| Encoding bypass | 5 | 4 | 1 | 20% |
| **Total** | **30** | **27** | **3** | **10%** |

**False positive rate on 200 benign queries:** 3.5% (7 flagged incorrectly)

**Latency overhead:** +45ms average (ML classifier is the bottleneck)

**Bypass analysis:** Encoding-based attacks (base64 nested in markdown) are hardest to catch. Recommendation: decode common encodings before classification.
