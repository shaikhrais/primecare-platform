import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    cursor.execute("""
        SELECT id, screen_code, route_path, allowed_roles_text, actual_file_path, cypress_ready, screen_status 
        FROM screens 
        WHERE screen_code LIKE '%dynamic%' OR route_path LIKE '%dynamic%';
    """)
    for row in cursor.fetchall():
        print(dict(row))
        
    conn.close()

if __name__ == '__main__':
    main()
