import os
import sqlite3

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    print("--- SCREENS FOR RN (role_id for rn is probably different, let's find it) ---")
    cursor.execute("SELECT id, role_code FROM roles WHERE role_code IN ('rn', 'rpn', 'psw');")
    role_ids = {r['role_code']: r['id'] for r in cursor.fetchall()}
    print(f"Role IDs: {role_ids}")
    
    for role_code, r_id in role_ids.items():
        print(f"\n--- SCREENS FOR {role_code.upper()} (role_id={r_id}) ---")
        cursor.execute("SELECT id, screen_code, screen_name, route_path FROM screens WHERE role_id = ?;", (r_id,))
        for row in cursor.fetchall():
            print(f"ID: {row['id']} | Code: {row['screen_code']} | Name: {row['screen_name']} | Route: {row['route_path']}")
            
    conn.close()

if __name__ == '__main__':
    main()
