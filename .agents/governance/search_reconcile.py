import os

reconcile_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\reconcile_db.py"

with open(reconcile_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

print(f"Total lines: {len(lines)}")
matches = []
for i, line in enumerate(lines):
    if "screens" in line.lower() or "app_id" in line.lower():
        matches.append((i+1, line.strip()))

print(f"Found {len(matches)} matches:")
for num, content in matches[:50]:
    print(f"  Line {num}: {content}")
