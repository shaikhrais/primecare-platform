import os
import sqlite3

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def check():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()
    
    roles = ['dynamic', 'infrastructure', 'system_verification', 'training', 'governance', 'scrum_master', 'employee', 'volunteer', 'admin', 'training_coordinator']
    
    print("--- ROADS FOR GOVERNANCE ROLES ---")
    placeholders = ",".join("?" for _ in roles)
    rows = cur.execute(f"""
        SELECT r.role_code, r.role_name, r.primary_app_code, r.primary_app_url, r.auth_redirect_url, r.post_login_route
        FROM roles r
        WHERE r.role_code IN ({placeholders})
    """, roles).fetchall()
    
    for r in rows:
        print(f"Role: {r['role_code']} | App: {r['primary_app_code']} | URL: {r['primary_app_url']} | Redirect: {r['auth_redirect_url']} | Route: {r['post_login_route']}")
        
    conn.close()

if __name__ == "__main__":
    check()
