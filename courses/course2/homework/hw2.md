# Homework 2: API Exploration

**GENAI 201: AI-Powered Workflows & Automation**
**Due:** End of Week 4 | **Points:** 100

## Learning Objectives

- Make HTTP requests using curl and/or Postman
- Parse JSON responses and extract specific fields
- Authenticate with API keys and Bearer tokens
- Handle common HTTP status codes and errors
- Read API documentation independently

## Prerequisites

- curl installed (or Postman/Insomnia)
- A free OpenWeatherMap API key (or similar free API)
- Basic command line comfort

## Instructions

### Part A: GET Requests & JSON Parsing (30 pts)

1. **Simple GET** (10 pts) — Use the JSONPlaceholder API (`https://jsonplaceholder.typicode.com`):
   - Fetch all posts by user ID 1
   - Show your curl command and the response (first 3 items only)
   - Extract just the titles using `jq`, Python, or manual parsing

2. **Parameterized GET** (10 pts) — Using a weather API (OpenWeatherMap free tier or wttr.in):
   - Fetch current weather for your city
   - Extract: temperature, description, humidity
   - Show the full curl command including your API key placement

3. **Nested JSON** (10 pts) — Using the GitHub API (`https://api.github.com`):
   - Fetch the repos for any public user
   - Extract: repo name, star count, and language for the top 5 by stars
   - Present results in a clean table format

### Part B: Authentication (30 pts)

1. **API Key Auth** (10 pts) — Demonstrate two different methods of passing an API key:
   - As a query parameter
   - As a header
   - Explain when you'd use each and which is more secure

2. **Bearer Token** (10 pts) — Using any API that supports Bearer tokens (GitHub personal access token, or a test API):
   - Make an authenticated request
   - Show what happens when the token is missing or invalid
   - Document the exact error response and status code

3. **Auth Comparison Table** (10 pts) — Create a table comparing:
   - API Key (query param)
   - API Key (header)
   - Bearer Token
   - OAuth 2.0 (describe conceptually; no implementation required)
   
   Columns: Method, Security Level, Ease of Use, Common Use Cases

### Part C: POST Requests & Error Handling (25 pts)

1. **Create a Resource** (10 pts) — Using JSONPlaceholder:
   - POST a new item with a JSON body
   - Show the request with headers (`Content-Type: application/json`)
   - Show the response and explain the status code

2. **Error Handling** (15 pts) — Deliberately trigger and document these errors:
   - 400 Bad Request — malformed body
   - 401 Unauthorized — missing/wrong credentials
   - 404 Not Found — wrong endpoint
   - 429 Too Many Requests — explain how you'd handle rate limiting (describe even if you can't trigger it)
   
   For each: show the request, response, status code, and what you'd do programmatically to handle it.

### Part D: Putting It Together (15 pts)

Write a short script (bash, Python, or JavaScript — your choice) that:

1. Calls an API endpoint
2. Parses the JSON response
3. Extracts specific fields
4. Formats output as a readable summary
5. Handles at least one error case (non-200 response)

The script should be runnable and include comments explaining each step.

## Submission

- Single document (PDF or Markdown) with all commands, outputs, and explanations
- Include your script file separately (or inline with syntax highlighting)
- Redact real API keys before submitting (replace with `YOUR_API_KEY`)

## Rubric

| Component | Points |
|---|---|
| GET Requests — correct commands, clean output | 30 |
| Authentication — all methods demonstrated | 30 |
| POST & Error Handling — correct triggers, explanations | 25 |
| Script — functional, commented, handles errors | 15 |
| **Total** | **100** |
