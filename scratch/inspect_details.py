import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    # Total screens
    cursor.execute("SELECT COUNT(*) FROM screens")
    total = cursor.fetchone()[0]
    
    # Screens with null role_id
    cursor.execute("SELECT COUNT(*) FROM screens WHERE role_id IS NULL")
    null_role_count = cursor.fetchone()[0]
    
    print(f"Total Screens in Registry: {total}")
    print(f"Screens with NULL role_id: {null_role_count}")
    
    # List top 20 NULL role_id screens
    cursor.execute("""
        SELECT id, screen_code, route_path, actual_file_path 
        FROM screens 
        WHERE role_id IS NULL 
        LIMIT 20;
    """)
    print("\nSample NULL role_id screens:")
    for r in cursor.fetchall():
        route = str(r['route_path']) if r['route_path'] is not None else 'None'
        path = str(r['actual_file_path']) if r['actual_file_path'] is not None else 'None'
        print(f"  Code: {r['screen_code']:<35} | Route: {route:<45} | Path: {path}")
        
    conn.close()

if __name__ == '__main__':
    main()







