import sqlite3

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
cur = conn.cursor()

print("=== PSW Screen Results after Cypress run ===")
cur.execute("""
    SELECT s.screen_code, s.screen_name, s.runtime_verified, s.cypress_verified, s.production_ready
    FROM screens s
    JOIN role_screen_map rsm ON rsm.screen_id = s.id
    JOIN roles r ON rsm.role_id = r.id
    WHERE r.role_code = 'psw';
""")
for row in cur.fetchall():
    print(dict(row))

conn.close()
