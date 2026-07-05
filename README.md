API Fetch Script

A simple tool to check an API and get a nicely formatted JSON response —
no coding needed.

**How to Use**

Option 1: Just double-click it
Run api-fetch.bat and type in the API URL when asked.

Option 2: Run it with the URL already included

api-fetch.bat https://api.example.com/status

💡 If your URL has an & in it (like ...?key=abc&format=json), wrap it in
quotes:

api-fetch.bat "https://api.example.com/status?key=abc&format=json"

What You Get

A file called api_response.json — the response, neatly formatted and
easy to read
A quick summary printed on screen showing each field and its value

**Before You Run It**

If the API needs a login token, open the script in Notepad and update this
line with your token:

set "AUTH_HEADER=Authorization: Bearer YOUR_TOKEN_HERE"
example:
set "AUTH_HEADER=Authorization: Bearer abc123XYZ34534534"

If no token is needed, just delete that line.

**Requirements**

Nothing to install — this works out of the box on Windows 10/11 with curl and powershell.

**The Problem

**When you manually visit an API endpoint in a browser (or paste a URL and hit enter), you get back something like:
json{"status":"ok","version":"2.1","data":{"uptime":123,"region":"us-east-1"},"message":"All systems operational"}
That's all on one line, no indentation, no line breaks — technically valid JSON, but genuinely hard to read at a glance, especially with nested objects or longer responses. You end up squinting, manually scrolling sideways, or copy-pasting it into some online JSON formatter just to make sense of it.

**What this script does instead
**
Sends the same GET request curl would send from the command line (with a proper browser-like User-Agent so it behaves like a real browser request, not a bare script)
Takes the raw JSON response
Reformats it with proper indentation and line breaks
Saves that clean version to api_response.json
Also prints a simple field-by-field summary on screen, so you don't even need to open the file for a quick check

**Why this beats just pasting the URL into a browser
**
No manual formatting step — you're not relying on browser JSON viewer extensions or copy-pasting into a third-party formatter site (which also means not pasting potentially sensitive API data into an external tool)
Saved locally — you get a persistent, readable file you can reference later, diff against a previous run, or share with a teammate
Repeatable — same command every time, works for any endpoint, no browser required
Scriptable — since it takes the URL as an argument, you could eventually loop it over multiple endpoints or schedule it, which manual browsing can't do

**Basically:** it's a lightweight, no-install replacement for "paste URL in browser → squint at unformatted JSON → maybe use an online prettifier."
