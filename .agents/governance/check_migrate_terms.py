with open(r'C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\migrate_to_sqlite.py', 'r', encoding='utf-8') as f:
    content = f.read()

terms = ["dev_artifact_snapshots", "data_entries", "dev_change_logs", "transactions", "governance_reports", "saved_reports"]
for term in terms:
    print(f"Term '{term}': {content.count(term)}")
