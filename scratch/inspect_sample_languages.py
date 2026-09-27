import sqlite3

DB_PATH = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
c = conn.cursor()

print("Languages:")
languages = c.execute("SELECT * FROM languages").fetchall()
for lang in languages:
    print(dict(lang))

print("\nSample Translation Keys/Values:")
keys = c.execute("SELECT * FROM translation_keys LIMIT 5").fetchall()
for k in keys:
    print(dict(k))
    val = c.execute("SELECT * FROM translation_values WHERE key_id = ?", (k["id"],)).fetchall()
    for v in val:
        print("  ", dict(v))

conn.close()
