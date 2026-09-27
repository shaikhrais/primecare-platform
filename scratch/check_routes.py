import os
import sqlite3

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
GROUPS_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\lib\routes\groups"

# Read all group files
group_contents = ""
for root, dirs, files in os.walk(GROUPS_DIR):
    for file in files:
        if file.endswith(".dart"):
            with open(os.path.join(root, file), "r", encoding="utf-8") as f:
                group_contents += f.read()

conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
cur = conn.cursor()

roles = cur.execute("SELECT role_code, primary_app_code, post_login_route FROM roles").fetchall()
conn.close()

print(f"{'Role Code':30} | {'App Code':10} | {'Post Login Route':55} | Exists in Dart")
print("-" * 120)
for r in roles:
    route = r["post_login_route"]
    exists = route in group_contents if route else False
    print(f"{r['role_code']:30} | {r['primary_app_code']:10} | {str(route):55} | {exists}")
