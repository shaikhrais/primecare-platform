import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    cursor.execute("PRAGMA table_info(roles)")
    for col in cursor.fetchall():
        print(f"  - {col['name']} ({col['type']})")
        
    print("\nSample Rows:")
    cursor.execute("SELECT * FROM roles LIMIT 3")
    for r in cursor.fetchall():
        print(dict(r))
        
    conn.close()

if __name__ == '__main__':
    main()
