import json

file_path = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\cypress\fixtures\governance\screens.json"

with open(file_path, "r", encoding="utf-8") as f:
    screens = json.load(f)

for s in screens:
    route_path = s.get("route_path") or ""
    screen_code = s.get("screen_code") or ""
    if "dynamic" in screen_code or "dynamic" in route_path:
        print(s)
