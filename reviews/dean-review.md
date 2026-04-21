# MEMORANDUM

**TO:** Provost and Academic Council
**FROM:** Dr. Robert Ashworth, Dean, College of Engineering
**RE:** Review of Proposed Certificate in Generative AI & Intelligent Automation
**DATE:** April 21, 2026

---

## 1. Executive Summary

**Recommendation: Conditional Approval — Revisions Required Before Launch**

I have conducted a thorough review of the proposed 15-credit Certificate in Generative AI & Intelligent Automation (GENAI 101–490), including all five course designs, sample homework assignments, and the capstone final project specification. The program demonstrates considerable ambition and thoughtful sequencing, moving students from zero AI experience to production-deployed multi-agent systems across five courses. The curriculum addresses genuine market demand and aligns with the University of Michigan's strategic commitment to technology leadership.

However, I have identified several substantive concerns that must be addressed before this program can receive full approval. These include significant vendor and framework lock-in risks, an aggressive pace that may underserve students without prior programming experience, insufficient mathematical foundations, faculty hiring requirements that may prove challenging, and questions about long-term curricular durability in a field evolving at unprecedented speed. The program's strengths are real, but so are its gaps. I outline specific, actionable recommendations below and am confident that with targeted revisions, this certificate can become a flagship offering.

---

## 2. Program Strengths

**Scaffolded Progression.** The five-course sequence from conceptual literacy (101) through no-code automation (201) to code-based development (301), production architecture (401), and capstone integration (490) is pedagogically sound. The gradient from consumer-facing tools to API-level development to infrastructure concerns mirrors how practitioners actually mature in this field. This is the program's greatest structural asset.

**Practical Orientation.** Every course includes substantial lab time (2 hours/week minimum, 3 hours in the capstone), and assessments lean heavily toward building real artifacts—workflows, applications, deployed systems—rather than written examinations alone. The emphasis on portfolios and documentation (particularly in 490) prepares students for professional practice, not just academic credentialing.

**Ethics Integration Throughout.** Rather than confining ethics to a standalone module, the program threads responsible AI considerations from Week 10 of GENAI 101 through the security and governance components of GENAI 401. The inclusion of NIST AI RMF, OWASP LLM Top 10, EU AI Act coverage, and red-teaming exercises demonstrates awareness that technical competence without ethical grounding is insufficient.

**Contemporary Tool Selection.** The choice of n8n (open-source, self-hostable) over proprietary alternatives like Zapier shows good judgment. The inclusion of LangSmith for observability, RAGAS for evaluation, and LangGraph for stateful agent orchestration reflects current industry best practices rather than textbook abstractions.

**Capstone Design.** GENAI 490 is exceptionally well-structured. The sprint-based development cycle, stakeholder interview requirements, architecture decision records, and public Demo Day create authentic professional pressure. The seminar topics (technical writing, presentation skills, portfolio development) fill gaps that purely technical programs typically ignore.

---

## 3. Areas of Concern

**3.1 Framework and Vendor Lock-In.** The program is deeply coupled to the LangChain/LangGraph ecosystem. Two of five courses (301 and 401) are essentially LangChain courses. While LangChain is currently dominant, its API has undergone multiple breaking changes since 2023, and competitors (LlamaIndex, Haystack, Semantic Kernel, raw SDK approaches) are gaining traction. If LangChain's market position shifts—as happened with earlier frameworks—the curriculum would require near-total redesign of 40% of its content. The program needs a framework-agnostic conceptual layer beneath the LangChain-specific implementation.

**3.2 Python Onramp Insufficiency.** GENAI 301 allocates three weeks to Python fundamentals before launching into LangChain. For students entering with zero programming experience (which the prerequisites permit), this is aggressively optimistic. Covering variables through async programming and class design in three weeks, then immediately tackling LCEL's functional composition patterns, will likely produce a bimodal outcome: students with prior programming experience will thrive, while true beginners may founder. The prerequisite chain (101 → 201 → 301) does not include any programming requirement.

**3.3 Absence of Mathematical Foundations.** The program teaches students to use embeddings, vector databases, and similarity search without any treatment of the underlying linear algebra, probability, or information retrieval theory. Students will learn to call `ChromaDB.similarity_search()` without understanding cosine similarity, vector spaces, or why chunking strategies affect retrieval quality at a mathematical level. This limits their ability to debug, optimize, or make informed architectural decisions—precisely the skills GENAI 401 demands.

**3.4 Assessment Rigor Variation.** The homework assignments range widely in rigor. Course 1's HW1 (model comparison) is essentially a guided tour with screenshots—appropriate for an introductory course but low on cognitive demand. Course 4's HW1 (multi-agent system design with Docker deployment and evaluation) is a substantial engineering project. The jump between these levels is steep, and intermediate assignments must bridge this gap carefully. I did not see evidence of this bridging in the materials provided.

**3.5 API Cost Exposure.** Students will need active API keys for OpenAI, Anthropic, and Google throughout the program. Courses 301 and 401 involve extensive API usage (streaming, batch operations, multi-agent systems, evaluation pipelines running 50+ test cases). The program documentation does not address how API costs will be funded, whether institutional API accounts will be provided, or what happens when a student exhausts their credits mid-assignment. This is a practical barrier to access and equity.

**3.6 Pace and Workload.** GENAI 401 covers multi-agent systems, graph RAG, CRAG, self-RAG, RAGAS evaluation, Docker deployment, CI/CD, cost optimization, Prometheus/Grafana monitoring, security hardening, and circuit breakers—each of which could justify a full course—in 14 instructional weeks. The final project requires a production-deployed system with monitoring, security, load testing, and a 6–8 page evaluation report. This is graduate-level workload in what is positioned as an undergraduate certificate.

---

## 4. Course-by-Course Assessment

### GENAI 101: Foundations of Generative AI
**Strengths:** Excellent breadth of coverage; strong ethics integration; appropriate for true beginners. The prompt engineering portfolio (10 annotated prompt-response pairs) is a creative assessment. **Weaknesses:** Overreliance on commercial tool interfaces that change frequently; Week 7's multimodal coverage is thin for a rapidly expanding area. **Suggestion:** Add a week on AI-assisted coding (Copilot, Cursor) given its relevance to subsequent courses. Reduce the three-week ethics/governance block (Weeks 11–14) to two weeks and reallocate.

### GENAI 201: AI-Powered Workflows & Automation
**Strengths:** The process mapping and workflow thinking framework (Week 1) provides valuable systems design foundations. The homework assignment on workflow analysis is well-designed with clear rubrics. n8n is a defensible platform choice. **Weaknesses:** The course attempts to cover API fundamentals, database integration, document processing, and production deployment alongside n8n mastery—this is overloaded. Error handling appears only in Week 11, which is too late; students will have built fragile workflows for 9 weeks. **Suggestion:** Introduce error handling concepts by Week 5 and thread them throughout. Consider dropping one integration topic (e.g., OCR/document processing) to reduce breadth.

### GENAI 301: Building with LangChain
**Strengths:** The progression from Python basics through chains, agents, and RAG is logical. The inclusion of both ChromaDB and Pinecone (local vs. managed) is practical. The HW1 (LangChain Foundations) is well-structured with clear function signatures and expected outputs. **Weaknesses:** Three weeks of Python is insufficient for the target audience. The course title and content are entirely LangChain-branded, creating a marketing dependency on a single open-source project. Memory patterns taught (ConversationBufferMemory, etc.) are already deprecated in LangChain v0.3+. **Suggestion:** Rename to "Building AI Applications with Python" and teach LangChain as the primary (but not sole) framework. Add an explicit Python prerequisite or extend the Python introduction to 4–5 weeks by compressing the RAG section (which repeats in 401).

### GENAI 401: Advanced AI Systems & Architecture
**Strengths:** This is the program's most ambitious and potentially most valuable course. The coverage of evaluation frameworks, cost optimization, and security reflects genuine production concerns that most academic programs ignore. The final project is rigorous and professionally relevant. **Weaknesses:** Scope is unrealistic for a single 3-credit course. The final project alone (50+ test case evaluation, ablation study, load testing, threat model, 4–6 page design doc, 6–8 page evaluation report, presentation) represents 150+ hours of work. Fine-tuning (LoRA/QLoRA) appears in the final project requirements but receives no instructional coverage in the syllabus. **Suggestion:** Split into two courses: "Advanced RAG & Agent Architecture" (Weeks 1–7 content) and "AI Systems Operations" (Weeks 9–14 content). Alternatively, dramatically reduce the final project scope. Remove the fine-tuning requirement or add a dedicated week of instruction.

### GENAI 490: Capstone — AI Solution Design
**Strengths:** Best-in-class capstone design. The sprint structure with four formal reviews, the seminar series on professional skills, and the public Demo Day create an authentic product development experience. The assessment distribution (no single deliverable exceeds 25%) reduces catastrophic failure risk. **Weaknesses:** The "individually or in pairs" team size is limiting for students who should experience multi-person team dynamics. The portfolio requirement (10% of grade) may feel like busywork if students have already documented work in prior courses. **Suggestion:** Allow teams of up to three. Integrate the portfolio as a progressive artifact updated across all five courses rather than a capstone-only deliverable.

---

## 5. Pedagogical Review

**Homework Quality.** The sample assignments demonstrate a clear progression in complexity: GENAI 101 HW1 asks students to compare model outputs (application-level), GENAI 201 HW1 requires process analysis and automation design (analysis-level), GENAI 301 HW1 demands functional code with error handling and multi-provider integration (synthesis-level), and GENAI 401 HW1 requires architectural design, implementation, containerized deployment, and comparative evaluation (evaluation-level). This maps well to Bloom's taxonomy. However, the rubrics for Courses 1 and 2 are percentage-band descriptors ("Excellent 90–100%") without specific point allocations per criterion, while Courses 3 and 4 use point-based rubrics. Standardize rubric formats across the program.

**Exam Design.** All midterms are practical (build under time constraints), which is appropriate for a skills-oriented certificate. The absence of traditional written examinations is defensible but should be acknowledged in the program's accreditation documentation.

**Learning Objectives Alignment.** Objectives are generally well-aligned with assessments. One gap: GENAI 301 Objective 8 ("Debug, test, and iterate on LangChain applications using tracing, logging, and evaluation techniques") has no dedicated assessment—it is assumed to emerge through project work. Consider adding an explicit debugging exercise or lab assessment.

**Final Project (GENAI 401).** The project options are well-chosen and differentiated (research assistant, document intelligence, code review pipeline, customer support). The requirement for Docker Compose deployment, monitoring dashboards, load testing, and ablation studies is appropriate for a production-systems course. My concern, reiterated, is scope: this is a 5-week project carrying 250 points that would be ambitious as a master's thesis chapter.

---

## 6. Market & Strategic Fit

**Demand.** The market demand for generative AI skills is unambiguous. LinkedIn's 2025 Emerging Jobs Report lists "AI Engineer" and "Prompt Engineer" among the fastest-growing roles. Google Trends data for "LangChain," "RAG," and "AI automation" show sustained growth. A certificate positioned between non-technical AI literacy courses and full master's programs fills a genuine gap.

**Competition.** DeepLearning.AI, Coursera, and Udacity offer shorter-form AI certificates, but none provide the depth of production deployment and operations covered here. Stanford, CMU, and Georgia Tech offer graduate certificates that assume stronger prerequisites. Michigan's program occupies a distinctive niche: rigorous enough to be credible, accessible enough to serve career-changers and non-CS professionals.

**Mission Alignment.** The program supports Michigan Engineering's commitment to interdisciplinary technology education and workforce development. The no-prerequisites entry point (GENAI 101) and the practical orientation serve populations beyond traditional CS students—business professionals, educators, healthcare workers, and domain experts seeking to integrate AI into their fields.

**Risk.** The field's velocity is the primary strategic risk. Curricula designed today reference tools and patterns that may be obsolete in 18–24 months. The program must budget for annual curriculum review and revision cycles more aggressively than traditional engineering programs.

---

## 7. Resource Requirements

**Faculty.** The program requires at minimum two dedicated faculty members: one with strong software engineering and MLOps experience (for 301, 401, 490) and one with AI literacy, ethics, and workflow automation expertise (for 101, 201). Adjunct instructors with industry experience would strengthen the program but should not constitute the majority of teaching load. The current market for faculty with production AI systems experience is extremely competitive; the College should expect above-market compensation requirements.

**Teaching Assistants.** Courses 301 and 401 require hands-on debugging support that demands TAs with current LangChain/Python expertise—not general CS TAs. Budget for 2 TAs per section for these courses.

**Infrastructure.** Students need: (a) development machines capable of running Docker, local LLMs via Ollama, and vector databases; (b) institutional API accounts with sufficient credits for OpenAI, Anthropic, and Google APIs; (c) a self-hosted n8n instance for GENAI 201; (d) cloud deployment environments (AWS/GCP) for GENAI 401 and 490. Estimated per-student API and cloud cost: $150–300 per semester for courses 301–490. The College should negotiate educational pricing agreements with OpenAI and Anthropic.

**Software Licensing.** Most tools are open-source (n8n, LangChain, ChromaDB, FastAPI), which is commendable. Pinecone, LangSmith, and cloud providers have free tiers that may prove insufficient for class-scale usage. Budget for paid tiers.

**Physical Space.** Lab sessions require computer lab access with reliable internet. No specialized hardware (GPUs) is required for the curriculum as designed, since students consume cloud APIs rather than training models locally.

---

## 8. Recommendations

The following changes are **required before program approval:**

1. **Add a programming prerequisite or bridge course.** Either require introductory Python (or equivalent programming experience) before GENAI 301, or expand the Python component to 5 weeks and reduce 301 to a 4-credit course. Three weeks is inadequate for programming novices.

2. **Reduce GENAI 401 scope.** Either split into two courses or reduce the final project requirements by removing at least two of: fine-tuning requirement, load testing requirement, ablation study. Each is individually reasonable; collectively they exceed a 3-credit workload.

3. **Establish an API cost funding model.** Document how students will access required APIs. Provide institutional API keys or establish a lab fee structure. Do not leave students individually responsible for unpredictable API costs.

4. **Add framework-agnostic foundations.** In GENAI 301, dedicate at least one week to framework-agnostic concepts (what chains/agents/RAG are architecturally) before introducing LangChain-specific implementations. This future-proofs students' knowledge.

5. **Include mathematical foundations for embeddings and retrieval.** Add a module (in 301 or 401) covering vector spaces, cosine similarity, and basic information retrieval concepts. Students deploying RAG systems must understand *why* their chunking and embedding choices matter, not merely *how* to call the API.

6. **Standardize rubrics.** Adopt a consistent rubric format across all courses—preferably point-based with specific criteria rather than percentage bands.

7. **Establish annual curriculum review.** Commit to a formal annual review cycle with authority to update tool versions, swap frameworks, and revise course content without full reapproval. The field moves too fast for standard 3–5 year curriculum review cycles.

The following are **strongly recommended but not blocking:**

8. Rename GENAI 301 from "Building with LangChain" to a framework-neutral title.
9. Allow capstone teams of up to 3 students.
10. Move error handling earlier in GENAI 201 (by Week 5).
11. Create a progressive portfolio that spans all five courses rather than appearing only in 490.

---

## 9. Conclusion

This is an ambitious, well-conceived program that addresses genuine market demand with a practical, skills-oriented curriculum. The sequencing from AI literacy through automation, code-based development, production systems, and capstone integration is sound. The emphasis on building real artifacts, the integration of ethics throughout, and the professional-skills components of the capstone distinguish this from the proliferation of shallow AI certificates flooding the market.

The concerns I have raised—framework lock-in, insufficient programming onramp, overloaded 400-level scope, API cost equity, and absence of mathematical foundations—are substantive but addressable. None invalidates the program concept. They reflect the natural tension between ambition and feasibility that characterizes any worthwhile new academic venture.

I recommend **conditional approval** pending the seven required changes outlined in Section 8. I am prepared to work with the program faculty to refine these revisions and would welcome a follow-up review within 60 days. The University of Michigan should offer this certificate—but it should offer it *right*.

Respectfully submitted,

**Dr. Robert Ashworth**
Dean, College of Engineering
University of Michigan
