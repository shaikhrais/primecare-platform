import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    # Get role admin id
    cursor.execute("SELECT id, role_code FROM roles WHERE role_code = 'admin';")
    admin = cursor.fetchone()
    if admin:
        print(f"Role: {admin['role_code']} | ID: {admin['id']}")
        
        # Get screens for admin
        cursor.execute("SELECT id, screen_code, screen_name, route_path, actual_file_path FROM screens WHERE role_id = ?;", (admin['id'],))
        print("\nAdmin Screens:")
        for row in cursor.fetchall():
            print(f"ID: {row['id']} | Code: {row['screen_code']} | Route: {row['route_path']} | Path: {row['actual_file_path']}")
    else:
        print("Admin role not found!")
        
    # Search for office-dashboard
    cursor.execute("SELECT id, screen_code, route_path, actual_file_path, role_id FROM screens WHERE route_path LIKE '%office-dashboard%';")
    print("\nScreens containing 'office-dashboard':")
    for row in cursor.fetchall():
        print(f"ID: {row['id']} | Code: {row['screen_code']} | Route: {row['route_path']} | Path: {row['actual_file_path']} | Role ID: {row['role_id']}")

    conn.close()

if __name__ == '__main__':
    main()
