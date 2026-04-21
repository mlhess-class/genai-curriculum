# HW2 Answer Key: Prompt Engineering Lab

**For TA Use Only**

---

## Part 1: Basic Prompt Engineering (15 points)

**What to look for in the three prompt versions:**

**Vague prompt example:**
> "Tell me about climate change"

**Structured prompt example:**
> "You are a science educator. Explain the greenhouse effect to a high school sophomore in 200 words. Use one analogy. Avoid jargon."

**Expert prompt example:**
> "You are a climate scientist writing for Scientific American's 'explainer' series. Write a 200-word explanation of the greenhouse effect aimed at educated non-scientists. Tone: authoritative but accessible. Use the 'car in the sun' analogy. Do NOT mention politics or policy. End with one surprising fact."

**Grading the comparison (5 pts within this section):**
- Students should note: vague → generic/long response; structured → focused/appropriate; expert → nuanced/specific
- Strong answers identify *which elements* of the prompt caused which changes in output
- **Common mistake:** Students make their "vague" and "structured" prompts too similar. The progression should be dramatic.

## Part 2: Advanced Techniques (20 points, 5 each)

### Exercise A — Chain-of-Thought (5 pts)
**Correct answer:** Maria bought 4 notebooks ($12) and 6 pens ($9) = $21 ✓, 6 > 4 ✓
- Without CoT: models may jump to answer or try incorrect combinations
- With CoT: should show systematic algebra or trial approach
- **Award full credit** if student correctly identifies the difference in approach, even if both outputs happen to be correct (models have improved)

### Exercise B — Few-Shot Learning (5 pts)
**Look for:**
- At least 2-3 well-constructed examples in the prompt
- Clear pattern that the AI must follow
- Evidence that the AI adopted the format
- **Common mistake:** Examples that are too different from each other, giving the AI no consistent pattern to learn

### Exercise C — System Prompts (5 pts)
- Persona should be specific (not just "be a doctor" but "be a pediatric oncologist with 20 years experience who explains things to worried parents")
- 3 questions should test different aspects of the persona
- Evaluation should note where persona was maintained vs. broke
- **Common mistake:** Students pick overly generic personas. Encourage specificity.

### Exercise D — Iterative Refinement (5 pts)
- Must show **at least 5 distinct iterations**
- Each iteration should change something specific and document why
- Clear improvement arc from version 1 to version 5
- **Red flag:** Iterations that don't meaningfully change the prompt (just word swaps). Each should have a strategic reason.
- **Strong submissions:** Include a brief note on what they changed and why before each new prompt

## Part 3: Prompt Patterns Cheat Sheet (10 points)

**Model patterns to expect (students should have 6+):**

1. **Role Assignment** — "You are a [role]..." — Use when expertise/tone matters
2. **Output Formatting** — "Respond in a table/list/JSON..." — Use when structure matters
3. **Chain-of-Thought** — "Think step by step..." — Use for math/logic/reasoning
4. **Few-Shot** — Provide examples before the request — Use for custom formats
5. **Constraint Setting** — "In exactly 100 words..." — Use when length/scope matters
6. **Negative Prompting** — "Do NOT include..." — Use to exclude unwanted content
7. **Audience Specification** — "Explain to a 5-year-old..." — Use to control complexity
8. **Iterative Refinement** — Multi-turn conversation to refine — Use for complex outputs

**Grading:**
- 9-10: 6+ patterns with clear examples and practical tips
- 7-8: 5 patterns or examples are generic
- 5-6: 3-4 patterns
- <5: Incomplete

## Part 4: Reflection (5 points)

- Best answers name a specific technique and give a concrete example of future use
- Thoughtful answer about when advanced prompting isn't worth it (e.g., simple factual lookups, casual conversation)
- **Common mistake:** Just summarizing what they learned instead of reflecting on it

## Common Mistakes to Watch For

1. Students copying AI-generated "analysis" of their own prompting exercise
2. Iterative refinement that's actually just 5 different prompts, not refinement of one
3. Cheat sheet that's clearly AI-generated (look for overly polished, generic patterns without personal examples)
4. Few-shot examples that don't actually establish a learnable pattern
