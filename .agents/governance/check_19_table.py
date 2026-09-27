import os

report_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\reports\governance\primecare_governance_audit_2026-05-22_23-13-33.html"

with open(report_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i, line in enumerate(lines):
    if "19-Table" in line:
        print(f"Line {i+1}: {line.strip()}")
