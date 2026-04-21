# HW1 Answer Key: Problem Statement & Stakeholder Analysis

## GENAI 490 — Capstone: AI Solution Design

**Exemplar Project: AI-Powered Clinical Documentation Assistant**

---

## Grading Notes for Instructors

This exemplar uses a healthcare documentation use case. Students may choose any domain — evaluate the quality of analysis, not the specific topic.

---

## Part 1: Problem Identification (20 pts)

**Domain context:** Healthcare, specifically outpatient primary care in the United States. Physician burnout has reached crisis levels, with documentation burden consistently cited as the #1 contributor (Medscape 2025 Burnout Report). The average physician spends 2 hours on EHR documentation for every 1 hour of patient contact (Sinsky et al., Annals of Internal Medicine).

**Current state:** Physicians dictate or type notes after encounters. Existing solutions include medical scribes ($30–50K/year per provider) and basic speech-to-text (Dragon Medical). Neither generates structured, compliant clinical notes from conversational patient encounters.

**Opportunity:** Large language models can now process multi-turn medical conversations and generate structured SOAP notes with appropriate medical terminology, ICD-10 codes, and follow-up recommendations. Recent advances in medical LLMs (Med-PaLM 2, GPT-4 with medical fine-tuning) make this feasible at clinical-grade accuracy.

**Scope:** In-scope — generating draft SOAP notes from recorded outpatient encounters for primary care. Out-of-scope — specialty care, surgical notes, billing automation, real-time transcription (using existing ASR).

> **Grading notes:** Full marks require clear domain context with evidence, honest assessment of current solutions, specific GenAI justification (not just "AI is powerful"), and explicit scope boundaries. Dock 3–5 pts if scope is missing or if the GenAI case is generic.

## Part 2: Problem Statement (15 pts)

> **Primary care physicians** need a way to **generate accurate, structured clinical documentation from patient encounters** because **they spend 50%+ of their workday on documentation, driving burnout and reducing patient face-time**. A successful solution would **reduce documentation time by 70% while maintaining 95%+ clinical accuracy as validated by physician review**.

Supporting evidence:
1. AMA 2024 report: 63% of physicians report burnout symptoms, with paperwork as leading cause
2. Average documentation time: 1.84 hours per hour of patient contact (Sinsky et al., 2016, confirmed in 2024 follow-up)
3. Medical scribe market projected at $3.2B by 2027, indicating willingness to pay for documentation relief

> **Grading notes:** The problem statement must be specific, measurable, and evidence-backed. Dock points for: no measurable outcome (-5), no evidence (-5), or a statement so broad it could apply to any AI project (-3).

## Part 3: Stakeholder Analysis (35 pts)

| Stakeholder | Interest | Influence | Impact | Needs & Concerns | Engagement Strategy |
|---|---|---|---|---|---|
| **Primary Care Physicians** | Reduce documentation burden; maintain note quality | High | High | Accurate notes; minimal editing; trust in AI output | Co-design sessions; pilot testing; iterative feedback |
| **Patients** | Privacy; accurate records; physician attention | Low | High | Consent for recording; data security; transparency about AI involvement | Consent process; opt-out mechanism; plain-language explanation |
| **Hospital IT/CISO** | Security; EHR integration; compliance | High | Medium | HIPAA compliance; audit trails; minimal infrastructure burden | Architecture review; security assessment; phased rollout |
| **Clinical Quality Officers** | Documentation accuracy; regulatory compliance | Medium | Medium | Coding accuracy; liability clarity; quality metrics | Accuracy benchmarks; side-by-side audits; reporting dashboard |
| **Medical Scribes (existing)** | Job security; role evolution | Low | High | Career transition; potential role shift to AI oversight | Transparent communication; retraining as AI reviewers |
| **Insurers/Payers** | Coding accuracy; fraud prevention | Medium | Low | Consistent, accurate ICD-10 coding; audit capability | Compliance documentation; coding accuracy data |

**Power/Interest Grid:**

```
                    HIGH INTEREST
                         |
    Manage Closely       |    Manage Closely
    (Hospital IT/CISO)   |    (Physicians)
                         |
LOW POWER ———————————————+——————————————— HIGH POWER
                         |
    Monitor              |    Keep Satisfied
    (Scribes, Patients)  |    (Quality Officers, Payers)
                         |
                    LOW INTEREST
```

> **Grading notes:** Look for: (1) at least 5 distinct stakeholders, (2) specific interests/concerns (not generic), (3) realistic influence/impact ratings, (4) actionable engagement strategies, (5) a power/interest grid that matches the ratings. Common mistakes: forgetting end-users who are affected but have low power (scribes, patients), or marking everyone as "High/High."

## Part 4: Success Criteria & Constraints (15 pts)

**Success Criteria:**
1. Reduce physician documentation time from 90 min/day to under 25 min/day (70% reduction)
2. Achieve 95%+ clinical accuracy on SOAP note content (physician-validated)
3. Maintain 90%+ ICD-10 coding accuracy vs. professional medical coders
4. Physician satisfaction score ≥ 4.2/5.0 after 30-day pilot
5. Zero PHI data breaches during pilot and Year 1

**Technical constraints:** HIPAA-compliant cloud required; must integrate with Epic/Cerner via FHIR APIs; sub-60-second note generation for clinical workflow acceptance; no PHI in training data.

**Organizational constraints:** $200K pilot budget; 6-month timeline to pilot; requires IRB approval; physician champions needed for adoption.

**Ethical constraints:** Patient consent for encounter recording; risk of AI-generated notes containing errors that affect care; potential job displacement for medical scribes; bias in training data may affect note quality for non-English-speaking patients.

> **Grading notes:** Success criteria must be measurable with specific numbers. Dock 3 pts per vague criterion ("improve documentation"). Constraints should be realistic and domain-specific. Generic constraints like "limited budget" without specifics earn partial credit.

## Part 5: Ethical Pre-Assessment (15 pts)

**Who could be harmed?**
- Patients if AI-generated notes contain clinical errors that go unreviewed
- Medical scribes facing job displacement
- Non-English-speaking patients if model performance varies by language/dialect
- Physicians if over-reliance on AI erodes documentation skills

**Potential biases:**
- Training data likely over-represents English-speaking, standardized encounters
- Medical terminology may reflect biases in historical documentation (e.g., racial bias in pain descriptions)
- Model may perform worse on complex, multi-comorbidity cases underrepresented in training data

**Transparency requirements:**
- Patients must know encounters are recorded and AI-processed
- Notes must be clearly marked as AI-generated drafts requiring physician review
- Audit trail showing AI-generated vs. physician-edited content

**Top 3 risk mitigations:**
1. **Clinical error → patient harm:** Mandatory physician review before note finalization; confidence scoring on each note section; flagging uncertain content
2. **Bias in outputs:** Regular equity audits across patient demographics; diverse evaluation dataset; monitoring for systematic differences
3. **Privacy breach:** BAA with all vendors; end-to-end encryption; no PHI in prompts (use de-identification pipeline); regular penetration testing

> **Grading notes:** Full marks require genuine engagement with ethical risks, not performative acknowledgment. Look for: specific harms to specific groups, awareness of AI-specific bias vectors, and concrete (not generic) mitigations. "We will be ethical" earns minimal credit.
