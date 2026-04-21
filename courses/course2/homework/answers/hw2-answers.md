# HW2 Answers: API Exploration

**GENAI 201 — Model Answers & Grading Notes**

---

## Part A: GET Requests & JSON Parsing (30 pts)

### Simple GET (10 pts)

```bash
curl -s "https://jsonplaceholder.typicode.com/posts?userId=1" | jq '.[0:3] | .[].title'
```

Output:
```
"sunt aut facere repellat provident occaecati excepturi optio reprehenderit"
"qui est esse"
"ea molestias quasi exercitationem repellat qui ipsa sit aut"
```

**Grading notes:** Accept any method of limiting to 3 items and extracting titles (jq, Python, grep, manual copy). Deduct 5 pts if they dump the entire unfiltered response.

### Parameterized GET (10 pts)

```bash
curl -s "https://api.openweathermap.org/data/2.5/weather?q=New+York&appid=YOUR_API_KEY&units=metric" | jq '{temp: .main.temp, description: .weather[0].description, humidity: .main.humidity}'
```

Output:
```json
{
  "temp": 18.5,
  "description": "scattered clouds",
  "humidity": 62
}
```

**Grading notes:** wttr.in (`curl wttr.in/NewYork?format=j1`) is also acceptable. Must extract the three requested fields.

### Nested JSON (10 pts)

```bash
curl -s "https://api.github.com/users/torvalds/repos?per_page=100&sort=stars" | jq '.[0:5] | .[] | {name, stars: .stargazers_count, language}'
```

**Grading notes:** Any public user is fine. Must present as a table or structured format with all 3 fields.

## Part B: Authentication (30 pts)

### API Key Auth (10 pts)

**Query parameter:**
```bash
curl "https://api.example.com/data?api_key=abc123"
```

**Header:**
```bash
curl -H "X-API-Key: abc123" "https://api.example.com/data"
```

Header is more secure — query params appear in server logs, browser history, and proxy logs. Headers are not logged by default.

**Grading notes:** Must demonstrate both methods and explain the security difference. Deduct 5 pts if security comparison is missing.

### Bearer Token (10 pts)

```bash
# Authenticated
curl -H "Authorization: Bearer ghp_xxxxxxxxxxxx" "https://api.github.com/user"

# Missing token — returns 401
curl "https://api.github.com/user"
```

Response without token:
```json
{
  "message": "Requires authentication",
  "documentation_url": "https://docs.github.com/rest"
}
```

**Grading notes:** Must show both success and failure. Must identify the 401 status code.

### Auth Comparison Table (10 pts)

| Method | Security | Ease of Use | Common Use Cases |
|---|---|---|---|
| API Key (query) | Low — visible in logs/URLs | Very easy | Quick prototyping, public APIs |
| API Key (header) | Medium — not in URLs | Easy | Production API access |
| Bearer Token | High — short-lived, revocable | Medium | User-scoped access, OAuth flows |
| OAuth 2.0 | Highest — delegated, scoped | Complex | Third-party integrations, user consent |

**Grading notes:** All four rows required. Accept reasonable variations in descriptions.

## Part C: POST & Error Handling (25 pts)

### Create a Resource (10 pts)

```bash
curl -X POST "https://jsonplaceholder.typicode.com/posts" \
  -H "Content-Type: application/json" \
  -d '{"title": "Test Post", "body": "Hello world", "userId": 1}'
```

Response: `201 Created` with the new resource including an `id` field.

**Grading notes:** Must include Content-Type header and show the 201 status.

### Error Handling (15 pts)

**400:** `curl -X POST "https://jsonplaceholder.typicode.com/posts" -H "Content-Type: application/json" -d 'not json'`

**401:** `curl -H "Authorization: Bearer invalid" "https://api.github.com/user"`

**404:** `curl "https://jsonplaceholder.typicode.com/nonexistent"`

**429:** Explain: implement exponential backoff, respect `Retry-After` header, queue requests.

**Grading notes:** 3–4 pts each. Must show actual request and response for 400, 401, 404. Description is acceptable for 429 since it's hard to trigger reliably.

## Part D: Script (15 pts)

```python
import requests
import sys

def get_weather(city):
    """Fetch and display weather for a city."""
    url = f"https://wttr.in/{city}?format=j1"
    
    try:
        resp = requests.get(url, timeout=10)
        resp.raise_for_status()  # Raises exception for 4xx/5xx
    except requests.exceptions.RequestException as e:
        print(f"Error fetching weather: {e}")
        sys.exit(1)
    
    data = resp.json()
    current = data["current_condition"][0]
    
    print(f"Weather for {city}:")
    print(f"  Temperature: {current['temp_F']}°F / {current['temp_C']}°C")
    print(f"  Condition: {current['weatherDesc'][0]['value']}")
    print(f"  Humidity: {current['humidity']}%")
    print(f"  Wind: {current['windspeedMiles']} mph")

if __name__ == "__main__":
    city = sys.argv[1] if len(sys.argv) > 1 else "New York"
    get_weather(city)
```

**Grading notes:** Any language is fine. Must: call an API, parse JSON, extract fields, format output, handle at least one error. Deduct 5 pts for no error handling. Deduct 3 pts for no comments.
