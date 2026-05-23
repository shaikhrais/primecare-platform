import os

template_path = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\reports\governance\primecare_governance_audit_2026-05-22_20-57-21.html"

with open(template_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i, line in enumerate(lines):
    if "19" in line:
        print(f"Line {i+1}: {line.strip()}")
