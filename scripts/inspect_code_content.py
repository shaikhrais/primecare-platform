import sqlite3

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
cur = conn.cursor()

cur.execute("""
    SELECT file_name, file_type, code_content 
    FROM project_file_registry 
    WHERE file_type = 'screen' 
    LIMIT 2;
""")
for row in cur.fetchall():
    print(f"=== File Name: {row['file_name']} (Type: {row['file_type']}) ===")
    print(row['code_content'])

conn.close()
