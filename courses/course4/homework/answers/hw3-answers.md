# HW3 Model Answers: Fine-Tuning with LoRA/QLoRA

## Part A: Data Preparation

### Dataset: Medical Question Answering (2,500 pairs)

**Sources:** Curated from PubMedQA, medical textbooks, clinician-verified Q&A forums

**Quality Pipeline:**
1. **Deduplication:** MinHash LSH (Jaccard threshold 0.85) — removed 312 near-duplicates
2. **Length filter:** Min 50 tokens response, max 1024 — removed 89 too-short responses
3. **Toxicity screening:** Perspective API — flagged 7 entries for review
4. **Format validation:** Ensure instruction-response structure, remove malformed pairs
5. **Expert review:** Random 10% sample validated by domain expert (95% quality pass rate)

**Final splits:** Train: 2,000 | Val: 250 | Test: 250 (stratified by question category)

**Format:**
```json
{
  "instruction": "Explain the mechanism of action of metformin.",
  "input": "",
  "output": "Metformin works primarily by reducing hepatic glucose production..."
}
```

## Part B: Fine-Tuning

### Base Model: Llama-2-7B-chat

### LoRA Configurations Tested

| Config | Rank (r) | Alpha | Target Modules | Trainable Params |
|--------|----------|-------|----------------|-----------------|
| A | 8 | 16 | q_proj, v_proj | 4.2M (0.06%) |
| B | 16 | 32 | q_proj, v_proj | 8.4M (0.12%) |
| C | 64 | 128 | q_proj, k_proj, v_proj, o_proj | 67.1M (0.97%) |

### QLoRA Configuration
- 4-bit NormalFloat quantization
- Double quantization enabled
- Rank 16, alpha 32 (matching Config B for comparison)
- Paged AdamW 8-bit optimizer

### Training Details
```yaml
learning_rate: 2e-4
batch_size: 4
gradient_accumulation_steps: 8  # effective batch = 32
epochs: 3
warmup_ratio: 0.03
lr_scheduler: cosine
max_seq_length: 1024
seed: 42
```

### GPU Memory Usage

| Method | Peak VRAM | Training Time (3 epochs) |
|--------|-----------|-------------------------|
| LoRA (r=8) | 16.2 GB | 45 min |
| LoRA (r=16) | 17.1 GB | 52 min |
| LoRA (r=64) | 21.3 GB | 78 min |
| QLoRA (r=16) | 9.8 GB | 68 min |

## Part C: Evaluation

### Task-Specific Results (Medical QA — Test Set)

| Model | Accuracy | F1 | ROUGE-L | Perplexity |
|-------|----------|-----|---------|-----------|
| Base Llama-2-7B | 41.2% | 0.38 | 0.31 | 8.7 |
| LoRA r=8 | 62.8% | 0.59 | 0.52 | 4.2 |
| LoRA r=16 | 67.4% | 0.64 | 0.57 | 3.8 |
| LoRA r=64 | 68.1% | 0.65 | 0.58 | 3.7 |
| QLoRA r=16 | 65.9% | 0.62 | 0.55 | 4.0 |
| GPT-4 (zero-shot) | 72.3% | 0.69 | 0.62 | — |

### Key Findings

1. **Rank diminishing returns:** r=16 → r=64 gives only +1% accuracy for 4x parameters and 50% longer training. r=16 is the sweet spot.
2. **QLoRA quality gap:** ~1.5% accuracy drop vs LoRA at same rank, but 43% less VRAM — excellent tradeoff for limited GPU budget.
3. **vs GPT-4:** Fine-tuned 7B closes the gap significantly (67.4% vs 72.3%) at ~100x lower inference cost.
4. **Failure modes:** Fine-tuned models struggle with rare conditions (long-tail distribution) and multi-step reasoning chains. They excel at pattern-matching common presentations.
5. **Overfitting signal:** LoRA r=64 showed val loss increase after epoch 2.5 — early stopping recommended.
