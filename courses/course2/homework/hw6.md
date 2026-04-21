# Homework 6: Advanced Patterns

**GENAI 201: AI-Powered Workflows & Automation**
**Due:** End of Week 12 | **Points:** 100

## Learning Objectives

- Break complex workflows into reusable sub-workflows
- Implement loops for batch processing
- Use parallel execution to improve throughput
- Apply advanced n8n patterns for production-grade automation

## Prerequisites

- Completed HW3–HW5
- Comfortable with n8n node configuration and data flow

## Instructions

### Part A: Sub-Workflows (30 pts)

1. **Extract a Sub-Workflow** (15 pts) — Take a repeated or complex section from a previous homework workflow and extract it into a standalone sub-workflow:
   - The sub-workflow must accept input parameters
   - It must return structured output
   - Call it from a parent workflow using the Execute Sub-Workflow node
   - Screenshot both workflows and the data passing between them

2. **Reuse Demo** (10 pts) — Call the same sub-workflow from two different parent workflows (or two different points in the same workflow). Show that it works identically in both contexts.

3. **Documentation** (5 pts) — Write a brief spec for your sub-workflow: purpose, inputs (name + type + required?), outputs, error behavior.

### Part B: Loops & Batch Processing (30 pts)

1. **Item-by-Item Loop** (10 pts) — Build a workflow that:
   - Receives a list of items (at least 10)
   - Processes each item through an AI or API call
   - Collects all results
   - Handles individual item failures without stopping the batch
   - Show execution with timing for the full batch

2. **Batch Splitting** (10 pts) — Modify the above to process items in batches of 3:
   - Use the SplitInBatches node
   - Add a delay between batches (rate limiting protection)
   - Show execution logs demonstrating batch behavior

3. **Aggregation** (10 pts) — After batch processing, aggregate results:
   - Count successes and failures
   - Compile a summary report
   - Output both individual results and the summary

### Part C: Parallel Execution (25 pts)

1. **Parallel Branches** (15 pts) — Build a workflow where a single trigger fans out to 3+ parallel paths:
   - Each path does something different with the same input (e.g., generate summary + extract keywords + classify sentiment)
   - All paths complete independently
   - A Merge node combines all results
   - Screenshot showing parallel execution paths

2. **Performance Comparison** (10 pts) — Compare:
   - Sequential: Process A → Process B → Process C
   - Parallel: Process A + B + C simultaneously
   - Document total execution time for each approach
   - Calculate the speedup factor

### Part D: Production Pattern (15 pts)

Combine all three patterns into a single workflow:

1. A parent workflow that orchestrates the process (5 pts)
2. At least one sub-workflow call (3 pts)
3. At least one loop/batch operation (3 pts)
4. At least one parallel fan-out (2 pts)
5. A final aggregation that produces a clean summary output (2 pts)

Provide: workflow screenshot, exported JSON, sample execution with real data.

## Submission

- Markdown/PDF with screenshots, timing data, and analysis
- All exported n8n workflow JSON files (parent + sub-workflows)
- Performance comparison data

## Rubric

| Component | Points |
|---|---|
| Sub-Workflows — extraction, reuse, documentation | 30 |
| Loops & Batching — item loop, batch split, aggregation | 30 |
| Parallel Execution — fan-out, merge, performance comparison | 25 |
| Production Pattern — combined workflow | 15 |
| **Total** | **100** |
