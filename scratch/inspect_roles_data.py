import sqlite3

DB_PATH = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(DB_PATH)
c = conn.cursor()
rows = c.execute("SELECT * FROM roles LIMIT 5").fetchall()
for r in rows:
    print(r)
conn.close()
