import json

file_path = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\cypress\fixtures\governance\screens.json"

with open(file_path, "r", encoding="utf-8") as f:
    screens = json.load(f)

for s in screens:
    if s.get("screen_code") == "dynamic" or s.get("id") == 819:
        print(json.dumps(s, indent=2))
