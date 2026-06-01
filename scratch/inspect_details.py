import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    tables_to_inspect = ['orgs', 'apps', 'roles', 'screens']
    
    for t_name in tables_to_inspect:
        print(f"\n==================================================")
        print(f"Table: {t_name}")
        print(f"==================================================")
        
        # Columns
        cursor.execute(f"PRAGMA table_info({t_name})")
        cols = cursor.fetchall()
        print("Columns:")
        for col in cols:
            print(f"  - {col['name']} ({col['type']})")
            
        # Count
        cursor.execute(f"SELECT COUNT(*) FROM {t_name}")
        count = cursor.fetchone()[0]
        print(f"Total Rows: {count}")
        
        # Sample
        cursor.execute(f"SELECT * FROM {t_name} LIMIT 2")
        rows = cursor.fetchall()
        print("Sample Data:")
        for i, row in enumerate(rows):
            print(f"  Row {i+1}:")
            for col in row.keys():
                print(f"    {col}: {row[col]}")
                
    conn.close()

if __name__ == '__main__':
    main()
