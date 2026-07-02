import sqlite3

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
cur = conn.cursor()

# Get all tables
cur.execute("SELECT name FROM sqlite_master WHERE type='table';")
tables = [row['name'] for row in cur.fetchall()]

print("=== Table Counts ===")
counts = {}
for table in tables:
    cur.execute(f"SELECT COUNT(*) as count FROM {table};")
    cnt = cur.fetchone()['count']
    counts[table] = cnt
    print(f"{table}: {cnt}")

print("\n=== Foreign Key Details ===")
for table in tables:
    cur.execute(f"PRAGMA foreign_key_list({table});")
    fks = cur.fetchall()
    if fks:
        print(f"Table: {table}")
        for fk in fks:
            print(f"  {fk['from']} -> {fk['table']}({fk['to']})")

conn.close()
