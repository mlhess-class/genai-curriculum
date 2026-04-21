# Homework 5: Business Case & ROI Analysis

## GENAI 490 — Capstone: AI Solution Design

**Milestone Deliverable 5 of 6** | **Due: Week 12** | **100 Points**

---

## Overview

Build the business case for deploying your AI solution. This is the document that would convince a CFO, VP, or investor to fund your project. Ground every claim in data from your prototype and user testing.

## Learning Objectives

1. Construct a compelling business case for a generative AI solution
2. Calculate total cost of ownership including AI-specific costs (API, compute, data)
3. Quantify ROI with realistic assumptions and sensitivity analysis
4. Assess go-to-market and organizational readiness
5. Present risk-adjusted financial projections

## Instructions

### Part 1: Executive Summary (10 pts)

One page maximum:

- The problem and who it affects
- Your solution (one paragraph)
- Key financial metrics (projected ROI, payback period, NPV)
- Investment ask and timeline
- Top 3 risks

### Part 2: Cost Analysis (25 pts)

Build a **detailed cost model** covering:

1. **Development costs** — Engineering time, design, project management
2. **AI/ML costs** — API usage (per-token or per-call pricing), fine-tuning compute, embedding generation, vector DB hosting
3. **Infrastructure costs** — Cloud hosting, storage, networking, monitoring
4. **Operational costs** — Maintenance, human-in-the-loop review, content moderation, model updates
5. **Organizational costs** — Training, change management, support

Present costs for:
- **Pilot phase** (3 months, limited users)
- **Year 1 production** (full rollout)
- **Year 2–3 steady state**

Include a **cost breakdown table** with monthly and annual totals.

### Part 3: Benefit Quantification (25 pts)

Quantify benefits with evidence:

- **Direct cost savings** — What current spending does this replace? (Use real numbers or justified estimates)
- **Productivity gains** — Time saved × hourly cost × number of users (cite your user testing data)
- **Revenue impact** — New revenue enabled or revenue protected
- **Qualitative benefits** — Employee satisfaction, customer experience, competitive advantage (don't try to dollarize everything)

Show your math. Every number needs an assumption, and every assumption needs a source or justification.

### Part 4: Financial Projections (20 pts)

Create:

1. **3-year cash flow projection** — Costs vs. benefits by quarter
2. **Key metrics:**
   - ROI (%)
   - Net Present Value (NPV) at 10% discount rate
   - Payback period
   - Break-even point
3. **Sensitivity analysis** — How do results change if:
   - API costs increase 50%?
   - Adoption is 30% lower than projected?
   - Model accuracy is 20% worse, requiring more human review?

### Part 5: Implementation Roadmap & Risk (20 pts)

- **Phased rollout plan** — Pilot → Limited GA → Full GA with decision gates
- **Organizational readiness assessment** — Skills gaps, change management needs, stakeholder buy-in status
- **Risk-adjusted projections** — Apply probability-weighted scenarios (optimistic, base, pessimistic)
- **Go/No-Go criteria** — What metrics at each gate determine whether to proceed?

## Submission Requirements

- **Format:** PDF or Markdown, 8–12 pages
- **Financial model:** Include spreadsheet (Google Sheets or Excel) as appendix or link
- **All assumptions documented** in a numbered list for traceability

## Rubric (100 Points)

| Criterion | Excellent (90-100%) | Proficient (70-89%) | Developing (50-69%) | Insufficient (<50%) |
|---|---|---|---|---|
| **Executive Summary (10)** | Compelling, concise, hits all key points | Covers basics; lacks punch | Incomplete or too long | Missing |
| **Cost Analysis (25)** | Detailed, realistic costs across all categories and phases | Most categories covered; some gaps | Incomplete or unrealistic estimates | Missing or wildly inaccurate |
| **Benefit Quantification (25)** | Evidence-backed; math shown; assumptions sourced | Benefits quantified; some assumptions weak | Vague or unsubstantiated claims | Missing or pure speculation |
| **Financial Projections (20)** | Complete 3-year model with sensitivity analysis | Projections present; limited sensitivity | Incomplete projections | Missing or nonsensical |
| **Roadmap & Risk (20)** | Phased plan with clear gates; realistic risk assessment | Plan present; risk acknowledged | Vague plan; superficial risk | Missing or unrealistic |
