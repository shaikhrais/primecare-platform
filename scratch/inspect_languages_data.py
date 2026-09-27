import sqlite3

DB_PATH = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(DB_PATH)
c = conn.cursor()

print("language_registry count:", c.execute("SELECT count(*) FROM language_registry").fetchone()[0])
print("languages count:", c.execute("SELECT count(*) FROM languages").fetchone()[0])

conn.close()
