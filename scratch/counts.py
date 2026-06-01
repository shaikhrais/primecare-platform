import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    print("=== ORGS ===")
    cursor.execute("SELECT id, org_code, org_name FROM orgs")
    for r in cursor.fetchall():
        print(f"  ID: {r['id']}, Code: {r['org_code']}, Name: {r['org_name']}")
        
    print("\n=== APPS ===")
    cursor.execute("SELECT id, org_id, app_code, app_name FROM apps")
    for r in cursor.fetchall():
        print(f"  ID: {r['id']}, OrgID: {r['org_id']}, Code: {r['app_code']}, Name: {r['app_name']}")
        
    print("\n=== ROLES (first 10) ===")
    cursor.execute("SELECT id, app_id, role_code, role_name FROM roles LIMIT 10")
    for r in cursor.fetchall():
        print(f"  ID: {r['id']}, AppID: {r['app_id']}, Code: {r['role_code']}, Name: {r['role_name']}")
        
    cursor.execute("SELECT COUNT(*) FROM roles")
    print(f"Total roles count: {cursor.fetchone()[0]}")
    
    conn.close()

if __name__ == '__main__':
    main()
