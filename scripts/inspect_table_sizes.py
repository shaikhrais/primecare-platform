import sqlite3

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
cur = conn.cursor()

# Get list of tables
cur.execute("SELECT name FROM sqlite_master WHERE type='table';")
tables = [row['name'] for row in cur.fetchall()]

print("=== Row Counts for Tables in governance.db ===")
for table in tables:
    cur.execute(f"SELECT COUNT(*) FROM {table};")
    count = cur.fetchone()[0]
    print(f"Table: {table} -> Rows: {count}")

conn.close()
