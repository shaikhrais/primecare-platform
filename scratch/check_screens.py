import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    # Get table columns
    cursor.execute("PRAGMA table_info(screens);")
    columns = [row["name"] for row in cursor.fetchall()]
    print("Columns in screens table:", columns)
    
    # Get count
    cursor.execute("SELECT count(*) as count FROM screens;")
    print("Total screens:", cursor.fetchone()["count"])
    
    # Print a few samples
    cursor.execute("SELECT id, screen_code, route_path, actual_file_path, screen_status, role_id FROM screens LIMIT 10;")
    print("\nFirst 10 screens:")
    for row in cursor.fetchall():
        print(f"ID: {row['id']} | Code: {row['screen_code']} | Route: {row['route_path']} | Path: {row['actual_file_path']} | Status: {row['screen_status']} | Role ID: {row['role_id']}")
        
    conn.close()

if __name__ == '__main__':
    main()
