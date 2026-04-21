# Homework 5: Hallucination Audit

**GENAI 101 — Foundations of Generative AI**
**Due:** End of Week 12 | **Points:** 50 (5% of final grade)

---

## Learning Objectives

- Systematically test AI models for factual accuracy and reasoning failures
- Develop strategies for detecting and mitigating AI hallucinations
- Understand the types and causes of AI errors
- Build critical evaluation habits for AI-generated content

## Instructions

### Part 1: Hallucination Taxonomy (10 points)

Create a categorized list of at least **6 types** of AI hallucination/error, with a definition and example of each. Categories might include:
- Fabricated facts (e.g., fake citations, invented statistics)
- Confident incorrectness (wrong answer stated with certainty)
- Temporal confusion (mixing up dates, attributing events to wrong eras)
- Source fabrication (citing papers, books, or URLs that don't exist)
- Logical reasoning errors
- Conflation (merging facts about different entities)

Use examples from published research, news reports, or your own testing.

### Part 2: Systematic Audit (25 points)

Design and execute a structured test of **one** AI model across **10 prompts** specifically designed to probe for hallucinations. Your prompts must cover at least 4 different categories from Part 1.

**For each prompt, document:**
1. The prompt you used
2. The AI's complete response
3. Your fact-check (with sources) — is the response accurate?
4. If inaccurate: what type of hallucination occurred?
5. Confidence assessment: how confidently did the AI state the incorrect information?

**Suggested prompt strategies:**
- Ask about obscure but verifiable facts
- Request specific citations or URLs
- Ask about very recent events
- Pose math/logic puzzles with known answers
- Ask the AI to compare things that don't exist with things that do
- Request statistics about specific topics

### Part 3: Mitigation Strategies (10 points)

For 3 of your hallucination examples, try to **fix the hallucination** using prompt engineering. Document:
- Your original prompt (that produced the hallucination)
- Your revised prompt (designed to reduce hallucination)
- The new response — did it improve?
- Analysis: which strategies helped? (e.g., asking for sources, requesting hedging language, breaking into smaller questions)

### Part 4: Audit Report Summary (5 points)

Write a 300-word executive summary of your findings:
- What was the overall hallucination rate in your test?
- Which categories were most common?
- How confident should users be in AI outputs?
- What 3 practices would you recommend to any AI user?

## Submission Format

- Single PDF or Word document
- Include all prompts, responses, fact-checks, and analyses
- Submit via the course LMS by 11:59 PM on the due date

## Rubric

| Criteria | Excellent (90-100%) | Good (80-89%) | Adequate (70-79%) | Needs Work (<70%) |
|----------|-------------------|---------------|-------------------|-------------------|
| Taxonomy | 6+ well-defined categories with sourced examples | 5 categories, adequate examples | 4 categories or weak examples | Incomplete |
| Systematic Audit | 10 diverse prompts, thorough fact-checking with sources | 8+ prompts, mostly verified | 6-7 prompts or thin fact-checking | Fewer than 6 or no verification |
| Mitigation | 3 creative fixes tested and analyzed | 2 strong attempts | 1 attempt or superficial | Missing |
| Summary | Clear, data-driven, actionable recommendations | Adequate summary | Generic | Missing |
