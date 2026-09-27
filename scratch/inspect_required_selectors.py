import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    # Query clinical dashboards
    cursor.execute("""
        SELECT screen_code, screen_name, route_path, actual_file_path, data_cy_required_json
        FROM screens
        WHERE screen_code LIKE '%dashboard%'
          AND (route_path LIKE '%clinical%' OR route_path LIKE '%offices%')
        LIMIT 10;
    """)
    for r in cursor.fetchall():
        print(f"Screen: {r['screen_code']}")
        print(f"  Path: {r['route_path']}")
        print(f"  File: {r['actual_file_path']}")
        print(f"  Required: {r['data_cy_required_json']}")
        
    conn.close()

if __name__ == '__main__':
    main()
