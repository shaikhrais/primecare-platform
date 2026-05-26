import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    print("--- SCREENS WITH UNVERIFIED LAYOUT REUSE ---")
    cursor.execute("""
        SELECT count(*) as unverified_count FROM screens
        WHERE layout_reuse_status != 'verified'
           OR shell_layout_key IS NULL OR shell_layout_key = ''
           OR content_slot_key IS NULL OR content_slot_key = ''
           OR content_only_navigation_verified = 0;
    """)
    print("Unverified Count:", cursor.fetchone()["unverified_count"])
    
    print("\n--- GOVERNANCE_FUNCTION_RESULTS ROW COUNT ---")
    cursor.execute("SELECT count(*) as total_count FROM governance_function_results")
    print("Total Rows:", cursor.fetchone()["total_count"])
    
    print("\n--- GOVERNANCE_FUNCTION_RESULTS GROUPED BY TARGET_TABLE ---")
    cursor.execute("SELECT target_table, count(*) as count FROM governance_function_results GROUP BY target_table")
    for r in cursor.fetchall():
        print(f"Table: {r['target_table']} | Count: {r['count']}")
        
    print("\n--- GOVERNANCE_FUNCTION_RESULTS GROUPED BY FUNCTION ---")
    cursor.execute("""
        SELECT f.function_code, count(r.id) as count 
        FROM governance_functions f
        LEFT JOIN governance_function_results r ON f.id = r.function_id
        GROUP BY f.function_code
    """)
    for r in cursor.fetchall():
        print(f"Function: {r['function_code']} | Results Count: {r['count']}")
        
    conn.close()

if __name__ == '__main__':
    main()
