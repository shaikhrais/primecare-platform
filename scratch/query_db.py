import sqlite3

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
cur = conn.cursor()

screens = cur.execute("SELECT screen_code, screen_name, route_path FROM screens WHERE route_path LIKE '%dashboard%' OR route_path LIKE '%portal%' OR route_path LIKE '%dynamic%'").fetchall()
for s in screens:
    print(f"Code: {s['screen_code']:25} | Name: {s['screen_name']:35} | Route: {s['route_path']}")

conn.close()
