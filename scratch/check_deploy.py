import urllib.request
import sys

url = "https://primecare-clinic.pages.dev/assets/assets/translations/en.json"
print(f"Fetching {url}...")
req = urllib.request.Request(
    url, 
    headers={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}
)
try:
    with urllib.request.urlopen(req, timeout=10) as response:
        content = response.read().decode('utf-8')
        print(f"Response status: {response.status}")
        print("First 300 characters of response:")
        print(content[:300])
        if "USERNAME" in content or "username" in content:
            print("\nDEPLOYMENT DETECTED: The latest version is LIVE!")
            sys.exit(0)
        else:
            print("\nOLD VERSION ACTIVE: 'Username' label not found.")
            sys.exit(1)
except Exception as e:
    print(f"Error fetching URL: {e}")
    sys.exit(1)
