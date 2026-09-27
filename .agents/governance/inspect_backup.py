import sqlite3

conn = sqlite3.connect('.agents/governance/governance.db.bak')
conn.row_factory = sqlite3.Row
cursor = conn.cursor()
cursor.execute("SELECT name, sql FROM sqlite_master WHERE type='table';")
for row in cursor.fetchall():
    print(f"=== TABLE: {row['name']} ===")
    print(row['sql'])
    print()
conn.close()
