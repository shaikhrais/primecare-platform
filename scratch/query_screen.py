import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    cursor.execute("""
        SELECT id, screen_code, route_path, actual_file_path, cypress_ready, screen_status 
        FROM screens 
        WHERE screen_code LIKE '%hr_director_dashboard%';
    """)
    for row in cursor.fetchall():
        print(f"ID: {row['id']} | Code: {row['screen_code']} | Route: {row['route_path']} | Path: {row['actual_file_path']} | Cypress Ready: {row['cypress_ready']} | Status: {row['screen_status']}")
        
    conn.close()

if __name__ == '__main__':
    main()
