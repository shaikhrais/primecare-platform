with open(r'.agents/governance/generate_html_report.py', 'r', encoding='utf-8') as f:
    content = f.read()

import re
matches = re.findall(r's\.[a-zA-Z0-9_]+', content)
print("Found these s. references:")
for m in sorted(list(set(matches))):
    print("- ", m)
