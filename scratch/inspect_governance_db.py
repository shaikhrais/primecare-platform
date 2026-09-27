import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    if not os.path.exists(DB_PATH):
        print(f"Database does not exist at {DB_PATH}")
        return
    print(f"Connecting to database at {DB_PATH}...")
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    # List all tables
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table'")
    tables = cursor.fetchall()
    print("Tables in governance.db:")
    for t in tables:
        print(f"  {t[0]}")
        
    conn.close()

if __name__ == '__main__':
    main()
