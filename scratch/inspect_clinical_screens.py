import sqlite3
import os

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    c.execute("""
        SELECT id, screen_code, route_path, actual_file_path, implementation_status, production_ready 
        FROM screens 
        WHERE screen_code LIKE '%clinical%' OR screen_code LIKE '%dashboard%'
        ORDER BY screen_code, id
    """)
    rows = c.fetchall()
    print(f"Found {len(rows)} screens:")
    for r in rows:
        print(f"ID: {r['id']}, Code: {r['screen_code']}, Route: {r['route_path']}, Path: {r['actual_file_path']}, Status: {r['implementation_status']}, ProdReady: {r['production_ready']}")

    conn.close()

if __name__ == "__main__":
    main()
