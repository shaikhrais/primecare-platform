import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def verify():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';")
    tables = [r[0] for r in cursor.fetchall()]
    
    cursor.execute("SELECT name FROM sqlite_master WHERE type='view';")
    views = [r[0] for r in cursor.fetchall()]
    
    print(f"Total Tables ({len(tables)}): {sorted(tables)}")
    print(f"Total Views ({len(views)}): {sorted(views)}")
    
    # Check rows count in screens
    cursor.execute("SELECT COUNT(*) FROM screens;")
    screens_cnt = cursor.fetchone()[0]
    print(f"Screens Count: {screens_cnt}")
    
    # Check one screen record
    cursor.execute("SELECT * FROM screens LIMIT 1;")
    col_names = [description[0] for description in cursor.description]
    print(f"Screens columns: {col_names}")
    
    conn.close()

if __name__ == '__main__':
    verify()
