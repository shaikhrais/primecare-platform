import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    cursor.execute("SELECT COUNT(*) FROM screens")
    total = cursor.fetchone()[0]
    print(f"Total screens: {total}")
    
    cursor.execute("SELECT COUNT(*) FROM screens WHERE screen_type = 'dashboard'")
    dashboards = cursor.fetchone()[0]
    print(f"Total dashboards: {dashboards}")
    
    cursor.execute("SELECT screen_code, screen_type, route_path FROM screens LIMIT 20")
    for row in cursor.fetchall():
        print(dict(row))
        
    conn.close()

if __name__ == '__main__':
    main()
