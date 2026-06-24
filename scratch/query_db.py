import sqlite3

conn = sqlite3.connect('.agents/governance/governance.db')
conn.row_factory = sqlite3.Row
cur = conn.cursor()

print("--- SCREENS FOR ROLE 49 (PREMIUM CONCIERGE) ---")
r = cur.execute("SELECT id, screen_code, app_id, route_path FROM screens WHERE role_id = 49").fetchall()
for row in r:
    print(f"ID: {row['id']} | Code: {row['screen_code']} | App ID: {row['app_id']} | Route: {row['route_path']}")

print("\n--- SCREENS FOR ROLE 50 (VIP MANAGER) ---")
r = cur.execute("SELECT id, screen_code, app_id, route_path FROM screens WHERE role_id = 50").fetchall()
for row in r:
    print(f"ID: {row['id']} | Code: {row['screen_code']} | App ID: {row['app_id']} | Route: {row['route_path']}")

conn.close()
