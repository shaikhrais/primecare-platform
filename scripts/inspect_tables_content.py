import sqlite3
import pathlib,sys
ROOT=pathlib.Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/"tools/governance-production"))
from connection import connect as governance_connect


conn = governance_connect()
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
