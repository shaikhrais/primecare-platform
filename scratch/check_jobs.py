import urllib.request
import json
import sys

run_id = "26795208902"
url = f"https://api.github.com/repos/shaikhrais/primecare-platform/actions/runs/{run_id}/jobs"
print(f"Fetching GitHub Actions jobs for Run ID {run_id}...")
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
            jobs = data.get('jobs', [])
            for job in jobs:
                print(f"Job Name: {job['name']}")
                print(f"Job ID: {job['id']}")
                print(f"Status: {job['status']}")
                print(f"Conclusion: {job['conclusion']}")
                print("-" * 50)
            sys.exit(0)
        else:
            print(f"Failed. Status: {response.status}")
            sys.exit(1)
except Exception as e:
    print(f"Error fetching jobs: {e}")
    sys.exit(1)
