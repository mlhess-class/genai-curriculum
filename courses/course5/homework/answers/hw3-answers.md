# HW3 Answer Key: Prototype Report (Sprint 1 MVP)

## GENAI 490 — Capstone: AI Solution Design

**Exemplar Project: AI-Powered Clinical Documentation Assistant**

---

## Grading Notes for Instructors

The prototype doesn't need to be polished — it needs to work end-to-end on the core use case. Evaluate honesty about limitations as much as technical achievement.

---

## Part 1: Prototype Demo (30 pts)

**Demo access:** `https://github.com/student/clinical-doc-assistant` with screen recording linked in README.

**Demonstrated functionality:**
- Upload audio file of simulated patient encounter (WAV, 5–15 min)
- Automatic transcription via Whisper API
- SOAP note generation via GPT-4 with RAG over clinical guidelines
- Side-by-side view of transcript and generated note
- Edit and approve workflow

**Checklist:**
- [x] Core AI functionality (transcript → SOAP note) working
- [x] Complete user workflow (upload → review → approve)
- [x] Real OpenAI API calls (not mocked)
- [x] Basic error handling (file format validation, API timeout retry, empty transcript detection)

> **Grading notes:** Core AI must use real model calls. A beautiful UI with mocked AI responses earns ≤15/30. A rough UI with real, working AI integration earns 22–28/30. Both = full marks. Non-functional prototype = ≤10/30.

## Part 2: Technical Implementation Report (30 pts)

**Stack (actual vs. planned):**

| Component | Planned (HW2) | Actual | Why Changed |
|---|---|---|---|
| Backend | FastAPI + Celery | FastAPI (synchronous) | Celery added unnecessary complexity for MVP; async not needed at 5 users |
| Frontend | EHR-embedded widget | Standalone React app | EHR integration requires hospital IT approval; standalone faster for MVP |
| ASR | Self-hosted Whisper | OpenAI Whisper API | Self-hosting GPU instance was $400/mo; API is cheaper at MVP volume |
| Vector DB | Pinecone | ChromaDB (local) | Free; sufficient for MVP's small guideline corpus (~200 documents) |

**Model integration:**
- Whisper API for transcription (large-v3 model)
- OpenAI GPT-4 Turbo for SOAP note generation
- text-embedding-3-small for guideline embeddings (switched from large — cost savings, sufficient quality for this corpus size)
- RAG pipeline: 200 clinical guideline documents → chunked at 400 tokens → embedded → stored in ChromaDB → top-5 retrieval per encounter

**Actual prompt used:**
```
System: You are a clinical documentation assistant trained in medical terminology and
SOAP note formatting. You generate structured clinical notes from encounter transcripts.
Always flag uncertain content with [REVIEW NEEDED]. Never fabricate clinical findings
not mentioned in the transcript.

User: Generate a SOAP note from this encounter.

## Transcript:
{transcript}

## Relevant Clinical Guidelines:
{top_5_retrieved_chunks}

## Patient Context:
Age: {age}, Sex: {sex}, Known conditions: {conditions}

Respond with a JSON object containing: subjective, objective, assessment (with icd10_codes array), plan
```

**Key challenges:**
1. **Speaker diarization accuracy** — Whisper doesn't natively separate speakers. Solved with pyannote.audio for diarization, then aligned with Whisper timestamps. Still imperfect (~85% accuracy on speaker assignment).
2. **SOAP note hallucination** — Early prompts generated plausible but fabricated exam findings. Solved by adding explicit instruction "Never fabricate clinical findings not mentioned in the transcript" and adding transcript line references to each note section.
3. **Latency** — Full pipeline (ASR + RAG + LLM) took 90–120 seconds. Acceptable for MVP but needs optimization. Identified bottleneck: Whisper transcription (60% of total time).

**Code architecture:**
```
clinical-doc-assistant/
├── api/              # FastAPI routes
├── services/
│   ├── transcription.py   # Whisper integration
│   ├── diarization.py     # Speaker separation
│   ├── rag.py             # ChromaDB retrieval
│   ├── note_generator.py  # GPT-4 SOAP generation
│   └── validation.py      # Output schema validation
├── frontend/         # React app
├── data/guidelines/  # Clinical guideline corpus
└── tests/            # Test cases
```

> **Grading notes:** Honesty about changes from HW2 is essential. If everything "went exactly as planned," be skeptical. The challenges section should describe real problems, not trivial ones. "Setting up the dev environment" is not a meaningful challenge.

## Part 3: Output Evaluation (25 pts)

**Evaluation criteria:**
- **Clinical accuracy** — Does the note correctly reflect the encounter? (Scale: 1–5)
- **Completeness** — Are all relevant details captured? (Scale: 1–5)
- **Format compliance** — Proper SOAP structure, valid ICD-10 codes? (Pass/Fail)
- **Appropriate flagging** — Are uncertain sections flagged? (Pass/Fail)

**Results (10 test cases):**

| # | Encounter Type | Accuracy | Completeness | Format | Flagging | Pass? |
|---|---|---|---|---|---|---|
| 1 | Routine physical | 5 | 4 | Pass | Pass | ✅ |
| 2 | Acute respiratory infection | 4 | 5 | Pass | Pass | ✅ |
| 3 | Diabetes follow-up | 5 | 5 | Pass | Pass | ✅ |
| 4 | Mental health screening | 3 | 3 | Pass | Fail | ❌ |
| 5 | Pediatric well-visit | 4 | 4 | Pass | Pass | ✅ |
| 6 | Multi-complaint visit | 3 | 3 | Pass | Pass | ⚠️ |
| 7 | Non-native English speaker | 2 | 2 | Pass | Pass | ❌ |
| 8 | Noisy recording | 2 | 2 | Fail | Fail | ❌ |
| 9 | Medication reconciliation | 4 | 4 | Pass | Pass | ✅ |
| 10 | Follow-up with labs | 5 | 5 | Pass | Pass | ✅ |

**Pass rate:** 6/10 fully passing, 1 partial, 3 failing

**Failure analysis:**
- **Test 4 (Mental health):** Model did not flag sensitive mental health content for physician review. Root cause: prompt lacks instruction about mental health sensitivity. Fix: add mental health flagging rules.
- **Test 7 (Non-native speaker):** ASR quality degraded significantly with accented English. Transcript errors cascaded to note errors. Fix: explore multilingual ASR models; add transcript confidence scoring.
- **Test 8 (Noisy recording):** ASR produced garbage transcript; LLM generated plausible-looking but fabricated note from noise. This is a critical safety issue. Fix: add transcript quality scoring; reject below threshold.

> **Grading notes:** A 100% pass rate on 10 easy test cases is less valuable than a 60% pass rate with diverse cases and insightful failure analysis. The failure analysis is the most important part. Students who only test happy paths earn ≤15/25.

## Part 4: Sprint Retrospective (15 pts)

**What worked well:**
- RAG approach was right — grounding in guidelines dramatically reduced hallucination vs. pure prompting
- Starting with a simple synchronous pipeline made debugging much easier
- Using real (simulated) encounter audio from day 1 caught ASR issues early

**What didn't work:**
- Spent 2 weeks trying to self-host Whisper before switching to the API — should have started with the API
- Underestimated diarization difficulty; it's still the weakest link
- Initial ChromaDB chunking was too large (1000 tokens); retrieval quality improved significantly at 400

**Deviations from architecture:**
- Simplified from async Celery to synchronous (acceptable at MVP scale)
- Swapped EHR integration for standalone app (EHR access requires months of hospital IT process)
- Downgraded from Pinecone to ChromaDB (sufficient for MVP corpus size)

**Sprint 2 priorities:**
1. **Critical:** Add transcript quality scoring to prevent fabrication from bad audio (Test 8 failure)
2. **High:** Improve mental health content handling (Test 4)
3. **High:** Optimize latency — target <45 seconds for full pipeline
4. **Medium:** Test with more accented speech samples; evaluate alternative ASR
5. **Medium:** Add physician edit tracking to measure actual vs. generated note divergence

> **Grading notes:** The retrospective must show genuine reflection. "Everything went great, Sprint 2 will add more features" is a red flag. Look for: honest dead ends, specific lessons, and a Sprint 2 plan that directly addresses prototype weaknesses.
