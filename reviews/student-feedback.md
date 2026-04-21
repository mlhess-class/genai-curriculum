# Student Feedback — GenAI Certificate Program

## Student 1: Sarah — CS Senior, Strong Programmer

**Overall Rating:** 3.2 / 5

I'll be honest: GENAI 101 was painful. Not because it was bad — the material is well-organized and Mollick's book is genuinely good — but because I spent 15 weeks on content I could have absorbed in a weekend. I've been using ChatGPT since it launched. I already know what tokens are, how transformers work at a conceptual level, and how to write a decent prompt. The Week 1 homework where we had to set up accounts on ChatGPT, Claude, and Gemini and take *screenshots* of the interfaces? I've had those accounts for two years. The comparative analysis was fine, I guess, but comparing three model outputs for "is this a palindrome" is not something I needed a semester to learn.

The prompt engineering portfolio (Weeks 4–5) was the one part of 101 that had some value. Being forced to systematically document prompt-response pairs with annotations made me more deliberate about my approach. But chain-of-thought and few-shot prompting aren't exactly cutting-edge material for anyone who's read the OpenAI docs.

GENAI 201 was more interesting than I expected. I went in thinking n8n would be a toy, but building real multi-step workflows with error handling and webhook triggers actually taught me systems thinking I hadn't fully developed. The email triage system in Week 7 was legitimately fun. That said, the pacing still felt slow — Weeks 1-3 could easily be compressed into one week for anyone comfortable with APIs.

GENAI 301 is where I came alive, but I was also frustrated. The first three weeks are a Python crash course. I've been writing Python since freshman year. I understand that Marcus and others need that ramp, but sitting through variables, data types, and `for` loops when I could be building agents felt like a waste of my tuition. I wish there were a placement test or an accelerated track — let people who already know Python skip to Week 4.

Once we got to LangChain proper, the course was strong. The LCEL material in Weeks 5-6 was well-structured, and building a RAG system in Weeks 12-13 was the highlight of my semester. The homework for Course 3 (LangChain Foundations) was appropriately challenging — setting up multi-provider comparison with fallback chains and streaming is real engineering work. I appreciated that it required proper project structure, `.env` management, and type hints. That's the standard I want from every assignment.

**My suggestions:**
- Add a placement exam for 101 and 301's Python section. Let experienced students skip or CLEP out.
- Offer an accelerated 2-course track (101+201 compressed into one semester) for students with technical backgrounds.
- The 101 midterm was a timed prompt engineering challenge — fine for beginners, but consider offering a harder version for advanced students.
- More LangGraph content. Week 2-4 of 401 felt rushed for how important multi-agent systems are.

I'd recommend this program to a non-technical friend in a heartbeat. For CS students, it needs a fast lane.

---

## Student 2: Marcus — MBA Student, No Coding Background

**Overall Rating:** 3.5 / 5

Let me start with what worked: GENAI 101 was exactly what I needed. Coming from a finance background with zero AI experience, the course met me where I was. The Week 2 lab on token counting was my first "aha" moment — suddenly I understood why my ChatGPT conversations were getting weird after a while. The ethics case study paper was probably the most valuable assignment for me personally, because it connected AI to the business governance questions I actually care about. The Mollick book is excellent and I've already recommended it to colleagues.

GENAI 201 was the sweet spot of this program. The n8n platform is genuinely powerful and I didn't need to write a single line of code. Building the email triage workflow in Week 7 made me feel like I had a superpower. The Workflow Thinking homework — mapping a real business process, identifying automation points, creating an impact matrix — that's exactly the kind of analysis I do in my MBA strategy courses, just applied to AI. I could immediately see how to bring this back to my job. The midterm practical (build a workflow from a requirements spec) was stressful but fair, and I was proud of what I built.

Then Course 3 hit me like a truck.

The syllabus says "prior programming experience is helpful but not required." That is, respectfully, misleading. Three weeks of Python fundamentals is not enough to go from zero to writing LangChain applications. In Week 1, I was still confused about why indentation matters in Python. By Week 4, I was expected to understand `ChatOpenAI`, `SystemMessage`, prompt templates, and output parsers — all simultaneously. The jump from "here's what a function is" to "implement a PydanticOutputParser" in the Course 3 HW1 was the steepest learning curve I've ever experienced.

Specific points of confusion in the HW1:
- **Type hints** (`def summarize_topic(topic: str, max_words: int = 100) -> str`): I didn't even know what `-> str` meant until I Googled it. This wasn't covered in the Python crash course.
- **Async/await** in the streaming section: Week 3 mentions "async intro" but the homework requires `async def` and `astream()`. I had no mental model for asynchronous programming.
- **Pydantic models**: The sentiment classifier requires a PydanticOutputParser. We hadn't covered Pydantic at all in the Python weeks.
- **Virtual environments and `.env` files**: The project structure assumes comfort with terminal commands, `pip`, and `python-dotenv`. I spent 3 hours just getting my environment working before writing any actual code.

I ended up relying heavily on ChatGPT to get through the assignments, which felt ironic and also like I wasn't actually learning.

**My suggestions:**
- Extend the Python ramp to 5-6 weeks, or offer a separate pre-requisite "Python for AI" mini-course.
- Create a "no-code capstone" track that goes deeper into n8n + Zapier + Make instead of pivoting to Python.
- Provide starter code for HW1 that actually runs, not just function signatures with `pass`. Let us fill in the logic, not debug import errors.
- Pair non-coders with CS students for lab sessions. I would have learned twice as fast with a coding buddy.
- The HW1 rubric deducts 5 points for no type hints and 10 points for not using LCEL patterns — these penalties are harsh for students who just learned what a variable is three weeks ago.

---

## Student 3: Priya — Working Professional, Data Analyst, Age 35

**Overall Rating:** 3.8 / 5

I enrolled in this program because my company is integrating AI into our analytics pipeline and I wanted to be the person leading that effort, not the person being replaced by it. I'm taking one course per semester while working full-time, so my feedback is heavily shaped by time constraints.

**GENAI 101** had great content but too much of it for a working professional. The 15-week schedule with weekly labs, a midterm, a portfolio, a 2,000-word ethics paper, AND a final project is a lot. I calculated roughly 8-10 hours per week between lectures, labs, readings, and assignments. The Mollick book is excellent and I'd have read it on my own. The weekly MIT Technology Review articles were hit-or-miss — some were directly relevant, others felt like padding.

The parts I found most valuable were the prompt engineering techniques (Weeks 4-5) and the hallucination/reliability module (Week 9). These are directly applicable to my job. I've already started using chain-of-thought prompting when I ask Claude to help me write SQL queries, and the hallucination detection framework from Week 9 has changed how I validate AI-generated analysis.

The parts I found least valuable were the theoretical/conceptual sections. Week 2 ("How LLMs Work") was interesting in an abstract sense, but spending two hours learning about attention mechanisms at a "conceptual level" didn't help me do my job better. Similarly, the IP/copyright module (Week 11) and the full-week governance module (Week 14) could have been condensed. I understand these matter, but as a working analyst, I need tools, not philosophy.

**GENAI 201** was the most immediately valuable course. I was building useful automations by Week 3. The document processing workflow in Week 12 is almost exactly what I need for my job — we process hundreds of PDF reports monthly and currently extract data manually. I actually pitched a version of my final project workflow to my manager and we're piloting it. That alone justified the tuition.

The Workflow Thinking homework for Course 2 was brilliantly designed. Mapping a real business process, estimating time for each step, then identifying automation opportunities — I used my own team's monthly reporting process and discovered we spend 12 hours on tasks that could be 80% automated. The reflection questions about what should NOT be automated were thought-provoking and prevented me from going full "automate everything" mode.

**GENAI 301** is where the workload became unsustainable. The Python crash course (Weeks 1-3) moved faster than I could keep up with while working 45-hour weeks. I know some Python from data analysis (pandas, basic scripting), but the jump to classes, async programming, and project structure in Week 3 was rough. The HW1 asking us to set up a full project with `pyproject.toml`, virtual environments, and multi-provider comparison with latency tracking felt like it was designed for full-time students.

**My suggestions:**
- Offer a "professional track" with extended deadlines or reduced assignment scope for working students.
- Cut the ethics paper from 2,000 words to 1,000. Or make it a discussion post. The learning happens in the thinking, not the word count.
- For 301, provide Docker containers or cloud environments pre-configured with all dependencies. I lost entire evenings fighting with Python versions and package conflicts.
- The most valuable assignments were the ones directly tied to real work scenarios. More of those, fewer academic exercises.
- Consider offering 101+201 as an 8-week intensive for professionals who just need the practical skills.

---

## Student 4: James — Community College Transfer, First-Gen College Student

**Overall Rating:** 2.8 / 5

I want to be upfront: I transferred in from community college, I'm the first person in my family to go to a four-year school, and I'm on financial aid. I'm sharing this because a lot of my feedback is about access and cost, and I think the program needs to hear it.

**GENAI 101** was mostly fine. The free tiers of ChatGPT, Claude, and Gemini covered most of what we needed for HW1, and the comparison assignment was a good introduction. But even here, I noticed disparities. Some classmates were using GPT-4 (paid) while I was on GPT-3.5 (free tier). When the prompt engineering portfolio required 10 prompt-response pairs with "diverse use cases including code generation, analysis, and creative writing," the free tiers sometimes throttled me or gave noticeably worse outputs. The rubric didn't account for model tier differences, so I was being graded on the same scale as someone with a $20/month subscription.

**GENAI 201** is where costs became a real problem. The course requires API keys for OpenAI, Anthropic, and Google. Even with free credits, I blew through them by Week 6. Building the AI-powered email processing workflow in Week 7 required dozens of API calls for testing, and each iteration costs money. By Week 10, I was spending about $15/month on API calls — that doesn't sound like much, but it's a meal budget decision for me. The n8n self-hosted option required Docker, which barely ran on my 2019 MacBook Air with 8GB RAM. My laptop fans sounded like a jet engine and the UI was laggy to the point of unusable during complex workflows.

**GENAI 301** was the breaking point. The HW1 requires three different API providers (OpenAI, Anthropic, Ollama). OpenAI and Anthropic cost money per call. Ollama requires running a local LLM, which needs at least 16GB RAM — my laptop has 8GB. So one-third of the assignment was physically impossible for me to complete on my hardware. I asked the professor about it and was told to "use the computer lab," but the lab closes at 9 PM and I work a part-time job until 8:30. The fallback chain assignment (`create_fallback_chain`) literally requires all three providers to be functional.

The streaming and batch operations sections also assumed you could make many API calls for testing and iteration. When every API call costs money, you don't experiment — you try to get it right the first time, which is a terrible way to learn programming.

**Specific equity issues I encountered:**
- API costs are never mentioned in the course catalog or fee schedule. I didn't budget for them.
- The "Required Tools" section lists VS Code (free, good), but also assumes access to a machine that can run Docker and local LLMs.
- Group project partners assumed everyone had GitHub Copilot ($10/month) for coding assignments. I didn't.
- The 401 course requires cloud deployment (AWS/GCP). Even with free tiers, I'll need a credit card, which I don't have.
- The Capstone requires deployment to Vercel/Railway/AWS. More hidden costs.

**What would help:**
- A program-level "technology fee" that covers API credits for all students, distributed equally. $50/semester would cover it and remove the disparity.
- Loaner laptops with 16GB+ RAM for students who need them, or guaranteed access to adequately provisioned computer labs with extended hours.
- Assignment alternatives for every exercise that requires paid APIs — let students use free-tier-only approaches, even if outputs are lower quality, without grading penalties.
- A clear cost disclosure document at enrollment: "expect to spend $X on API credits, $Y on subscriptions." I would have appreciated knowing this upfront.
- Make Ollama/local model assignments optional, or provide a shared server students can SSH into.

I believe in this program's mission. I want to work in AI. But right now, the program assumes a level of financial and hardware access that not all students have, and it's creating a two-tier experience.

---

## Student 5: Aisha — PhD Student in Linguistics, Interdisciplinary Interest

**Overall Rating:** 4.0 / 5

I'm a third-year PhD student in computational linguistics, and I enrolled in this certificate to strengthen the engineering side of my NLP research. My dissertation examines how large language models handle morphologically complex languages, so I came in with strong conceptual knowledge of transformers and attention mechanisms but limited production engineering experience. My feedback reflects that specific vantage point.

**GENAI 101** was a mixed experience. The conceptual content in Weeks 1-3 was review for me — I teach undergrads about transformers in my department. But the prompt engineering modules (Weeks 4-6) were surprisingly valuable from a research perspective. I'd been thinking about prompting as a practical shortcut, but the systematic treatment of few-shot prompting, chain-of-thought, and meta-prompting gave me a framework I'm now using in my dissertation experiments. The structured approach to evaluating outputs for bias (Week 10) was directly relevant to my work on multilingual model fairness.

What I wished for in 101 was more engagement with the *linguistic* dimensions of how LLMs work. The "How LLMs Work" module (Week 2) covers transformers at a conceptual level but doesn't engage with why these models struggle with certain linguistic phenomena — code-switching, agglutinative morphology, pragmatic inference. The bias module (Week 10) discusses demographic bias but not linguistic bias — the fact that these models perform dramatically worse on non-English languages, dialects, and non-standard registers. For a "Foundations" course, it's remarkably monolingual in its framing.

The ethics modules (Weeks 11-14) were actually my favorite part of 101, which I know puts me in the minority. The IP/copyright discussion connected directly to questions in my field about training data consent for indigenous and minority languages. The governance module touched on the EU AI Act but didn't engage with how AI regulation affects linguistic communities differently. I wrote my ethics case study on AI-generated content in endangered language documentation and got positive feedback, but I had to bring all the domain context myself — the course materials didn't cover this territory at all.

**GENAI 201** was outside my comfort zone in the best way. I'd never thought systematically about workflow automation, and building n8n pipelines taught me to think about my research infrastructure differently. I built my final project around a workflow that automatically processes new papers from ArXiv's cs.CL feed, extracts key findings, and adds them to my literature database. It's running right now and saves me 3-4 hours per week. The Workflow Thinking homework was excellent — the process mapping methodology is something I've since applied to my own research pipeline documentation.

**GENAI 301** was exactly what I needed. The RAG material (Weeks 11-13) is directly applicable to my research. I'm building a RAG system over a corpus of linguistic fieldwork notes, and the chunking strategies and retrieval patterns I learned are central to my approach. The multi-provider comparison in HW1 was interesting from a linguistics perspective — I noticed systematic differences in how OpenAI, Anthropic, and Ollama models handle the same prompts, which became a mini-research question for me.

**Where the program falls short for interdisciplinary students:**
- Every example, case study, and scenario is drawn from business contexts — email triage, customer support, invoice processing, content marketing. There's no engagement with research, humanities, social science, or creative applications.
- The "AI in the Workplace" module (101 Week 13) focuses entirely on corporate adoption. What about AI in academic research, digital humanities, or community-based language work?
- The RAG modules assume you're building a business Q&A system. I had to adapt every example to my linguistic corpus use case on my own.
- No readings from the computational linguistics or NLP research community. The reading list is entirely industry-focused (OpenAI docs, O'Reilly books, NIST frameworks).

**My suggestions:**
- Add at least 2-3 case studies from non-business domains: digital humanities, scientific research, creative arts, social science, public health.
- In the RAG modules, include examples with non-English corpora. The chunking strategies that work for English business documents don't necessarily work for morphologically complex languages or multilingual corpora.
- Include at least one reading from the ACL/EMNLP community in the 101 reading list. Even a survey paper would help students understand that there's a research dimension to this field beyond product engineering.
- The bias module should address linguistic bias, not just demographic bias. A model that works well in English but fails in Yoruba or Tagalog has a bias problem that the current curriculum doesn't name.
- Consider an elective track for students from humanities/social science backgrounds that emphasizes research applications over business applications. We're a growing audience for this material.

Despite these gaps, this is a well-designed program. The progression from concepts to no-code to code to production is pedagogically sound, and the hands-on emphasis is exactly right. I just wish it recognized that GenAI's impact extends far beyond the business world.
