import sqlite3

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(db_path)
conn.row_factory = sqlite3.Row
cursor = conn.cursor()

cursor.execute("""
    SELECT id, screen_code, screen_name, actual_file_path, user_remarks 
    FROM screens 
    WHERE implementation_status = 'stub'
""")
rows = cursor.fetchall()
print(f"Stub screens found: {len(rows)}")
for r in rows:
    print(f"ID: {r['id']} | Code: {r['screen_code']} | Name: {r['screen_name']} | Path: {r['actual_file_path']} | Remarks: {r['user_remarks']}")

conn.close()
