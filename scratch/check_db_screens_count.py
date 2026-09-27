import sqlite3
import os

DB_PATH = os.path.join(os.getcwd(), ".agents", "governance", "governance.db")
conn = sqlite3.connect(DB_PATH)
cursor = conn.cursor()

cursor.execute("SELECT COUNT(*) FROM screens;")
print("Total screens in SQLite DB:", cursor.fetchone()[0])

conn.close()
