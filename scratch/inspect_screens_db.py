import sqlite3

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
c = conn.cursor()

c.execute("PRAGMA table_info(screens)")
print("Columns:")
for col in c.fetchall():
    print(col['name'], col['type'])

print("\nCounts:")
c.execute("SELECT COUNT(*), production_ready FROM screens GROUP BY production_ready")
for row in c.fetchall():
    print(f"production_ready={row[1]}: {row[0]}")

c.execute("SELECT COUNT(*), false_progress FROM screens GROUP BY false_progress")
for row in c.fetchall():
    print(f"false_progress={row[1]}: {row[0]}")

conn.close()
