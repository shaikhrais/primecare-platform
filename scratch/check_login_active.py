import sqlite3

DB_PATH = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(DB_PATH)
c = conn.cursor()
print(c.execute("SELECT active FROM screens WHERE screen_code = 'login'").fetchone()[0])
conn.close()
