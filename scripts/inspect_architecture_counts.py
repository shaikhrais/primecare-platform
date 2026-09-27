import sqlite3
import os

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"

conn = sqlite3.connect(DB_PATH)
cur = conn.cursor()

print("=== Architecture Tables Count ===")
cur.execute("SELECT COUNT(*) FROM project_file_registry;")
print("project_file_registry count:", cur.fetchone()[0])

cur.execute("SELECT COUNT(*) FROM project_file_dependencies;")
print("project_file_dependencies count:", cur.fetchone()[0])

cur.execute("SELECT COUNT(*) FROM implementation_execution_plan;")
print("implementation_execution_plan count:", cur.fetchone()[0])

map_path = os.path.join(PROJECT_ROOT, "PROJECT_ARCHITECTURE_MAP.md")
if os.path.exists(map_path):
    print("PROJECT_ARCHITECTURE_MAP.md size (bytes):", os.path.getsize(map_path))
else:
    print("PROJECT_ARCHITECTURE_MAP.md does NOT exist!")

conn.close()
