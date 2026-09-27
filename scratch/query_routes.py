import sqlite3
import os

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    c.execute("""
        SELECT id, screen_code, route_path, actual_file_path 
        FROM screens 
        WHERE screen_code LIKE '%dashboard' 
          AND route_path NOT LIKE 'packages%' 
        LIMIT 10
    """)
    rows = c.fetchall()
    for row in rows:
        print(dict(row))
        
    conn.close()

if __name__ == "__main__":
    main()
