import sqlite3

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
cur = conn.cursor()

print("=== screen_diagnosis_tests sample ===")
cur.execute("SELECT * FROM screen_diagnosis_tests LIMIT 2;")
for row in cur.fetchall():
    print(dict(row))

print("\n=== screen_implementation_tasks sample ===")
cur.execute("SELECT * FROM screen_implementation_tasks LIMIT 2;")
for row in cur.fetchall():
    print(dict(row))

conn.close()
