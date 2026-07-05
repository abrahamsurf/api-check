API Fetch Script

A simple tool to check an API and get a nicely formatted JSON response —
no coding needed.

How to Use

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


Before You Run It

If the API needs a login token, open the script in Notepad and update this
line with your token:

set "AUTH_HEADER=Authorization: Bearer YOUR_TOKEN_HERE"
example:
set "AUTH_HEADER=Authorization: Bearer abc123XYZ34534534"

If no token is needed, just delete that line.

Requirements

Nothing to install — this works out of the box on Windows 10/11.
