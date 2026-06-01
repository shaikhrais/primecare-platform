import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    cursor.execute("""
        SELECT screen_code, screen_name, status, actual_file_path, missing_selectors
        FROM screen_e2e_compliance_tracker
        WHERE status != 'aligned'
        ORDER BY status, screen_code;
    """)
    rows = cursor.fetchall()
    print(f"FOUND {len(rows)} NON-ALIGNED SCREENS IN REGISTRY:")
    for r in rows:
        print(f"Screen: {r['screen_code']} | Status: {r['status']}")
        print(f"  File:   {r['actual_file_path']}")
        print(f"  Missed: {r['missing_selectors']}")
        print("-" * 60)
        
    conn.close()

if __name__ == '__main__':
    main()
