import re

with open(r'C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance_db.py', 'r', encoding='utf-8') as f:
    content = f.read()

# Find all CREATE TABLE blocks
matches = re.findall(r'CREATE TABLE IF NOT EXISTS\s+(\w+)\s*\(', content, re.IGNORECASE)
print(f"Tables created: {len(matches)}")
print(matches)
