# HW1 Answers: Workflow Thinking

**GENAI 201 — Model Answers & Grading Notes**

---

## Part A: Process Mapping (40 pts)

### Model Answer: Customer Support Ticket Lifecycle

**Process Overview (10 pts)**

> A customer submits a support request via email or web form. The support team triages the ticket, assigns it to the appropriate agent based on category, investigates the issue, communicates with the customer, and resolves or escalates. The process runs continuously with ~50 tickets/day. Stakeholders: customers, L1 support agents, L2 specialists, support manager.

**Grading notes:** Award full marks for clear identification of trigger, participants, frequency, and output. Deduct 3 pts if missing any of those four elements.

**Step-by-Step Map (20 pts)**

1. 👤 Customer submits ticket via web form
2. 🔄 Form data sent to ticketing system (Zendesk/Freshdesk)
3. ⏳ Ticket sits in queue awaiting triage (avg 45 min)
4. 👤 L1 agent reviews ticket and reads details
5. 🔀 Is it a known issue? → Yes: go to 6 / No: go to 8
6. 👤 Agent copies template response and personalizes it
7. 🔄 Response sent to customer via email → go to 11
8. 👤 Agent researches issue in knowledge base
9. 🔀 Can L1 resolve? → Yes: go to 10 / No: go to 12
10. 👤 Agent writes custom response → go to 11
11. ⏳ Wait for customer reply (avg 4 hours)
12. 🔄 Ticket escalated to L2 specialist
13. 👤 L2 investigates and responds
14. 👤 Agent marks ticket resolved and sends satisfaction survey

**Grading notes:** Must have ≥10 steps with correct emoji labels. Deduct 5 pts for fewer than 10 steps. Deduct 2 pts per missing label type (must use all four: 👤🔀⏳🔄).

**Time Estimates (10 pts)**

| Step | Time |
|---|---|
| 1–2 | 5 min |
| 3 | 45 min (wait) |
| 4 | 3 min |
| 5 | 1 min |
| 6–7 | 5 min |
| 8 | 10 min |
| 11 | 4 hours (wait) |
| 12–13 | 30 min |
| 14 | 2 min |
| **Total active** | ~56 min |
| **Total elapsed** | ~5.5 hours |

**Grading notes:** Must distinguish active time from wait/elapsed time. Accept reasonable estimates for any process.

## Part B: Automation Analysis (35 pts)

**Automation Points (15 pts)**

| Step | Automation | Type |
|---|---|---|
| 2 | Already automated (form → system) | Full |
| 3 | Auto-triage by keyword/category | Full |
| 5 | AI classification of known vs new issues | Full |
| 6 | Template auto-fill with customer context | Full |
| 7 | Auto-send for high-confidence matches | Human-in-loop |
| 8 | AI-powered knowledge base search | Partial |
| 12 | Auto-escalation rules | Full |
| 14 | Auto-close + survey trigger | Full |

**Grading notes:** At least 5 automation points identified. Each must specify tool/tech, full vs partial, and at least one risk.

**Impact Matrix (10 pts)**

|  | Low Effort | High Effort |
|---|---|---|
| **High Impact** | Auto-triage (step 3), Template auto-fill (step 6) | AI classification (step 5), AI KB search (step 8) |
| **Low Impact** | Auto-close + survey (step 14) | Custom AI responder (step 10) |

**Grading notes:** Must have items in at least 3 of 4 quadrants with justification.

**Implementation Sequence (10 pts)**

- Phase 1 (Week 1–2): Auto-triage and template auto-fill — quick wins, low risk
- Phase 2 (Week 3–6): AI classification and auto-escalation rules
- Phase 3 (Week 7–12): AI-powered responses with human review loop

**Grading notes:** Must start with low-effort/high-impact items. Logical progression required.

## Part C: Reflection (25 pts)

**Should not automate (10 pts):**
- Empathetic responses to frustrated customers — AI lacks genuine emotional intelligence
- Complex edge cases requiring creative problem-solving
- Escalation decisions involving business impact assessment

**Success metrics (10 pts):**
1. Average resolution time (target: reduce from 5.5h to 2h)
2. First-contact resolution rate (target: increase from 40% to 65%)
3. Customer satisfaction score (target: maintain ≥4.2/5)

**What could go wrong (5 pts):**
- Auto-responses sent for complex issues → customer frustration
- Over-reliance on templates → impersonal feel
- AI misclassification → wrong escalation path → delays

**Grading notes:** Award full reflection marks for specific, thoughtful answers. Deduct for vague generalities like "things could break."
