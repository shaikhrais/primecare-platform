with open(r'.agents/governance/generate_html_report.py', 'r', encoding='utf-8') as f:
    content = f.read()

import re
lines = content.split('\n')
for i, line in enumerate(lines):
    if 'screens' in line.lower() or 'roles' in line.lower():
        if 'select' in line.lower() or 'from' in line.lower():
            print(f"{i+1}: {line.strip()}")
