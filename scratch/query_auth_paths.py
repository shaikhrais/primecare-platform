import sqlite3

DB_PATH = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
c = conn.cursor()
rows = c.execute("SELECT id, screen_code, screen_name, actual_file_path FROM screens WHERE actual_file_path LIKE '%primecare_auth%'").fetchall()
for row in rows:
    print(dict(row))
conn.close()
