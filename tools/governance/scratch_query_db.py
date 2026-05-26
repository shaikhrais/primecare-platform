import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    print("--- APPS WITH BLANK LAYOUT OR BRANDING ---")
    cursor.execute("""
        SELECT count(*) as blank_count FROM apps
        WHERE default_layout_key IS NULL OR default_layout_key = ''
           OR app_shell_type IS NULL OR app_shell_type = ''
           OR theme_config_json IS NULL OR theme_config_json = ''
           OR branding_json IS NULL OR branding_json = '';
    """)
    print("Blank Apps Count:", cursor.fetchone()["blank_count"])
    
    print("\n--- ROLES WITH BLANK LAYOUT OR MENU ---")
    cursor.execute("""
        SELECT count(*) as blank_count FROM roles
        WHERE topbar_config_json IS NULL OR topbar_config_json = ''
           OR sidebar_config_json IS NULL OR sidebar_config_json = ''
           OR default_dashboard_screen_code IS NULL OR default_dashboard_screen_code = ''
           OR allowed_menu_json IS NULL OR allowed_menu_json = ''
           OR role_layout_key IS NULL OR role_layout_key = ''
           OR navigation_style IS NULL OR navigation_style = '';
    """)
    print("Blank Roles Count:", cursor.fetchone()["blank_count"])
    
    print("\n--- SCREENS WITH BLANK LAYOUT ---")
    cursor.execute("""
        SELECT count(*) as blank_count FROM screens
        WHERE content_layout_type IS NULL OR content_layout_type = ''
           OR parent_layout_key IS NULL OR parent_layout_key = ''
           OR menu_label IS NULL OR menu_label = ''
           OR menu_icon IS NULL OR menu_icon = '';
    """)
    print("Blank Screens Count:", cursor.fetchone()["blank_count"])
    
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

