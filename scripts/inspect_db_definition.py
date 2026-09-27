import sqlite3

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
cur = conn.cursor()

cur.execute("SELECT * FROM screen_test_definitions WHERE screen_id = 235;")
row = cur.fetchone()
print(dict(row) if row else "None")

conn.close()
