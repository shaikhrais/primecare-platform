import sqlite3

DB_PATH = ".agents/governance/governance.db"
conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
cur = conn.cursor()

def check_role_screens(role_code):
    print(f"\n=== SCREENS FOR ROLE: {role_code} ===")
    role = cur.execute("SELECT id, role_name FROM roles WHERE role_code = ?", (role_code,)).fetchone()
    if not role:
        print(f"Role {role_code} not found.")
        return
    print(f"Role Name: {role['role_name']}, ID: {role['id']}")
    screens = cur.execute("SELECT id, screen_name, screen_code, route_path FROM screens WHERE role_id = ?", (role['id'],)).fetchall()
    for s in screens:
        print(dict(s))

check_role_screens('ceo')
check_role_screens('admin')
check_role_screens('bus_dev')

conn.close()
