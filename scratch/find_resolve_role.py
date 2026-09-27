with open(r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\reconcile_db.py", "r", encoding="utf-8") as f:
    lines = f.readlines()

for idx, line in enumerate(lines, 1):
    if "def resolve_role" in line or "resolve_role_id" in line:
        print(f"Line {idx}: {line.strip()}")
