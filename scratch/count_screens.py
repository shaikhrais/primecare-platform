import sqlite3

DB_PATH = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(DB_PATH)
c = conn.cursor()

print("active=1:", c.execute("SELECT count(*) FROM screens WHERE active = 1").fetchone()[0])
print("cypress_verified=1:", c.execute("SELECT count(*) FROM screens WHERE cypress_verified = 1").fetchone()[0])
print("runtime_verified=1:", c.execute("SELECT count(*) FROM screens WHERE runtime_verified = 1").fetchone()[0])

conn.close()
