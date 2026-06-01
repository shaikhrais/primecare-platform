import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    # Check screens app mapping
    cursor.execute("""
        SELECT a.app_name, COUNT(s.id) 
        FROM screens s 
        LEFT JOIN apps a ON s.app_id = a.id 
        GROUP BY s.app_id
    """)
    print("=== Screens per Application ===")
    for r in cursor.fetchall():
        print(f"  {r[0] or 'No App'}: {r[1]} screens")
        
    # Check screens role mapping
    cursor.execute("""
        SELECT r.role_name, COUNT(s.id) 
        FROM screens s 
        LEFT JOIN roles r ON s.role_id = r.id 
        GROUP BY s.role_id
    """)
    print("\n=== Screens per Role (Top 10) ===")
    for r in cursor.fetchall()[:10]:
        print(f"  {r[0] or 'No Role'}: {r[1]} screens")
        
    conn.close()

if __name__ == '__main__':
    main()
