# Final Project Rubric

**GENAI 201: AI-Powered Workflows & Automation**
**Total: 200 points**

---

## 1. Problem & Design (30 pts)

| Criterion | Excellent (full) | Adequate (70%) | Insufficient (<50%) |
|---|---|---|---|
| **Problem Statement (10 pts)** | Clear, specific real-world problem with measurable impact | Reasonable problem but vague on specifics | Trivial or unclear problem |
| **Architecture Design (10 pts)** | Clean diagram showing all nodes, data flow, and decision points; logical separation of concerns | Diagram present but missing details or unclear flow | No diagram or disorganized design |
| **Scope & Ambition (10 pts)** | Goes beyond minimum requirements; creative approach | Meets minimum requirements | Below minimum (fewer than 10 nodes, missing required components) |

## 2. Technical Implementation (70 pts)

| Criterion | Excellent (full) | Adequate (70%) | Insufficient (<50%) |
|---|---|---|---|
| **Workflow Structure (15 pts)** | 10+ well-organized nodes with clear naming and logical flow; clean canvas layout | Meets minimum node count; mostly logical but some messy connections | Fewer than 10 nodes or disorganized flow |
| **AI Integration (20 pts)** | 2+ AI calls with excellent prompts (role, format, dynamic vars, constraints); multi-step AI reasoning; prompt iterations documented | 2 AI calls with functional prompts; basic dynamic variables | Fewer than 2 AI calls or hardcoded/poor prompts |
| **External API Integration (10 pts)** | Clean API integration with proper auth, data mapping, and response handling | API works but minimal error handling or awkward data mapping | No external API or non-functional integration |
| **Error Handling (15 pts)** | Error branches, input validation, retry with backoff, graceful degradation; failures don't crash the system | Basic error handling on 1-2 nodes; some validation | No error handling; failures crash the workflow |
| **Advanced Pattern (10 pts)** | Effective use of sub-workflow, batch processing, or parallel execution that genuinely improves the system | Pattern present but adds minimal value or is trivially implemented | No advanced pattern used |

## 3. Testing & Reliability (30 pts)

| Criterion | Excellent (full) | Adequate (70%) | Insufficient (<50%) |
|---|---|---|---|
| **End-to-End Testing (10 pts)** | 5+ successful executions with varied inputs; edge cases tested; results documented | 5 executions but similar inputs; minimal edge case testing | Fewer than 5 executions or no documentation |
| **Failure Testing (10 pts)** | Deliberately triggered failures with documented recovery; tested API timeouts, invalid AI responses, bad input | Some failure testing but not comprehensive | No failure testing |
| **Performance Data (10 pts)** | Execution times measured per node; bottlenecks identified; optimization attempted | Total execution time reported but no per-node analysis | No performance data |

## 4. Documentation (40 pts)

| Criterion | Excellent (full) | Adequate (70%) | Insufficient (<50%) |
|---|---|---|---|
| **Completeness (10 pts)** | All required sections present; 2000–3000 words; well-organized | Most sections present; meets minimum length | Major sections missing or under 1500 words |
| **Node Walkthrough (10 pts)** | Every node explained with config details, data transformation, and reasoning | Most nodes covered but some lack detail | Superficial or missing walkthrough |
| **Prompt Engineering (10 pts)** | 3+ prompt iterations documented with rationale and output comparison; final prompt is production-quality | Some prompt discussion but limited iteration | No prompt engineering documentation |
| **Cost Analysis (5 pts)** | Per-execution and monthly projections with token breakdown; optimization discussed | Basic cost estimate present | No cost analysis |
| **Limitations & Future Work (5 pts)** | Honest assessment of limitations; specific, actionable improvement ideas | Brief mention of limitations | No limitations discussed |

## 5. Demo (30 pts)

| Criterion | Excellent (full) | Adequate (70%) | Insufficient (<50%) |
|---|---|---|---|
| **Presentation Quality (10 pts)** | Clear, well-paced walkthrough; confident explanation of design decisions | Adequate walkthrough but rushed or unclear in places | Disorganized or missing demo |
| **Live Execution (10 pts)** | Successful live trigger with real-time narration of data flow | Live execution shown but minimal explanation | No live execution or pre-recorded only with no explanation |
| **Failure Demo (10 pts)** | Triggered a failure live, showed error handling in action, explained recovery | Discussed failure handling but didn't demo it live | No failure scenario covered |

---

## Grade Boundaries

| Grade | Points | Description |
|---|---|---|
| A | 180–200 | Exceptional — production-quality system with polished documentation |
| B | 150–179 | Strong — all requirements met, good quality throughout |
| C | 120–149 | Adequate — meets most requirements, some areas underdeveloped |
| D | 100–119 | Below expectations — multiple requirements partially met |
| F | <100 | Insufficient — major requirements missing |

## Late Submission

- Proposal (Week 12): No penalty if submitted by Week 13; -10 pts after
- Final (Week 14): -10 pts per day late, maximum 3 days; not accepted after 3 days without prior arrangement

## Resubmission

Students scoring below 120 may resubmit once within 1 week of receiving their grade for a maximum score of 150.
