# HW5 Answer Key: Business Case & ROI Analysis

## GENAI 490 — Capstone: AI Solution Design

**Exemplar Project: AI-Powered Clinical Documentation Assistant**

---

## Grading Notes for Instructors

Numbers should be grounded in real pricing and reasonable assumptions. Evaluate whether assumptions are stated and sourced, not whether the ROI is impressive.

---

## Part 1: Executive Summary (10 pts)

US primary care physicians spend 50% of their workday on documentation, costing the healthcare system an estimated $200B annually in lost productivity. Our AI-Powered Clinical Documentation Assistant generates structured SOAP notes from patient encounter recordings, reducing documentation time by 60%.

**Pilot results:** 6 physicians over 4 weeks showed 60% documentation time reduction for routine encounters, with 95% clinical accuracy after physician review.

**Key financials:** At $8,430/month operating cost for a 20-physician clinic, the system saves $16,800/month in physician time recovery (1.5 hrs/day × $140/hr equivalent × 20 physicians × 4 weeks). **Projected ROI: 99% Year 1. Payback period: 7 months. 3-year NPV: $287,000.**

**Investment ask:** $150,000 for 6-month pilot (development completion, integration, and 3-month clinical pilot with 20 physicians at 2 sites).

**Top 3 risks:** (1) EHR integration delays extending timeline 2–3 months, (2) Physician adoption below 60% reducing ROI, (3) API cost increases eroding margins.

> **Grading notes:** Executive summary must fit on one page. Must include specific financial metrics, not just "significant ROI." Missing the investment ask = -3 pts.

## Part 2: Cost Analysis (25 pts)

**Assumptions documented:**
1. Pilot: 5 physicians, 50 encounters/day total, 3 months
2. Year 1 production: 20 physicians, 200 encounters/day, scaling to 50 physicians by Q4
3. Average encounter recording: 12 minutes → ~3,000 words transcript
4. GPT-4 Turbo: ~$0.03/1K input tokens, ~$0.06/1K output tokens (Azure pricing with BAA)
5. Average tokens per encounter: 4,000 input (transcript + guidelines + prompt), 1,500 output

**Cost breakdown:**

| Category | Pilot (Monthly) | Year 1 Avg (Monthly) | Year 2-3 (Monthly) |
|---|---|---|---|
| **AI/ML Costs** | | | |
| - GPT-4 API (note generation) | $800 | $3,200 | $5,400 |
| - Whisper API (transcription) | $150 | $600 | $1,000 |
| - Embedding generation | $20 | $50 | $80 |
| - Vector DB (ChromaDB → Pinecone) | $0 | $230 | $230 |
| **Infrastructure** | | | |
| - AWS hosting (ECS, S3, RDS) | $600 | $1,800 | $2,400 |
| - Monitoring/logging | $100 | $300 | $400 |
| **Development** | | | |
| - Engineering (2 FTE, loaded) | $40,000 | $20,000 | $10,000 |
| - Product/design (0.5 FTE) | $10,000 | $5,000 | $0 |
| **Operations** | | | |
| - Clinical validation/QA | $2,000 | $3,000 | $3,000 |
| - Support & maintenance | $0 | $2,000 | $3,000 |
| **Total** | **$53,670** | **$36,180** | **$25,510** |

**Phase totals:** Pilot (3 months): $161,010 | Year 1: $434,160 | Year 2: $306,120 | Year 3: $306,120

> **Grading notes:** Must include AI-specific costs (API tokens, embeddings, vector DB). Development costs are often the biggest item — students who only list cloud costs are missing 80% of the picture. Real API pricing should be cited.

## Part 3: Benefit Quantification (25 pts)

**Direct cost savings:**
- Medical scribe replacement: Clinics using scribes spend $36,000–48,000/year per physician. For 20 physicians: **$720K–$960K/year potential savings** (not all clinics use scribes; estimate 40% do → **$288K–$384K/year**)
- Assumption source: MGMA scribe salary data 2024

**Productivity gains (primary benefit):**
- Current documentation time: 90 min/day per physician
- Projected savings: 54 min/day (60% reduction; conservative vs. 70% target)
- Physician hourly value: $140/hr (loaded, based on MGMA compensation data)
- 20 physicians × 54 min/day × $140/hr × 250 workdays = **$630,000/year in recovered physician time**
- Source: User testing data (HW4) showing 60% time reduction

**Revenue impact:**
- Recovered time allows 1–2 additional patient encounters/day per physician
- Average reimbursement per encounter: $150
- Conservative estimate (1 additional/day × 15 of 20 physicians × 250 days) = **$562,500/year additional revenue**
- Caveat: Assumes demand exists and physicians use recovered time for patients

**Qualitative benefits:**
- Physician burnout reduction (cannot reliably dollarize, but physician turnover costs $500K–$1M per departure)
- Improved documentation quality and completeness
- Faster note availability for care coordination
- Competitive advantage in physician recruitment

> **Grading notes:** "Show your math" means literal arithmetic. Each number needs a source or stated assumption. Students who claim $10M in benefits without showing the calculation get ≤12/25. Qualitative benefits should be acknowledged but not forced into dollar values.

## Part 4: Financial Projections (20 pts)

**3-year summary:**

| Metric | Year 1 | Year 2 | Year 3 |
|---|---|---|---|
| Total costs | $434,160 | $306,120 | $306,120 |
| Productivity savings | $630,000 | $945,000 | $1,260,000 |
| Scribe cost savings | $336,000 | $504,000 | $672,000 |
| Additional revenue | $281,250 | $562,500 | $562,500 |
| **Net benefit** | **$813,090** | **$1,705,380** | **$2,188,380** |

(Year 1 benefits prorated to 6 months post-pilot; Year 2 scales to 30 physicians; Year 3 to 40)

**Key metrics:**
- **ROI (Year 1):** 187% ($813K net / $434K cost)
- **NPV (3-year, 10% discount):** $3,743,000
- **Payback period:** 7 months (including pilot)
- **Break-even:** Month 5 of production (Month 8 overall)

**Sensitivity analysis:**

| Scenario | Change | Impact on Year 1 ROI |
|---|---|---|
| API costs +50% | +$24,000/year | ROI drops to 181% (minimal impact) |
| Adoption 30% lower | 14 physicians instead of 20 | ROI drops to 119% (still positive) |
| Accuracy 20% worse → more review time | Time savings drop to 40% | ROI drops to 89% (marginal) |
| All three combined | Worst case | ROI drops to 42% (still positive but risky) |

> **Grading notes:** Sensitivity analysis is where strong submissions separate from weak ones. Students who only present the optimistic case earn ≤12/20. The combined worst case is important.

## Part 5: Implementation Roadmap & Risk (20 pts)

**Phased rollout:**

| Phase | Duration | Scope | Gate Criteria |
|---|---|---|---|
| Pilot | 3 months | 5 physicians, 1 site | ≥50% time reduction; ≥90% accuracy; no safety incidents |
| Limited GA | 3 months | 20 physicians, 2 sites | ≥60% time reduction; ≥95% accuracy; physician NPS ≥ 30 |
| Full GA | Ongoing | 50+ physicians, enterprise | Sustained metrics; EHR integration complete; SOC 2 achieved |

**Risk-adjusted scenarios:**

| Scenario | Probability | 3-Year NPV |
|---|---|---|
| Optimistic (fast adoption, low costs) | 20% | $5,100,000 |
| Base case | 50% | $3,743,000 |
| Pessimistic (slow adoption, high costs) | 25% | $980,000 |
| Failure (project abandoned) | 5% | -$161,000 |
| **Probability-weighted NPV** | | **$3,048,000** |

**Go/No-Go criteria at each gate:**
- Pilot → Limited GA: Time savings ≥50%; accuracy ≥90%; zero patient safety events; physician satisfaction ≥3.5/5
- Limited GA → Full GA: Time savings ≥55%; accuracy ≥95%; EHR integration functional; total cost within 120% of budget; physician NPS ≥30

> **Grading notes:** Phased rollout with explicit gate criteria is essential. "We'll roll it out and see" earns ≤10/20. Go/No-Go criteria must be specific and measurable, directly tied to the success criteria from HW1.
