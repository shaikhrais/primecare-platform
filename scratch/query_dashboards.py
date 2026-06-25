import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    cursor.execute("""
        SELECT screen_code, route_path, app_id, allowed_roles_text 
        FROM screens 
        WHERE screen_code LIKE '%dashboard%'
    """)
    rows = cursor.fetchall()
    print(f"Found {len(rows)} dashboards:")
    for row in rows:
        print(dict(row))
    conn.close()

if __name__ == '__main__':
    main()
