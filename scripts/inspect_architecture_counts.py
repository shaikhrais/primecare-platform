import sqlite3
import pathlib,sys
ROOT=pathlib.Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/"tools/governance-production"))
from connection import connect as governance_connect
import os


conn = governance_connect()
cur = conn.cursor()

print("=== Architecture Tables Count ===")
cur.execute("SELECT COUNT(*) FROM project_file_registry;")
print("project_file_registry count:", cur.fetchone()[0])

cur.execute("SELECT COUNT(*) FROM project_file_dependencies;")
print("project_file_dependencies count:", cur.fetchone()[0])

cur.execute("SELECT COUNT(*) FROM implementation_execution_plan;")
print("implementation_execution_plan count:", cur.fetchone()[0])

map_path = os.path.join(ROOT, "PROJECT_ARCHITECTURE_MAP.md")
if os.path.exists(map_path):
    print("PROJECT_ARCHITECTURE_MAP.md size (bytes):", os.path.getsize(map_path))
else:
    print("PROJECT_ARCHITECTURE_MAP.md does NOT exist!")

conn.close()
