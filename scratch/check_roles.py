import sqlite3
import json

DB_PATH = ".agents/governance/governance.db"

conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
cur = conn.cursor()

# Get all roles information
roles = cur.execute("""
    SELECT role_code, primary_app_code, primary_app_url, post_login_route
    FROM roles
""").fetchall()

print(f"Total roles in DB: {len(roles)}")
for role in roles:
    print(f"Role: {role['role_code']} | App: {role['primary_app_code']} | Route: {role['post_login_route']}")

conn.close()
