import os

report_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\reports\governance\primecare_governance_audit_2026-05-22_20-57-21.html"

with open(report_path, 'r', encoding='utf-8') as f:
    content = f.read()

index = content.find("<h2>Applications Summary</h2>")
if index != -1:
    # Print the surrounding lines of the H2 tag to see its card container
    start = max(0, index - 200)
    end = min(len(content), index + 1000)
    print(content[start:end])
else:
    print("Not found")
