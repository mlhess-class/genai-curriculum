# GENAI 201: AI-Powered Workflows & Automation

## Course Information

| Field | Detail |
|---|---|
| **Course Number** | GENAI 201 |
| **Title** | AI-Powered Workflows & Automation |
| **Credits** | 3 |
| **Prerequisites** | GENAI 101 |
| **Format** | Lecture + Lab (2 hrs lecture, 2 hrs lab per week) |

## Course Description

Students learn to design and build automated workflows that integrate generative AI into business processes using n8n, a powerful open-source workflow automation platform. Beginning with workflow thinking and systems design, the course progresses through API fundamentals, data transformation, conditional logic, and error handling. Students connect AI models to real-world data sources including email, databases, spreadsheets, and web services to build end-to-end automated pipelines. No prior programming experience is required; the course emphasizes visual, no-code/low-code approaches while introducing foundational concepts that prepare students for code-based development in subsequent courses. Students complete multiple production-ready workflows addressing authentic business scenarios.

## Learning Objectives

Upon successful completion, students will be able to:

1. Decompose complex business processes into discrete, automatable workflow steps using systems thinking principles.
2. Build, test, and deploy multi-step automated workflows in n8n that integrate AI model APIs with external data sources.
3. Explain how REST APIs function—including authentication, HTTP methods, request/response formats, and rate limiting—and connect to third-party APIs within workflows.
4. Implement conditional logic, branching, looping, and error handling to create robust, fault-tolerant automations.
5. Transform and map data between different formats (JSON, CSV, XML) as it flows between workflow nodes.
6. Integrate OpenAI, Anthropic, and Google AI APIs into workflows for text generation, classification, summarization, and extraction tasks.
7. Apply security best practices including credential management, input validation, and access controls to workflow deployments.
8. Document workflows with clear specifications covering purpose, data flow, failure modes, and maintenance requirements.

## Week-by-Week Syllabus

| Week | Topic | Lab Activity |
|---|---|---|
| 1 | **Workflow Thinking** — Process mapping, input/output analysis, automation candidates, ROI estimation | Map a manual business process; identify automation opportunities |
| 2 | **Introduction to n8n** — Architecture, UI tour, nodes, connections, executions, self-hosted vs. cloud | Install n8n locally; build a "Hello World" workflow with manual trigger + HTTP request |
| 3 | **API Fundamentals** — REST concepts, HTTP methods, headers, authentication (API keys, OAuth), JSON basics | Use n8n HTTP Request node to call a public API; parse JSON responses |
| 4 | **Core n8n Nodes** — Set, If, Switch, Merge, Split In Batches, Code (expressions), Function nodes | Build a workflow that fetches data, filters it, and routes to different outputs |
| 5 | **Data Transformation** — JSON manipulation, field mapping, data type conversion, expressions, JMESPath | Transform messy API data into clean structured output; CSV ↔ JSON conversion |
| 6 | **Connecting AI Models** — OpenAI node, HTTP requests to Anthropic/Google, prompt templates, dynamic variables | Build a workflow that takes input text and sends it through 3 different AI models |
| 7 | **AI-Powered Email Processing** — Gmail/IMAP triggers, email parsing, AI classification, automated responses | Create an email triage system: classify incoming emails and draft responses |
| 8 | **Midterm Review & Exam** | Midterm practical: build a complete workflow from a requirements spec |
| 9 | **Database & Spreadsheet Integration** — Google Sheets, Airtable, PostgreSQL nodes, CRUD operations | Build an AI-powered data enrichment pipeline: spreadsheet → AI → database |
| 10 | **Webhooks & Event-Driven Workflows** — Webhook triggers, payload handling, response nodes, external integrations | Create a webhook-triggered workflow that processes form submissions with AI |
| 11 | **Error Handling & Reliability** — Try/Catch patterns, retry logic, error workflows, logging, monitoring | Add comprehensive error handling to a previous workflow; build alerting |
| 12 | **Document Processing Workflows** — PDF extraction, OCR, AI summarization, structured data extraction from documents | Build a document intake pipeline: upload → extract → AI analyze → store results |
| 13 | **Multi-Step AI Pipelines** — Chaining AI calls, context passing, output-as-input patterns, quality gates | Create a content pipeline: research → draft → review → refine → publish |
| 14 | **Deployment & Operations** — n8n in production, environment variables, credential management, versioning, backup | Deploy a workflow to a production n8n instance; set up monitoring |
| 15 | **Final Project Presentations** | Present and demonstrate final workflow projects; peer review |

## Required Readings & Resources

- n8n Documentation. docs.n8n.io (current version).
- Postman. "Introduction to APIs." postman.com/api-first (selected chapters).
- OpenAI. "API Reference." platform.openai.com/docs/api-reference.
- Hohpe, G. & Woolf, B. *Enterprise Integration Patterns* (selected chapters provided as PDF).
- Weekly tutorial videos and reference sheets provided on LMS.

## Assessment Breakdown

| Component | Weight | Description |
|---|---|---|
| Weekly Lab Workflows | 25% | Completed n8n workflows demonstrating each week's concepts |
| Midterm Practical | 15% | Timed build of a workflow from requirements specification |
| Workflow Documentation Portfolio | 15% | Professional documentation for 3 workflows including diagrams and specs |
| Integration Challenge | 15% | Connect 3+ external services with AI processing in a single workflow |
| Final Project | 20% | End-to-end automated workflow solving a real business problem |
| Participation | 10% | In-class engagement, peer feedback, discussion contributions |

## Key Tools & Technologies

- n8n (self-hosted and/or cloud)
- OpenAI API
- Anthropic API
- Google AI API
- Postman (API testing)
- Google Sheets / Airtable
- PostgreSQL
- Gmail / IMAP
- Webhook.site (testing)
- Docker (for n8n deployment)
