import sqlite3
import os

db_path = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

if not os.path.exists(db_path):
    print("Database not found at:", db_path)
    exit(1)

conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# Get table names
cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
tables = [r[0] for r in cursor.fetchall()]
print("Tables in database:")
for t in tables:
    cursor.execute(f"SELECT count(*) FROM {t};")
    count = cursor.fetchone()[0]
    print(f" - {t}: {count} rows")

print("\nSchema of orgs, apps, roles, screens:")
for t in ["orgs", "apps", "roles", "screens"]:
    if t in tables:
        print(f"\n--- Table: {t} ---")
        cursor.execute(f"PRAGMA table_info({t});")
        info = cursor.fetchall()
        for col in info:
            print(f"  {col[1]} ({col[2]})")
    else:
        print(f"\nTable {t} does not exist!")

conn.close()
