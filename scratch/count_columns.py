import sqlite3

db_path = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

cursor.execute("PRAGMA table_info(screens);")
cols = cursor.fetchall()
print("Number of columns in table screens:", len(cols))

conn.close()
