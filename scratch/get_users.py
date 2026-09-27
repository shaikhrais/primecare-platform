import os
import sqlite3

DB_PATH = os.path.join(".agents", "governance", "governance.db")

def main():
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return
        
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
    tables = [row['name'] for row in cursor.fetchall()]
    
    # Check if we have user or seed tables
    user_tables = [t for t in tables if 'user' in t or 'seed' in t or 'role_test' in t]
    print(f"Found related tables: {user_tables}")
    
    for t in user_tables:
        print(f"\n--- Table: {t} ---")
        cursor.execute(f"PRAGMA table_info({t});")
        cols = [row['name'] for row in cursor.fetchall()]
        print(f"Columns: {', '.join(cols)}")
        
        try:
            cursor.execute(f"SELECT * FROM {t} LIMIT 10;")
            rows = cursor.fetchall()
            for r in rows:
                print(dict(r))
        except Exception as e:
            print(f"Error reading {t}: {e}")
            
    conn.close()

if __name__ == '__main__':
    main()
