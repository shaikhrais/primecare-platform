import os

report_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\reports\governance\primecare_governance_audit_2026-05-22_23-14-44.html"

with open(report_path, 'r', encoding='utf-8') as f:
    content = f.read()

index = content.find("<h2>Applications Summary</h2>")
if index != -1:
    print(content[index:index+1500])
else:
    print("Not found")
