import sqlite3

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
cur = conn.cursor()

# Get all tables
cur.execute("SELECT name FROM sqlite_master WHERE type='table';")
tables = [row['name'] for row in cur.fetchall()]

print("=== Table Counts ===")
for table in sorted(tables):
    cur.execute(f"SELECT COUNT(*) as count FROM {table};")
    cnt = cur.fetchone()['count']
    print(f"| {table} | {cnt} |")

conn.close()
