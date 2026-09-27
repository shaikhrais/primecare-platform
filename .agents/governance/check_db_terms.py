with open(r'C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance_db.py', 'r', encoding='utf-8') as f:
    content = f.read()

for term in ["governance_logs", "dev_artifact_snapshots", "dev_change_logs", "governance_reports"]:
    print(f"Term '{term}': {content.count(term)}")
