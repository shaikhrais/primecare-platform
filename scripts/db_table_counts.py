import sqlite3
import pathlib,sys
ROOT=pathlib.Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/"tools/governance-production"))
from connection import connect as governance_connect


conn = governance_connect()
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
