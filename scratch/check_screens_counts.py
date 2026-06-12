import os
import sqlite3

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def check():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()
    
    print("--- SCREENS BY APP ---")
    rows = cur.execute("""
        SELECT a.id, a.app_code, a.app_name, COUNT(s.id) as cnt
        FROM apps a
        LEFT JOIN screens s ON s.app_id = a.id
        GROUP BY a.id, a.app_code, a.app_name
    """).fetchall()
    for r in rows:
        print(f"App ID: {r['id']} | Code: {r['app_code']} | Name: {r['app_name']} | Screens: {r['cnt']}")
        
    print("\n--- SCREENS BY STATUS ---")
    rows = cur.execute("SELECT screen_status, count(*) as cnt FROM screens GROUP BY screen_status").fetchall()
    for r in rows:
        print(f"Status: {r['screen_status']} | Count: {r['cnt']}")
        
    print("\n--- DUPLICATE SCREEN CODES ---")
    rows = cur.execute("""
        SELECT screen_code, count(*) as cnt
        FROM screens
        GROUP BY screen_code
        HAVING count(*) > 1
        ORDER BY cnt DESC
        LIMIT 10
    """).fetchall()
    print(f"Total duplicate screen codes: {len(rows)}")
    for r in rows:
        print(f"Code: {r['screen_code']} | Count: {r['cnt']}")
        
    print("\n--- NULL OR EMPTY DESC BY STATUS ---")
    rows = cur.execute("""
        SELECT screen_status, count(*) as cnt
        FROM screens
        WHERE component_behavior_text IS NULL OR TRIM(component_behavior_text) = ''
        GROUP BY screen_status
    """).fetchall()
    for r in rows:
        print(f"Status: {r['screen_status']} | Empty Desc Count: {r['cnt']}")
        
    conn.close()

if __name__ == "__main__":
    check()
