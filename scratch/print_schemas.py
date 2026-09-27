import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    tables = ['orgs', 'apps', 'roles', 'screens']
    for table in tables:
        cursor.execute(f"SELECT COUNT(*) FROM {table}")
        count = cursor.fetchone()[0]
        cursor.execute(f"PRAGMA table_info({table})")
        cols = cursor.fetchall()
        print(f"\n=====================================")
        print(f"Table: {table} (Row Count: {count})")
        print(f"=====================================")
        for col in cols:
            print(f"  - {col[1]} ({col[2]})")
            
    conn.close()

if __name__ == '__main__':
    main()
