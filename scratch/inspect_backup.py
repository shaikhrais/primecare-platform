import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db.pre_import_backup")

def main():
    if not os.path.exists(DB_PATH):
        print("Backup database does not exist!")
        return
        
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    cursor.execute("SELECT COUNT(*) FROM screens")
    print(f"Total screens in backup: {cursor.fetchone()[0]}")
    
    cursor.execute("SELECT screen_type, COUNT(*) FROM screens GROUP BY screen_type")
    print("Screen type counts in backup:")
    for row in cursor.fetchall():
        print(f"  {row[0]}: {row[1]}")
        
    cursor.execute("SELECT screen_code, screen_type, route_path FROM screens WHERE screen_type = 'dashboard' LIMIT 10")
    print("Some dashboard screens in backup:")
    for row in cursor.fetchall():
        print(dict(row))
        
    conn.close()

if __name__ == '__main__':
    main()
