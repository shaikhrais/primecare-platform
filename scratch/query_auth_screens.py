import sqlite3
import os

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    c.execute("""
        SELECT id, screen_code, route_path, actual_file_path, implementation_status, production_ready 
        FROM screens 
        WHERE screen_code LIKE '%login%' OR screen_code LIKE '%auth%' OR screen_code LIKE '%signin%'
    """)
    rows = c.fetchall()
    print("Auth/Login screens in screens table:")
    for r in rows:
        print(dict(r))

    conn.close()

if __name__ == "__main__":
    main()
