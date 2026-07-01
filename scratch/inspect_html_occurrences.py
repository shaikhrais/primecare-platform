import re

with open(r'reports/governance/primecare_governance_audit_2026-06-30_06-49-09.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Let's find matches around '971'
matches = re.findall(r'.{0,100}971.{0,100}', content)
print(f"Found {len(matches)} occurrences of '971':")
for m in matches[:10]:
    print("- ", m.strip())
