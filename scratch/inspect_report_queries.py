with open(r'.agents/governance/generate_html_report.py', 'r', encoding='utf-8') as f:
    content = f.read()

import re
queries = re.findall(r'SELECT\s+.*?\s+FROM\s+.*?;', content, re.IGNORECASE | re.DOTALL)
print(f"Found {len(queries)} SELECT queries:")
for q in queries[:20]:
    print("- ", " ".join(q.split()))
