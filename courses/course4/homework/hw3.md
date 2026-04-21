# Homework 3: Fine-Tuning with LoRA/QLoRA

**GENAI 401 — Advanced AI Systems & Architecture**
**Assigned:** Week 6 | **Due:** Week 9 | **Points:** 100

## Overview

Fine-tune a foundation model for a domain-specific task using parameter-efficient methods. Compare LoRA and QLoRA approaches and analyze the quality/cost/speed tradeoffs.

## Requirements

### Part A: Data Preparation (20 pts)

1. Curate a domain-specific dataset of at least 2,000 high-quality instruction-response pairs
2. Implement data quality filters (deduplication, length filtering, toxicity screening)
3. Create train/val/test splits (80/10/10) with stratification
4. Document your data pipeline and quality criteria

### Part B: Fine-Tuning (40 pts)

1. Fine-tune a 7B+ parameter model using **both** LoRA and QLoRA
2. Experiment with at least 3 LoRA configurations:
   - Different rank values (r = 8, 16, 64)
   - Different target modules
   - Different alpha values
3. Track experiments with W&B or MLflow (include screenshots)
4. Training must be reproducible (provide configs, seeds, exact commands)

### Part C: Evaluation & Analysis (40 pts)

1. Evaluate all variants on your test set + at least one public benchmark
2. Report: task-specific metrics, perplexity, inference latency, GPU memory usage
3. Compare LoRA vs QLoRA:
   - Quality degradation from quantization
   - Memory savings
   - Training time differences
4. Compare against base model and GPT-4 (zero-shot) on same tasks
5. Analyze failure modes — where does fine-tuning help most/least?

## Rubric

| Criteria | Excellent (90-100%) | Good (70-89%) | Needs Work (<70%) |
|----------|-------------------|---------------|-------------------|
| Data | High-quality, well-documented pipeline | Adequate dataset | Small or poorly curated |
| Training | Multiple configs, tracked, reproducible | Basic fine-tune works | Incomplete or not reproducible |
| Evaluation | Comprehensive comparison with insights | Basic metrics reported | Missing key comparisons |
| Analysis | Deep understanding of tradeoffs | Surface-level analysis | Minimal analysis |

## Submission

- GitHub repo with training scripts and configs
- W&B/MLflow project link
- Report (PDF, max 8 pages) with all metrics and analysis
- Model weights uploaded to HuggingFace Hub (private repo, share with instructor)
