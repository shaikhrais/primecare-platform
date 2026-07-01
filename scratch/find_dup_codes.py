import sqlite3
import os

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    c.execute("""
        SELECT screen_code, COUNT(*) 
        FROM screens 
        GROUP BY screen_code 
        HAVING COUNT(*) > 1
    """)
    rows = c.fetchall()
    print(f"Found {len(rows)} duplicate screen codes:")
    for r in rows:
        code = r["screen_code"]
        count = r["COUNT(*)"]
        print(f"\nCode: {code} (Count: {count})")
        c.execute("""
            SELECT id, app_id, route_path, actual_file_path, implementation_status, production_ready 
            FROM screens 
            WHERE screen_code = ?
        """, (code,))
        for d in c.fetchall():
            print(f"  - ID={d['id']}, App={d['app_id']}, Route={d['route_path']}, Path={d['actual_file_path']}, Status={d['implementation_status']}, ProdReady={d['production_ready']}")

    conn.close()

if __name__ == "__main__":
    main()
