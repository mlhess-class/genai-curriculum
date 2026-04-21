# MEMORANDUM

**TO:** Provost and Academic Council
**FROM:** Dr. Robert Ashworth, Dean, College of Engineering
**RE:** Final Comprehensive Review — Certificate in Generative AI Engineering
**DATE:** April 21, 2026

---

## 1. Executive Summary

**Recommendation: APPROVED — with noted conditions for Year 1 implementation**

Following my preliminary review (issued earlier this month, recommending conditional approval with seven required revisions), I have now completed a comprehensive final review of the full program package: the 15-credit curriculum spanning five courses (GENAI 101–490), sample homework assignments and answer keys for all five courses, the Course 4 final project specification, and the accompanying research paper situating this program within the broader landscape of generative AI education in higher education.

This is the strongest professionally-oriented AI certificate package I have reviewed at this institution. The materials demonstrate genuine pedagogical sophistication, authentic industry alignment, and a level of internal coherence—from introductory model comparison exercises through production multi-agent deployments—that is rare in newly proposed programs. I am moving from conditional approval to full approval, subject to implementation-phase conditions that I detail below. My reasoning: the materials as completed address the majority of my preliminary concerns with sufficient substance, and the remaining gaps are manageable through implementation governance rather than further pre-launch revision.

---

## 2. Review of Preliminary Concerns

In my initial review, I identified seven required changes and four strong recommendations. I address each below with my assessment of how the completed materials respond.

### 2.1 Programming Prerequisite or Bridge Course

**Preliminary concern:** Three weeks of Python in GENAI 301 is insufficient for students with zero programming experience.

**Assessment: PARTIALLY ADDRESSED.** The GENAI 301 syllabus does allocate three dedicated Python weeks (fundamentals I, II, III) covering variables through async and classes, and includes a standalone Python Proficiency Assessment worth 10% of the course grade—a gatekeeping mechanism that did not appear in my initial review of the course outline alone. The answer key for HW1 demonstrates that assignments after the Python onramp assume competent use of virtual environments, dotenv configuration, Pydantic models, and LCEL pipe syntax. This is a significant cognitive leap from Week 3 to Week 4.

The proficiency assessment is a welcome addition, but I maintain that three weeks remains aggressive for true novices. **Implementation condition:** The program must track pass rates on the Python Proficiency Assessment in the first two cohorts. If more than 25% of students score below 70%, a prerequisite Python course or an expanded 5-week bridge must be added before the third cohort.

### 2.2 GENAI 401 Scope

**Preliminary concern:** The course attempts to cover multi-agent systems, advanced RAG, evaluation, deployment, cost optimization, security, and observability in a single 3-credit course, with a final project of graduate-level ambition.

**Assessment: PARTIALLY ADDRESSED.** Having now reviewed the final project specification in full, my concern has intensified rather than diminished. The final project requires: a minimum of 3 specialized agents, an advanced RAG component, a fine-tuned model component (or justified exemption), Docker Compose deployment, input validation and prompt injection defense, output filtering, audit logging, rate limiting, health checks, monitoring dashboards, distributed tracing, load testing, a 50-case evaluation benchmark, an ablation study, a cost analysis, a 4–6 page design document, a 6–8 page evaluation report, and a 15-minute presentation. This is 250 points delivered over 5 weeks.

The project specification does allow teams of 2–3 and permits individuals to submit with reduced scope (2 agents minimum), which provides some relief valve. However, the sheer enumeration of requirements—security, observability, evaluation, fine-tuning, deployment, load testing—represents work that would be ambitious for a graduate capstone, let alone a component of a single course.

**Implementation condition:** Before the first offering of GENAI 401, the program director must either (a) remove at least two of: fine-tuning requirement, load testing, ablation study; or (b) formally propose a course split to the curriculum committee. I will accept either path, but the current specification cannot proceed as written.

### 2.3 API Cost Funding Model

**Preliminary concern:** Students should not bear unpredictable API costs.

**Assessment: NOT YET ADDRESSED in the curriculum documents.** The research paper accompanying the program acknowledges this issue explicitly—citing estimates of $50–$200 per student per semester and recommending that institutions "budget explicitly for API and infrastructure costs." This demonstrates awareness but not resolution. The curriculum itself remains silent on funding.

**Implementation condition:** A concrete API cost model must be established before enrollment opens. This should include institutional API accounts, per-student credit allocations, and a documented escalation path when credits are exhausted. I note that the research paper's cited figure of $150–$300 per semester for courses 301–490 (from my own preliminary review) appears to originate from my earlier estimate being circulated—this is not independent validation. The program must conduct its own cost modeling based on actual assignment requirements.

### 2.4 Framework-Agnostic Foundations

**Preliminary concern:** Courses 301 and 401 are deeply coupled to LangChain/LangGraph.

**Assessment: PARTIALLY ADDRESSED.** The GENAI 301 HW1 answer key demonstrates multi-provider integration (OpenAI, Anthropic, Ollama) which shows students are exposed to the abstraction layer LangChain provides across providers. The Course 4 HW1 allows "any framework (LangGraph, CrewAI, AutoGen, or custom)" for the multi-agent implementation—a meaningful concession to framework pluralism. However, the weekly syllabi for both courses remain fundamentally LangChain-centric in their instructional content.

The research paper's discussion of vendor lock-in (Section 6.2) is particularly relevant here. It acknowledges that "LangChain has undergone multiple breaking API changes" and that a "principles over tools" approach creates tension with student expectations for applicable skills. The paper's recommendation for "modular curriculum architectures that can accommodate rapid tool evolution" is sound advice that this program should follow more aggressively.

**Implementation condition:** GENAI 301 Week 4 (Introduction to LangChain) must include at least one session establishing the architectural concepts—chains, agents, retrieval, memory—independent of any framework before introducing LangChain as an implementation. The annual curriculum review (see 2.7) must evaluate whether LangChain remains the appropriate primary framework.

### 2.5 Mathematical Foundations for Embeddings and Retrieval

**Preliminary concern:** Students learn to call similarity_search() without understanding vector spaces or cosine similarity.

**Assessment: NOT ADDRESSED.** Neither the GENAI 301 syllabus nor its homework assignments include any mathematical treatment of embeddings, distance metrics, or vector space geometry. Week 11 ("Embeddings & Vector Databases") teaches embedding generation, ChromaDB storage, and similarity search as purely procedural operations. The answer key for Course 3 HW1 does not require students to explain *why* embeddings enable semantic search, only *how* to use them.

This remains a gap. Students who proceed to GENAI 401—where they must make architectural decisions about chunking strategies, hybrid search (sparse + dense), re-ranking, and graph RAG—will lack the conceptual foundation to reason about these choices. They will be pattern-matching from examples rather than reasoning from principles.

**Implementation condition:** Either GENAI 301 Week 11 or GENAI 401 Week 5 must include a dedicated 2-hour module on vector spaces, cosine similarity, and the geometry of embeddings. This need not be a full linear algebra course—a practical, visual, intuition-building session with worked examples will suffice. I will accept a supplementary reading assignment with an assessed quiz as a minimum.

### 2.6 Standardize Rubrics

**Preliminary concern:** Courses 1 and 2 use percentage-band descriptors while Courses 3 and 4 use point-based rubrics.

**Assessment: PARTIALLY ADDRESSED.** Reviewing the full homework set confirms the discrepancy. Course 1 HW1 uses a rubric with "Excellent (90–100%) / Good (80–89%) / Adequate (70–79%) / Needs Work (<70%)" without point allocations per criterion. Course 2 HW1 uses a point-based rubric (clear per-component allocations totaling 100). Courses 3 and 4 use point-based approaches with specific deduction guidelines in the answer keys (e.g., "-5 if not using LCEL pipe syntax," "-3 if PydanticOutputParser not used"). Course 5 HW1 uses point-based allocation with detailed grading notes.

The progression actually makes pedagogical sense: the introductory course uses holistic assessment appropriate for exploratory work, while technical courses use precise deductions appropriate for code evaluation. However, Course 1's rubric lacks the specificity needed for consistent TA grading across sections.

**Implementation condition:** Course 1 rubrics must include specific point allocations per criterion (not just percentage bands) before the first offering. The holistic descriptors may be retained as supplementary guidance.

### 2.7 Annual Curriculum Review

**Preliminary concern:** Standard 3–5 year review cycles are inadequate for this field.

**Assessment: ADDRESSED in principle.** The research paper's Section 6.4 ("Pace of Obsolescence") and Section 8 (Recommendations) make the case forcefully for adaptive curriculum governance. The paper recommends "modular curriculum architectures" and notes that "curricula developed in early 2024 may be substantially outdated by the time students complete a multi-course program in 2025."

**Implementation condition:** The program must establish a formal annual review process with the authority to update tool versions, swap frameworks, and revise up to 30% of course content without requiring full curriculum reapproval. This must be codified in the program governance charter before launch.

---

## 3. Assessment of Completed Materials

### 3.1 Homework Quality and Progression

The homework assignments represent the strongest element of this submission. The progression across five courses follows a clear Bloom's taxonomy escalation that the research paper's theoretical framework (Section 3.2) would endorse:

- **Course 1 HW1** (Model Comparison): Remember/Understand — Students observe, compare, and reflect. The answer key appropriately flags the meta-risk of "AI-generated analysis about AI" and instructs TAs to watch for it. Cognitive demand is appropriately low for an introductory course.

- **Course 2 HW1** (Workflow Thinking): Analyze/Evaluate — Students decompose a process, assess automation feasibility, and create an impact matrix. The 2×2 matrix and phased implementation plan require analytical judgment. The model answer (customer support ticket lifecycle) is well-chosen and the grading notes are specific.

- **Course 3 HW1** (LangChain Foundations): Apply/Create — Students write functional code with specific signatures, integrate multiple providers, implement streaming, and handle errors. The answer key provides concrete deduction schedules. This is where the course gets serious, and the jump from Course 2 is steep—confirming my concern about the programming onramp.

- **Course 4 HW1** (Multi-Agent System Design): Evaluate/Create — A 3-week assignment requiring architecture design, implementation with Docker deployment, and comparative evaluation against a baseline. The answer key's evaluation table (single-agent vs. multi-agent on completion, latency, tokens, quality) sets an excellent standard for evidence-based analysis.

- **Course 5 HW1** (Problem Statement & Stakeholder Analysis): Evaluate/Create — The most "professional" assignment, requiring stakeholder mapping, power/interest grids, success criteria, and ethical pre-assessment. The exemplar (clinical documentation assistant) is outstanding—detailed, domain-specific, and honest about constraints.

The gap between Course 2 and Course 3 remains my primary pedagogical concern. A student who excels at workflow thinking with emoji-labeled process maps will encounter, three weeks later, Pydantic models, LCEL pipe syntax, and async programming. The Python onramp must do extraordinary work to bridge this.

### 3.2 Answer Keys

The answer keys are uniformly strong—a detail that distinguishes this program from many proposals I review where answer keys are afterthoughts. Specific commendations:

- Course 1's answer key warns TAs about students submitting AI-generated analysis and provides specific detection heuristics.
- Course 3's answer key includes line-level deduction guidelines (e.g., "-2 if format_instructions not injected into prompt") that enable consistent grading across sections.
- Course 4's answer key provides a complete model implementation with async orchestration, structured message schemas, and a results table—this is reference architecture quality.
- Course 5's answer key includes a full exemplar at the level of quality expected, which is the most effective form of rubric.

### 3.3 Course 4 Final Project

I have addressed the scope concerns above (Section 2.2). Beyond scope, the project specification is well-designed:

- **Four project options** provide meaningful choice while constraining scope enough for consistent evaluation.
- **The requirement for structured inter-agent communication** (not raw string passing) reflects genuine production engineering sensibility.
- **The ablation study requirement** is pedagogically excellent—it forces students to justify each component's contribution rather than assembling complexity for its own sake.
- **The peer review component** (each student reviews another team's system) introduces code review culture.
- **Teams of 2–3 with individual contribution documentation** balances collaboration with accountability.

The fine-tuning requirement (LoRA/QLoRA) remains problematic. The syllabus includes no dedicated instruction on fine-tuning—it appears in no weekly topic. Requiring students to fine-tune a model without teaching them how is a curricular gap, not a stretch goal. The "justified argument for why base models suffice" escape clause partially mitigates this, but students should not be forced to argue their way out of a requirement that was never taught.

### 3.4 Research Paper

The accompanying research paper is a substantial scholarly contribution in its own right. Its mixed-methods design (847 faculty surveys, 62 administrator interviews, 134 student focus groups, 215 syllabi from 48 institutions) provides empirical grounding that most curriculum proposals lack entirely. Several elements are directly relevant to this program's design:

- **The TPACK adaptation** (Section 3.1) provides a theoretical foundation for the program's emphasis on contextual AI application rather than abstract AI theory.
- **The "full-stack GenAI courses" finding** (Section 4.1) validates the program's integrative approach, spanning conceptual foundations through production deployment.
- **The "demo gap" observation** from employer interviews (Section 5.5) directly justifies GENAI 401's emphasis on production concerns—and simultaneously cautions against superficial coverage of too many production topics.
- **The "confident incompetence" warning** from bootcamp analysis (Section 4.4) is a useful corrective: this program must ensure that its practical orientation produces genuine competence, not fluent tool usage masking conceptual gaps.
- **The equity analysis** (Sections 5.4, 6.3) reinforces the urgency of resolving the API cost funding model.

The paper's Bloom's taxonomy adaptation for AI-augmented learning (Section 3.2) provides a framework that the curriculum implicitly follows but should explicitly reference in its program-level documentation. The progression from "recall through retrieval" (Course 1) through "supervised delegation" (Courses 2–3) to "AI-informed judgment" and "augmented creation" (Courses 4–5) maps cleanly onto the paper's framework.

---

## 4. Comparison to the Broader Landscape

The research paper's survey of 215 syllabi across 48 institutions provides an invaluable benchmark. Against this landscape, the proposed Michigan certificate distinguishes itself in several ways:

1. **Depth of production engineering coverage.** The paper notes that most programs stop at prototype-level tool proficiency. This program's coverage of Docker deployment, CI/CD, monitoring, security hardening, and cost optimization in GENAI 401 addresses the "demo gap" that employers consistently identify.

2. **Scaffolded no-code to code progression.** The paper identifies a gap between programs that teach prompt engineering (accessible but shallow) and programs that teach AI engineering (deep but inaccessible). The 101→201→301 progression bridges this gap more gracefully than any program in the paper's sample.

3. **Ethics integration.** The paper finds that only 34 of 215 syllabi include dedicated ethics units, and most treat ethics superficially. This program threads ethical considerations from Course 1's responsible-use framework through Course 4's OWASP LLM Top 10 and Course 5's ethical pre-assessment requirement.

4. **Capstone design.** The paper's case studies describe capstones ranging from simple projects to elaborate but under-structured endeavors. GENAI 490's sprint-based structure with four formal reviews, professional skills seminars, and public Demo Day represents best practice.

The program's primary weakness relative to the landscape is its LangChain concentration. The paper documents that while LangChain appears in 9 of 18 certificate programs surveyed, the trend is toward framework-agnostic instruction. Michigan's program is more framework-coupled than the emerging norm.

---

## 5. Final Verdict and Implementation Conditions

**I approve this program for launch**, subject to the following conditions being met before the first cohort enrolls:

### Must-Complete Before Launch

1. **API cost model**: Documented institutional API accounts with per-student credit allocations and exhaustion procedures.
2. **GENAI 401 final project scope reduction**: Remove at least two of fine-tuning, load testing, or ablation study from the requirements; or propose a formal course split.
3. **Course 1 rubric revision**: Convert percentage-band rubrics to point-based with specific per-criterion allocations.
4. **Annual review charter**: Formal governance document authorizing annual curriculum updates of up to 30% without full reapproval.

### Must-Complete Before Second Cohort

5. **Embeddings/retrieval math module**: Add a practical module on vector spaces and cosine similarity to either GENAI 301 or 401.
6. **Framework-agnostic session in GENAI 301**: Establish architectural concepts before introducing LangChain implementation.
7. **Python onramp assessment**: Track pass rates on the Python Proficiency Assessment; implement remediation if failure exceeds 25%.

### Ongoing

8. **Annual curriculum review** with specific attention to framework currency, tool evolution, and emerging industry patterns.
9. **Student outcome tracking** including job placement, employer feedback, and longitudinal skill retention.

---

## 6. Closing Remarks

I stated in my preliminary review that "the University of Michigan should offer this certificate—but it should offer it right." Having now reviewed the complete package—every homework, every answer key, the final project, and a research paper that would stand on its own as a contribution to computing education literature—I am confident that this program, with the conditions above, will be offered right.

The curriculum designers have produced work of exceptional quality. The homework progression from guided model comparison to production multi-agent deployment is pedagogically sound. The answer keys demonstrate the kind of grading infrastructure that ensures consistent student experience across sections. The research paper provides both theoretical grounding and empirical context that most curriculum proposals never achieve.

My remaining concerns—the Python onramp, the 401 project scope, the API cost model, and the mathematical foundations gap—are real but bounded. They represent implementation challenges, not conceptual flaws. The program's architecture is sound. Its ambition is warranted by market demand and institutional mission. And its execution, as evidenced by the materials reviewed, reflects serious professional craftsmanship.

I look forward to reviewing enrollment data, student outcomes, and the first annual curriculum revision. This program has the potential to become a flagship offering for Michigan Engineering's commitment to accessible, rigorous, and professionally relevant technology education.

Respectfully submitted,

**Dr. Robert Ashworth**
Dean, College of Engineering
University of Michigan
