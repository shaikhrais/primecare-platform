import sqlite3

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def list_cfo_files():
    conn = sqlite3.connect(db_path)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()
    c.execute("SELECT id, screen_name, route_path, actual_file_path, file_path FROM screens WHERE role_key = 'cfo'")
    rows = c.fetchall()
    for r in rows:
        print(f"ID: {r['id']} | Name: {r['screen_name']} | File: {r['actual_file_path'] or r['file_path']}")
    conn.close()

if __name__ == "__main__":
    list_cfo_files()
