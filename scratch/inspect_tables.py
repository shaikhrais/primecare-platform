import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    print("--- SCREENS TABLE SCHEMA ---")
    cursor.execute("PRAGMA table_info(screens);")
    for r in cursor.fetchall():
        print(f"Column: {r['name']} ({r['type']})")
        
    print("\n--- ROLES TABLE SCHEMA ---")
    cursor.execute("PRAGMA table_info(roles);")
    for r in cursor.fetchall():
        print(f"Column: {r['name']} ({r['type']})")
        
    print("\n--- EXAMPLE RECORD FROM SCREENS ---")
    cursor.execute("SELECT * FROM screens LIMIT 1;")
    r = cursor.fetchone()
    if r:
        print(dict(r))
        
    conn.close()

if __name__ == '__main__':
    main()
