import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    cursor.execute("SELECT id, role_code, role_name FROM roles ORDER BY id")
    for r in cursor.fetchall():
        print(f"ID: {r['id']:<3} | Code: {r['role_code']:<30} | Name: {r['role_name']}")
        
    conn.close()

if __name__ == '__main__':
    main()

