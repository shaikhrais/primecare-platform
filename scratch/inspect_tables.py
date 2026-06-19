import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    # 1. Print role_screen_permissions create statement
    cursor.execute("SELECT sql FROM sqlite_master WHERE type='table' AND name='role_screen_permissions';")
    print("role_screen_permissions Schema:")
    print(cursor.fetchone()[0])
    
    # 2. Print foreign key list
    cursor.execute("PRAGMA foreign_key_list(role_screen_permissions);")
    print("\nForeign Keys:")
    for fk in cursor.fetchall():
        print(fk)
        
    conn.close()

if __name__ == '__main__':
    main()
