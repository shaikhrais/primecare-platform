with open(r'C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance_db.py', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i, line in enumerate(lines):
    if "CREATE TABLE" in line:
        print(f"Line {i+1}: {line.strip()}")
