# HW2 Answer Key: Architecture Design Document

## GENAI 490 — Capstone: AI Solution Design

**Exemplar Project: AI-Powered Clinical Documentation Assistant**

---

## Grading Notes for Instructors

Evaluate architecture decisions on coherence and justification, not whether they match this specific exemplar. Students should demonstrate they understand trade-offs.

---

## Part 1: System Overview (15 pts)

**Solution summary:** A cloud-based system that ingests audio recordings of patient-physician encounters, transcribes them using a medical ASR model, processes the transcript through an LLM pipeline to generate structured SOAP notes with ICD-10 codes, and delivers draft notes to the physician via EHR integration for review and approval.

**Key design decisions:**

| Decision | Choice | Alternative Considered | Rationale |
|---|---|---|---|
| Model approach | RAG over medical guidelines + GPT-4 | Fine-tuned medical LLM | Faster iteration; no PHI in training; guidelines update frequently |
| Transcription | Whisper (large-v3) + medical vocabulary boost | Dragon Medical One API | Cost (10x cheaper at scale); customizable; self-hosted for HIPAA |
| Vector DB | Pinecone (managed) | Weaviate (self-hosted) | Managed service reduces ops burden during pilot; can migrate later |
| Deployment | AWS (GovCloud) | Azure Health | Existing hospital AWS relationship; GovCloud HIPAA pre-authorization |
| Note format | FHIR DocumentReference | Custom JSON | Standards compliance; EHR interoperability |

**Architecture diagram** (described — students would include actual diagram):

```
[Audio Recording] → [Medical ASR] → [Transcript]
                                         ↓
[Medical Guidelines DB] → [RAG Retrieval] → [LLM Pipeline] → [Draft SOAP Note]
                                                                    ↓
                                                    [Physician Review UI] → [EHR via FHIR]
```

> **Grading notes:** Diagram must show data flow clearly. Decisions need alternatives — if a student just lists what they chose without saying what else they considered, dock 5 pts. "We chose React because it's popular" is not justification.

## Part 2: Component Design (30 pts)

### Data Layer
- **Sources:** Audio files (WAV/MP3) from clinic recording devices; medical coding databases (ICD-10-CM); clinical practice guidelines (USPSTF, AHA); EHR patient context via FHIR
- **Storage:** S3 (encrypted, GovCloud) for audio; Pinecone for guideline embeddings (text-embedding-3-large, 3072 dimensions); PostgreSQL for metadata/audit logs
- **Preprocessing:** Audio normalization → ASR → speaker diarization → de-identification pipeline (regex + NER for PHI) → chunking (512 tokens, 50-token overlap) for RAG corpus

### AI/Model Layer
- **Foundation model:** GPT-4 Turbo via Azure OpenAI (BAA-covered)
- **Strategy:** RAG over medical guidelines + few-shot prompting with SOAP note examples
- **Example prompt:**

```
You are a clinical documentation assistant. Given the following encounter transcript
and relevant clinical guidelines, generate a structured SOAP note.

## Encounter Transcript
{transcript}

## Relevant Guidelines
{retrieved_guidelines}

## SOAP Note Format
- Subjective: Patient's chief complaint, HPI, ROS in their words
- Objective: Vitals, exam findings mentioned by physician
- Assessment: Clinical assessment with ICD-10 codes
- Plan: Treatment plan, medications, follow-up

Generate the note. Flag any section where you are uncertain with [REVIEW NEEDED].
```

- **Guardrails:** Output validation against SOAP schema; ICD-10 code verification against official database; confidence scoring per section; profanity/hallucination detection

### Application Layer
- **API:** REST API (FastAPI); endpoints: `POST /encounters` (upload audio), `GET /notes/{id}` (retrieve draft), `PUT /notes/{id}` (physician edits), `POST /notes/{id}/approve` (finalize)
- **Orchestration:** Celery task queue for async processing (ASR → RAG → LLM → validation)
- **Caching:** Redis for frequently retrieved guidelines; 15-min TTL on embedding search results

### Interface Layer
- **Primary UI:** EHR-embedded widget (Epic MyApps or Cerner Open) showing draft note alongside original transcript
- **Interaction:** Side-by-side view; click any note section to see source transcript excerpt; inline editing; one-click approve
- **Accessibility:** WCAG 2.1 AA; keyboard navigation; screen reader compatible

> **Grading notes:** Each layer should have specific, justified choices. Common weak spots: vague prompt templates, missing guardrails, no caching strategy, and ignoring accessibility. Full marks require actual prompt examples and specific model/tool names.

## Part 3: Infrastructure & Deployment (20 pts)

- **Cloud:** AWS GovCloud (HIPAA-eligible; existing hospital relationship)
- **Containers:** ECS Fargate (serverless containers) for API and workers; no GPU needed (using Azure OpenAI API)
- **CI/CD:** GitHub Actions → ECR → ECS blue-green deployment; staging environment mirrors production
- **Monitoring:** CloudWatch for infra; Datadog for application metrics; custom dashboard for AI-specific metrics (latency per pipeline stage, token usage, confidence scores, physician edit rates)

**Cost estimation:**

| Component | Pilot (monthly) | Production (monthly) |
|---|---|---|
| Azure OpenAI (GPT-4 Turbo) | $800 (50 encounters/day) | $4,500 (300 encounters/day) |
| Whisper ASR (self-hosted on EC2) | $400 | $1,200 |
| Pinecone | $70 | $230 |
| AWS infra (ECS, S3, RDS, etc.) | $600 | $2,100 |
| Monitoring/logging | $100 | $400 |
| **Total** | **$1,970** | **$8,430** |

> **Grading notes:** Cost estimates must be grounded in real pricing. "Approximately $5,000/month" with no breakdown gets partial credit. Students should show they actually looked up pricing pages.

## Part 4: Security & Compliance (15 pts)

- **AuthN/AuthZ:** OAuth 2.0 via hospital identity provider; role-based access (physician: read/write own notes; admin: audit all)
- **Data privacy:** AES-256 encryption at rest; TLS 1.3 in transit; PHI de-identification before LLM processing; BAAs with Azure OpenAI and AWS
- **Model security:** Input validation (max token limits); output schema enforcement; no raw LLM errors exposed to users; prompt injection testing (adversarial audio inputs)
- **Compliance:** HIPAA (BAAs, audit logs, access controls, breach notification plan); SOC 2 Type II for production

> **Grading notes:** Healthcare projects must address HIPAA specifically. Other domains should address relevant regulations. Generic "we will encrypt data" without specifics earns partial credit.

## Part 5: Technical Risk Assessment (20 pts)

| Risk | Likelihood | Impact | Mitigation | Contingency |
|---|---|---|---|---|
| LLM hallucinated medical information | High | Critical | RAG grounding; confidence scoring; [REVIEW NEEDED] flags | Mandatory physician review; automatic escalation for low-confidence notes |
| ASR errors for accented speech | Medium | High | Medical vocabulary boosting; test across accents; diarization improvements | Fallback to manual transcription; offer transcript correction UI |
| Azure OpenAI rate limits during peak hours | Medium | Medium | Request queuing; retry with exponential backoff; reserved capacity | Pre-generate notes during off-peak; batch processing option |
| EHR integration API changes/downtime | Low | High | FHIR standard compliance; integration tests in CI; health checks | Queue notes for delivery; manual export as fallback |
| PHI leakage via prompt/completion logging | Low | Critical | No PHI in prompts (de-identification first); disable API-side logging; audit trail | Incident response plan; breach notification procedure; cyber insurance |

> **Grading notes:** Risks must be specific to the project, not generic software risks. "Server might crash" is too vague. Look for AI-specific risks (hallucination, bias, prompt injection, vendor lock-in). Mitigations should be concrete and realistic.
