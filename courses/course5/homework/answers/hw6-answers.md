# HW6 Answer Key: Final Portfolio Draft

## GENAI 490 — Capstone: AI Solution Design

**Exemplar Project: AI-Powered Clinical Documentation Assistant**

---

## Grading Notes for Instructors

This is the capstone synthesis. Evaluate whether the portfolio tells a coherent story with genuine reflection — not whether it's a perfect project. The best portfolios show evolution of thinking and honest assessment of limitations.

---

## Part 1: Portfolio Narrative (25 pts)

**Exemplar excerpt (condensed):**

### The Problem
When I started this project, I framed the problem as "physicians spend too much time on documentation." That was true but shallow. Through stakeholder analysis and user testing, I learned the real problem is more nuanced: **documentation burden fragments the physician-patient relationship, degrades clinical quality, and accelerates burnout — and existing solutions either don't scale (scribes) or don't produce clinical-grade output (dictation software).**

The 90-minute daily documentation burden isn't just inefficiency. It's 90 minutes of a trained clinician doing work that an AI system can draft in 60 seconds — if we get the trust model right.

### The Approach
I chose a RAG-based approach over fine-tuning for three reasons: (1) no PHI in training data, (2) clinical guidelines update frequently, and (3) faster iteration during a 15-week capstone. The biggest architectural decision was investing early in guardrails — the [REVIEW NEEDED] flagging system became the feature that physicians valued most.

### The Solution
The system processes encounter audio through three stages: transcription (Whisper API), retrieval-augmented generation (GPT-4 + clinical guidelines), and physician review with an interactive approval workflow. It handles routine encounters well (3.8/5 trust rating, 60% time savings) and complex encounters adequately (2.9/5, 40% savings — an area for continued improvement).

### The Evidence
User testing with 6 physicians revealed that the core technology works but trust calibration is the real design challenge. Two physicians over-trusted (approving without reading), one under-trusted (rewriting everything), and three showed appropriate calibration. The [REVIEW NEEDED] flags were the key to appropriate trust. The business case projects 187% Year 1 ROI with a 7-month payback period.

### The Reflection
My biggest mistake was spending two weeks trying to self-host Whisper when the API was cheaper at MVP scale. My biggest surprise was that the AI accuracy wasn't the bottleneck — **physician trust calibration was the harder design problem.** I'm most proud of the evaluation framework: honest testing with diverse scenarios that revealed real failures (the noisy audio hallucination bug, the missed suicidal ideation flag) rather than only showcasing successes.

> **Grading notes:** The narrative must show evolution — if the HW6 problem statement is identical to HW1, the student hasn't learned anything. Look for: changed assumptions, surprises, and genuine insight. Dock heavily for portfolios that read like six homework summaries concatenated.

## Part 2: Technical Portfolio (25 pts)

**Expected artifacts:**
- Updated architecture diagram reflecting actual build (not HW2's plan)
- Working demo link or polished screen recording (8–12 min)
- Clean GitHub repo with README covering: setup, architecture, key decisions
- Prompt library with version history showing evolution
- Evaluation results table with before/after Sprint 1 vs Sprint 2

> **Grading notes:** The code doesn't need to be production-ready, but the README must be professional. A repo with no README = -10 pts. Prompt evolution is important — students should show how prompts improved through testing.

## Part 3: Impact & Outcomes (20 pts)

**Comparison to original success criteria:**

| Criterion (HW1) | Target | Actual | Status |
|---|---|---|---|
| Documentation time reduction | 70% | 60% routine / 40% complex | ⚠️ Partially met |
| Clinical accuracy | 95%+ | 92% routine / 78% complex | ⚠️ Partially met |
| ICD-10 coding accuracy | 90%+ | 88% | ⚠️ Close |
| Physician satisfaction | ≥4.2/5 | 3.8/5 (SUS: 72.5) | ❌ Not met |
| Zero PHI breaches | Zero | Zero | ✅ Met |

**Honest assessment:**
"We hit our targets for routine encounters but fell short on complex ones. The 70% time reduction target was optimistic — 60% is still transformative, saving physicians nearly an hour per day. The satisfaction gap (3.8 vs 4.2) is driven by the complex encounter experience and initial learning curve. With continued iteration, both metrics are achievable."

**Limitations for production:**
- Diarization accuracy (85%) needs improvement for multi-speaker encounters
- Complex encounters need multi-pass generation or human-in-loop architecture
- EHR integration not completed (standalone app only)
- Only tested with English-language encounters
- Sample size (6 physicians) too small for statistical significance

> **Grading notes:** Honest assessment of gaps is worth more than inflated claims of success. Students who admit "we didn't hit our target and here's why" demonstrate more learning than those who quietly move the goalposts.

## Part 4: Lessons Learned & Professional Reflection (15 pts)

**Exemplar excerpts:**

**Technical:** "The most important technical lesson: guardrails aren't a nice-to-have, they're the product. The [REVIEW NEEDED] flagging system took 10% of my development time but delivered 50%+ of the user value."

**Process:** "I learned that architecture documents are hypotheses, not contracts. Every major decision from HW2 was either validated, revised, or abandoned during implementation — and that's not failure, it's engineering."

**Ethical:** "In HW1, my ethical analysis felt like a checkbox. By HW4, ethics felt urgent — when a test user's encounter mentioned suicidal ideation and the system didn't flag it, I understood that ethical AI isn't about principles on paper. It's about the specific, concrete moment when your system encounters a vulnerable human."

**Career:** "I came into this capstone thinking AI product development was about building the smartest model. I'm leaving it understanding that it's about building the right trust relationship between humans and AI systems."

> **Grading notes:** This section separates A portfolios from B portfolios. Generic reflections ("I learned a lot about AI") earn ≤8/15. Specific, honest, evidence-backed reflections earn full marks. The ethical reflection should show evolution from HW1.

## Part 5: Peer Review Readiness (15 pts)

**Self-assessment example:**

| Criterion | Self-Score | Justification |
|---|---|---|
| Portfolio Narrative | 22/25 | Coherent story with clear evolution, but could tighten the approach section |
| Technical Portfolio | 20/25 | Working demo, clean code, but API documentation incomplete |
| Impact & Outcomes | 16/20 | Honest about gaps; wish we'd hit the satisfaction target |
| Reflection | 13/15 | Genuine insights; ethical evolution is authentic |
| Peer Review Readiness | 13/15 | This self-assessment is honest; presentation outline ready |
| **Total** | **84/100** | |

**Questions for reviewers:**
1. "Does the business case adequately address the risk that physicians might resist AI documentation tools? What's missing?"
2. "Is our approach to complex encounters (multi-pass generation) the right direction, or should we consider a fundamentally different architecture?"
3. "How could we better address the non-English speaker limitation within realistic scope constraints?"

> **Grading notes:** Self-assessment should be realistic (not 98/100 or 40/100). Questions should be specific and substantive, not "is this good?" A student who scores themselves 95+ without strong justification shows poor self-awareness.
