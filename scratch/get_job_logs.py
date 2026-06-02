import urllib.request
import sys

job_id = "78989012666"
url = f"https://api.github.com/repos/shaikhrais/primecare-platform/actions/jobs/{job_id}/logs"
print(f"Downloading logs for Job ID {job_id}...")
req = urllib.request.Request(
    url, 
    headers={
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
        'Accept': 'application/vnd.github.v3+json'
    }
)
try:
    with urllib.request.urlopen(req, timeout=15) as response:
        content = response.read().decode('utf-8', errors='ignore')
        lines = content.split('\n')
        print(f"Total lines: {len(lines)}")
        print("\nLast 150 lines of logs:")
        print('\n'.join(lines[-150:]))
        sys.exit(0)
except Exception as e:
    print(f"Error fetching logs: {e}")
    sys.exit(1)
