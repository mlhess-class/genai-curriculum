# HW4 Answer Key: User Testing Findings & Iteration Plan

## GENAI 490 — Capstone: AI Solution Design

**Exemplar Project: AI-Powered Clinical Documentation Assistant**

---

## Grading Notes for Instructors

Real user testing with 5+ participants is required. Evaluate the rigor of methodology and depth of synthesis, not whether findings are positive.

---

## Part 1: Test Plan Design (15 pts)

**Target users:** 6 primary care physicians from two outpatient clinics (mix of residents and attendings; 2–25 years experience; varying EHR comfort levels).

**Methodology:** Moderated, think-aloud, task-based sessions. 45 minutes each: 5 min intro, 30 min tasks, 10 min debrief interview.

**Task scenarios:**
1. Upload a recording of a routine follow-up visit and review the generated SOAP note
2. Identify and correct any errors in the AI-generated note
3. Review a note generated from a complex multi-complaint encounter
4. Approve a note and submit to (simulated) EHR
5. Handle a failed transcription (poor audio quality)

**Data collection:**
- Task completion (binary)
- Time-on-task (seconds)
- Error detection rate (did they catch planted errors?)
- System Usability Scale (SUS) post-session
- Trust rating per note (1–5: "I would sign this note as-is")
- Think-aloud observations coded for: trust, confusion, delight, frustration

**AI-specific observation criteria:**
- Do physicians read the full note or skim?
- Do they verify against the transcript?
- How do they react to [REVIEW NEEDED] flags?
- Do they over-trust (approve without reading) or under-trust (rewrite from scratch)?

> **Grading notes:** The plan must include AI-specific criteria — generic usability testing plans earn ≤10/15. Task scenarios should exercise both happy paths and failure modes.

## Part 2: Testing Execution & Raw Findings (30 pts)

**Participant profiles:**

| ID | Role | Years | AI Experience | EHR Comfort |
|---|---|---|---|---|
| P1 | Attending | 15 | Low | High |
| P2 | Resident (PGY-3) | 3 | Medium | Medium |
| P3 | Attending | 22 | Low | Low |
| P4 | Attending | 8 | High | High |
| P5 | Resident (PGY-2) | 2 | High | Medium |
| P6 | Attending | 12 | Medium | High |

**Quantitative data:**

| Task | Completion Rate | Avg Time | Trust Rating (1-5) |
|---|---|---|---|
| 1. Routine note review | 6/6 (100%) | 4.2 min | 3.8 |
| 2. Error identification | 4/6 (67%) | 6.1 min | N/A |
| 3. Complex encounter | 5/6 (83%) | 7.8 min | 2.9 |
| 4. Approve & submit | 6/6 (100%) | 1.1 min | N/A |
| 5. Failed transcription | 3/6 (50%) | 3.5 min | N/A |

**SUS Score:** 72.5 (above average, "Good" range)

**Key qualitative observations:**

- P1: "This is actually really close to what I'd write. I just need to tweak the assessment." (Edited 15% of routine note)
- P3: "I don't trust this. How do I know it didn't make something up?" (Rewrote 60% of note despite it being accurate)
- P4: Approved a note in 45 seconds without reading past the subjective section. Note contained a minor ICD-10 error in assessment. **Over-trust concern.**
- P5: "The [REVIEW NEEDED] flags are really helpful — I go straight to those."
- P2: "For the complex visit, this missed the patient's concern about their medication side effects. It was buried in the transcript but clinically relevant."

**AI trust observations:**
- 2/6 physicians showed over-trust patterns (minimal review before approval)
- 1/6 showed severe under-trust (essentially rewrote notes, negating time savings)
- 3/6 showed appropriate calibrated trust (reviewed key sections, made targeted edits)
- [REVIEW NEEDED] flags were universally appreciated but P3 said "everything should be flagged"

> **Grading notes:** Raw data must be real, not fabricated. Hallmarks of fabrication: all perfect scores, no negative feedback, suspiciously round numbers. The trust observations are crucial — dock 10 pts if missing.

## Part 3: Findings Synthesis (30 pts)

**Top 5 findings (ranked by severity × frequency):**

**1. Over-trust risk with routine encounters (Critical, 2/6 affected)**
Physicians with high AI comfort (P4, P5) approved notes with minimal review. P4 missed an ICD-10 error. In production, this could lead to billing errors or clinical documentation inaccuracies.
- Evidence: P4 spent 45 sec on review (vs. 4.2 min average); missed planted error
- Mitigation: Add a "review checklist" before approval; require explicit confirmation of assessment and plan sections

**2. Complex encounters produce significantly worse output (Major, 4/6 affected)**
Multi-complaint visits generated notes that missed secondary complaints or conflated separate issues. Trust rating dropped from 3.8 to 2.9.
- Evidence: Trust ratings; P2 and P6 both noted missed complaints; P3 abandoned the note entirely
- Mitigation: Multi-pass generation for complex encounters; detect multiple chief complaints and process separately

**3. Error recovery UX is confusing (Major, 3/6 affected)**
When transcription failed (Task 5), 3/6 physicians didn't know what to do. Error message was technical ("ASR confidence below threshold").
- Evidence: 50% task completion rate; P1: "What does 'confidence threshold' mean?"
- Mitigation: Plain-language error messages; clear "retry with different audio" option; manual transcript entry fallback

**4. Transcript-to-note traceability is wanted but insufficient (Minor, 5/6 mentioned)**
Physicians want to click a note sentence and see the source transcript segment. Current side-by-side view requires manual scanning.
- Evidence: 5/6 mentioned in debrief; average 2.1 min spent finding source for a single note statement
- Mitigation: Add clickable references linking note sentences to transcript timestamps

**5. [REVIEW NEEDED] flags drive appropriate behavior (Enhancement/Positive)**
Flags were the single most praised feature. Physicians consistently went to flagged sections first.
- Evidence: All 6 participants commented positively; P5 specifically cited flags as the feature that "makes this trustworthy"
- Action: Expand flagging taxonomy (uncertainty vs. clinical sensitivity vs. missing data)

**AI-specific findings:**
- **Output quality perception:** Routine encounters rated high (3.8/5); complex encounters low (2.9/5)
- **Trust calibration:** Bimodal — experienced physicians either over- or under-trusted; residents showed better calibration (possibly due to more AI familiarity)
- **Explainability gap:** "How does it decide what's assessment vs. plan?" was asked by 3/6 participants
- **Edge case discovery:** P6 tested with a note where patient mentioned suicidal ideation casually — system did not flag this appropriately

> **Grading notes:** Findings must be grounded in evidence (quotes, numbers, observation counts). "Users liked it" is not a finding. "3/6 physicians approved notes in under 60 seconds; 1 missed a planted error, suggesting over-trust risk" is a finding.

## Part 4: Iteration Plan (25 pts)

**Prioritization matrix:**

```
              HIGH IMPACT
                  |
  Quick Wins      |    Major Projects
  - Error UX (F3) |    - Complex encounter handling (F2)
  - Flag taxonomy  |    - Over-trust prevention (F1)
                  |
LOW EFFORT ———————+——————— HIGH EFFORT
                  |
  Nice-to-Have    |    Defer
  - (none)        |    - Transcript linking (F4)
                  |
              LOW IMPACT
```

**Sprint 2 scope:**

| Priority | Action | Expected Impact | Validation |
|---|---|---|---|
| 1 | Add review checklist before approval (F1) | Reduce over-trust; increase error catch rate | A/B test: checklist vs. no checklist; measure error detection |
| 2 | Multi-pass generation for complex encounters (F2) | Improve complex encounter accuracy from 2.9 to 3.5+ trust rating | Re-test with same complex encounter scenarios |
| 3 | Plain-language error messages + retry UX (F3) | Improve Task 5 completion from 50% to 90%+ | Retest error scenario with 3 participants |
| 4 | Expand [REVIEW NEEDED] flag taxonomy (F5+) | Better trust calibration; catch suicidal ideation case | Include sensitive content test cases |

**Deferred:** Transcript-to-note clickable linking (F4) — high effort, moderate impact. Will implement post-capstone if time permits. Workaround: improved side-by-side search.

**Updated success criteria:**
- Original: "Reduce documentation time by 70%" → Revised: "Reduce documentation time by 60% for routine encounters; 40% for complex encounters" (based on finding that complex encounters need more review)
- Added: "Zero instances of over-trust approval of clinically significant errors in testing"

> **Grading notes:** The plan must flow directly from findings. If Finding #1 is "over-trust risk" but the iteration plan focuses on UI polish, that's a disconnect. Validation approach is important — how will they know the fix worked?
