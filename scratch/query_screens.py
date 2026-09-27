import sqlite3

conn = sqlite3.connect('.agents/governance/governance.db')
cur = conn.cursor()

print("=== SCHEMA translation_keys ===")
cur.execute("PRAGMA table_info(translation_keys)")
for r in cur.fetchall():
    print(r)

conn.close()
