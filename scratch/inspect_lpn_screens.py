import sqlite3
import os

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    cursor.execute("""
        SELECT id, screen_code, screen_name, route_path, allowed_roles_text, data_cy_required_json 
        FROM screens 
        WHERE allowed_roles_text LIKE '%lpn%' 
           OR allowed_roles_text LIKE '%np%'
           OR allowed_roles_text LIKE '%pediatric%'
           OR allowed_roles_text LIKE '%physician%';
    """)
    rows = cursor.fetchall()
    print(f"Found {len(rows)} matching screens:")
    for r in rows:
        print(f"ID: {r['id']} | Code: {r['screen_code']} | Name: {r['screen_name']} | Route: {r['route_path']} | Roles: {r['allowed_roles_text']} | Selectors: {r['data_cy_required_json']}")
        
    conn.close()

if __name__ == '__main__':
    main()
