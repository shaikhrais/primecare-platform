import sqlite3

DB_PATH = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
c = conn.cursor()

print("Themes:")
themes = c.execute("SELECT * FROM themes").fetchall()
for theme in themes:
    print(dict(theme))

print("\nSample Design Tokens:")
tokens = c.execute("SELECT * FROM design_tokens LIMIT 10").fetchall()
for token in tokens:
    print(dict(token))

conn.close()
