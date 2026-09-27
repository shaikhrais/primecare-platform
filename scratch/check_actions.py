import urllib.request
import json
import sys

url = "https://api.github.com/repos/shaikhrais/primecare-platform/actions/runs"
print(f"Fetching GitHub Actions status for shaikhrais/primecare-platform...")
req = urllib.request.Request(
    url, 
    headers={
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
        'Accept': 'application/vnd.github.v3+json'
    }
)
try:
    with urllib.request.urlopen(req, timeout=10) as response:
        if response.status == 200:
            data = json.loads(response.read().decode('utf-8'))
            runs = data.get('workflow_runs', [])
            if not runs:
                print("No workflow runs found.")
                sys.exit(0)
            
            # Print the top 3 runs
            for run in runs[:3]:
                print(f"Run ID: {run['id']}")
                print(f"Name: {run['name']}")
                print(f"Event: {run['event']}")
                print(f"Status: {run['status']}")
                print(f"Conclusion: {run['conclusion']}")
                print(f"Commit: {run['head_commit']['message']}")
                print(f"URL: {run['html_url']}")
                print("-" * 50)
            sys.exit(0)
        else:
            print(f"Failed. Status: {response.status}")
            sys.exit(1)
except Exception as e:
    print(f"Error fetching Actions: {e}")
    sys.exit(1)
