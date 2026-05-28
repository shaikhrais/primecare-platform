import os
import sqlite3

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    print("--- ROLES AND POST_LOGIN_ROUTE IN DB ---")
    cursor.execute("SELECT id, role_code, post_login_route FROM roles;")
    for r in cursor.fetchall():
        print(f"Role ID: {r['id']} | Code: {r['role_code']} | Post Login Route: {r['post_login_route']}")
        
    print("\n--- SAMPLE SCREENS BY ROLE ---")
    cursor.execute("""
        SELECT r.role_code, s.screen_code, s.route_path 
        from screens s
        join roles r on s.role_id = r.id
        group by r.role_code;
    """)
    for r in cursor.fetchall():
        print(f"Role: {r['role_code']} | Screen Code: {r['screen_code']} | Route: {r['route_path']}")
        
    conn.close()

if __name__ == '__main__':
    main()
