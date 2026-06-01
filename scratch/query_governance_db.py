import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    # Get all tables
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
    tables = [r['name'] for r in cursor.fetchall()]
    print("TABLES IN GOVERNANCE.DB:")
    print(tables)
    
    # Print schema for each table
    for table in tables:
        print(f"\n--- SCHEMA FOR TABLE: {table} ---")
        cursor.execute(f"PRAGMA table_info({table});")
        for col in cursor.fetchall():
            print(f"  Column: {col['name']} ({col['type']})")
            
    conn.close()

if __name__ == '__main__':
    main()
