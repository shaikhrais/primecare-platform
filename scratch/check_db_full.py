import os
import sqlite3

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    # 1. Total screens
    cursor.execute("SELECT COUNT(*) FROM screens")
    total = cursor.fetchone()[0]
    
    # 2. Valid screens
    cursor.execute("SELECT COUNT(*) FROM screens WHERE is_valid = 1")
    valid = cursor.fetchone()[0]
    
    # 3. Tested screens
    cursor.execute("SELECT COUNT(*) FROM screens WHERE when_tested IS NOT NULL")
    tested = cursor.fetchone()[0]
    
    # 4. Invalid/Failed screens
    cursor.execute("SELECT COUNT(*) FROM screens WHERE is_valid = 0 AND when_tested IS NOT NULL")
    failed = cursor.fetchone()[0]
    
    # 5. Untested screens
    cursor.execute("SELECT COUNT(*) FROM screens WHERE when_tested IS NULL")
    untested = cursor.fetchone()[0]
    
    print("========================================")
    print("      SCREENS GOVERNANCE DATABASE STATUS ")
    print("========================================")
    print(f"Total Screens in Registry:  {total}")
    print(f"Tested Screens:             {tested} ({tested/total*100:.1f}%)")
    print(f"Valid (100% Green) Screens: {valid} ({valid/total*100:.1f}%)")
    print(f"Failed/Invalid Screens:     {failed}")
    print(f"Untested Screens:           {untested}")
    print("========================================")
    
    # Show breakdown by role prefix
    print("\n--- Screen Count Breakdown by Role Code ---")
    cursor.execute("""
        SELECT 
            COALESCE(allowed_roles_text, 'unknown') as role, 
            COUNT(*) as total_count,
            SUM(CASE WHEN when_tested IS NOT NULL THEN 1 ELSE 0 END) as tested_count,
            SUM(CASE WHEN is_valid = 1 THEN 1 ELSE 0 END) as valid_count
        FROM screens
        GROUP BY allowed_roles_text
        ORDER BY total_count DESC;
    """)
    for r in cursor.fetchall():
        print(f"Role: {r[0]:<25} | Total: {r[1]:<3} | Tested: {r[2]:<3} | Valid: {r[3]:<3}")
        
    conn.close()

if __name__ == '__main__':
    main()
