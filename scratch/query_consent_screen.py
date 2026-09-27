import sqlite3
import os

DB_PATH = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
c = conn.cursor()
row = c.execute("SELECT * FROM screens WHERE screen_code = 'consent'").fetchone()
if row:
    print(dict(row))
else:
    print("Not found")
conn.close()
