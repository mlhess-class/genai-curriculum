# HW3 Answer Key: AI-Assisted Writing & Code

**For TA Use Only**

---

## Part 1: AI-Assisted Writing (20 points)

### For all options, check:
- **Process log exists** (8 pts) — Every prompt and response must be documented. Deduct heavily if missing; this is the core of the assignment.
- **Final output quality** (6 pts) — Polished, coherent, appropriate for the format
- **Process reflection** (6 pts) — Must distinguish human vs. AI contribution specifically

### Option A — Research Summary
- Verify the cited article is real and published 2024+
- Summary should be accessible to general audience (not just abstract restatement)
- **Common mistake:** Students paste the abstract into AI and ask it to "rewrite." Look for evidence of actual engagement with the article content.

### Option B — Professional Document
- Must show 3+ revision rounds with distinct improvements each time
- Final document should sound like the student, not like generic AI output
- **Strong answers:** Student pushes back on AI suggestions, keeps personal voice

### Option C — Creative Piece
- Evidence of human creative direction (not just "write me a story about X")
- Student should contribute ideas, plot points, stylistic choices
- **Red flag:** A single prompt that produced the entire piece with no iteration

### Process Reflection Grading:
- 5-6 pts: Clear delineation of human vs. AI work, honest about the balance, insightful about the collaboration
- 3-4 pts: Some distinction made but vague
- 1-2 pts: Generic or doesn't address the specific questions
- 0 pts: Missing

## Part 2: AI-Assisted Code (20 points)

### Exercise A — Code Generation (12 pts)

**Temperature converter example (correct):**
```python
def fahrenheit_to_celsius(f):
    """Convert Fahrenheit to Celsius."""
    return (f - 32) * 5 / 9

def celsius_to_fahrenheit(c):
    """Convert Celsius to Fahrenheit."""
    return c * 9 / 5 + 32
```

- Code should be functional (4 pts)
- Line-by-line explanation should show understanding (4 pts)
- Explanation should be in student's own words, not just AI's explanation verbatim (4 pts)
- **Common mistake:** Students paste AI's explanation without verifying understanding. Look for personal phrasing.

### Exercise B — Code Debugging (8 pts)

**The 3 bugs in the provided code:**

1. **Missing colon** on line 1: `def calculate_average(numbers)` → `def calculate_average(numbers):`
2. **Variable name typo** on line 5: `len(number)` → `len(numbers)`
3. **Variable name typo** on line 6: `return averge` → `return average`

**Bonus issue (not required but award +1 if caught):** No handling for empty list (division by zero if `numbers` is empty).

**Corrected code:**
```python
def calculate_average(numbers):
    total = 0
    for num in numbers:
        total += num
    average = total / len(numbers)
    return average
```

**Grading:**
- 3 bugs identified: 4 pts
- Explanations in own words: 4 pts
- **Common mistake:** Students identify the bugs but explain them using AI's exact language. Push for own words.

## Part 3: Quality Evaluation (10 points)

**Strong evaluations include:**
- Specific examples from their own work (not hypothetical)
- Honest assessment of time saved (some students overstate efficiency)
- Recognition that AI is better at drafting than at judgment/verification
- Mention of the verification burden — AI saves writing time but adds checking time

**Grading:**
- 9-10: Specific, evidence-based, nuanced, addresses all 4 questions
- 7-8: Addresses all questions but some answers generic
- 5-6: 2-3 questions addressed or superficial
- <5: Missing or minimal

## Common Mistakes to Watch For

1. Process log that's suspiciously clean (probably reconstructed after the fact, not logged during)
2. Code explanations that are clearly AI-generated (technical language a non-programmer wouldn't use naturally)
3. Students who claim AI was "perfect" and needed no editing — lack of critical engagement
4. Writing samples with no human fingerprint — the point is collaboration, not delegation
