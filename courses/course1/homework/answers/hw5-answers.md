# HW5 Answer Key: Hallucination Audit

**For TA Use Only**

---

## Part 1: Hallucination Taxonomy (10 points)

**Minimum 6 types required. Model taxonomy:**

1. **Fabricated Facts** — Inventing statistics, events, or details that never existed. *Example: "The first AI was created in 1943 by Alan Turing at MIT"*
2. **Source Fabrication** — Citing papers, books, or URLs that don't exist. *Example: Inventing a journal article with plausible-sounding author names and DOI*
3. **Confident Incorrectness** — Stating wrong information with absolute certainty and no hedging. *Example: "The capital of Australia is Sydney"*
4. **Temporal Confusion** — Mixing up dates or attributing events to wrong time periods. *Example: Saying GPT-4 was released in 2022*
5. **Entity Conflation** — Merging facts about different people, places, or things. *Example: Attributing one scientist's discoveries to another*
6. **Logical/Mathematical Errors** — Getting calculations or reasoning steps wrong while showing "work." *Example: Correct setup but arithmetic error*
7. **Anchoring Hallucination** — Generating plausible but false details to fill gaps in knowledge. *Example: Describing a real company's product that doesn't exist*
8. **Sycophantic Agreement** — Agreeing with user's false premise instead of correcting it. *Example: User says "Einstein invented the telephone" and AI elaborates on it*

**Grading:**
- 9-10: 6+ categories with clear definitions AND sourced/tested examples
- 7-8: 6 categories but examples are weak or unsourced
- 5-6: 4-5 categories
- <5: Fewer than 4

## Part 2: Systematic Audit (25 points)

**Check for:**
- 10 distinct prompts (5 pts)
- At least 4 different categories tested (5 pts)
- Complete AI responses included (3 pts)
- Fact-checking with actual sources (7 pts) — this is critical; students must show HOW they verified
- Correct identification of hallucination type when errors found (5 pts)

**Effective prompt strategies students might use:**
- "Who wrote the book [obscure but real title]?" — tests knowledge boundaries
- "Give me 5 academic sources about [topic]" — tests source fabrication
- "What happened on [specific date]?" — tests temporal accuracy
- Math word problems with known answers — tests reasoning
- "Is it true that [false claim]?" — tests sycophantic agreement

**Expected hallucination rate:** Varies by model, but students testing 10 prompts designed to probe weaknesses should find at least 2-4 hallucinations with modern models. If a student reports 0 hallucinations, their prompts likely weren't challenging enough.

**If student reports 10/10 hallucinations:** Their prompts may have been unfairly adversarial (asking about events after training cutoff, extremely obscure trivia). Discuss the difference between hallucination and knowledge limitations.

**Common mistakes:**
- Not actually fact-checking (just saying "this looks right")
- Fact-checking with another AI model (that's not verification!)
- Prompts that are all the same type
- Not including the AI's full response

## Part 3: Mitigation Strategies (10 points)

**Effective mitigation strategies to look for:**

1. **"If you're not sure, say so"** — Asking the AI to express uncertainty
2. **Breaking into smaller questions** — Instead of complex multi-part prompts
3. **Asking for sources first, then content** — Separating research from generation
4. **Explicit instructions to avoid fabrication** — "Only cite sources you are certain exist"
5. **Self-verification prompts** — "Now check your answer for accuracy"
6. **Constraining the domain** — Narrowing scope to reduce hallucination surface

**Grading:**
- 9-10: 3 creative strategies tested, honest about what worked and didn't
- 7-8: 3 strategies but analysis thin
- 5-6: 2 strategies or strategies were trivial
- <5: 1 or missing

## Part 4: Summary (5 points)

**Strong summaries include:**
- Specific hallucination rate (e.g., "4 out of 10 prompts produced errors")
- Most common category identified
- Practical recommendations grounded in their findings
- Appropriate confidence calibration (not "never trust AI" or "AI is always right")

## General TA Notes

- Verify at least 2 of the student's fact-checks yourself. If their "verification" is wrong, that's a teachable moment.
- Students who found genuinely interesting hallucinations should be encouraged to share (anonymized) with the class.
- Watch for students who clearly used AI to write their hallucination analysis. Irony aside, the analysis must be their own.
