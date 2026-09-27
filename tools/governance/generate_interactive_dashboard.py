import sqlite3
import os
import json
from datetime import datetime

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
TEMPLATE_PATH = os.path.join(PROJECT_ROOT, "tools", "governance", "reports", "interactive_governance_dashboard.html")
OUTPUT_PATH = os.path.join(PROJECT_ROOT, "tools", "governance", "reports", "interactive_governance_dashboard.html")

def main():
    print("🚀 Initiating Interactive Governance Dashboard Compilation...")

    if not os.path.exists(DB_PATH):
        print(f"[ERROR] Database not found at: {DB_PATH}")
        return

    if not os.path.exists(TEMPLATE_PATH):
        print(f"[ERROR] Template dashboard file not found at: {TEMPLATE_PATH}")
        return

    # 1. Fetch data from SQLite
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    try:
        # Orgs
        cursor.execute("SELECT id, org_code, org_name FROM orgs")
        orgs = [dict(r) for r in cursor.fetchall()]

        # Apps
        cursor.execute("SELECT id, org_id, app_code, app_name FROM apps")
        apps = [dict(r) for r in cursor.fetchall()]

        # Roles
        cursor.execute("""
            SELECT id, org_id, role_code, role_name, test_email, 
                   test_login_verified, test_login_last_status, test_login_last_run_at, 
                   auth_screenshot_path, auth_video_path, primary_app_code 
            FROM roles
        """)
        roles = [dict(r) for r in cursor.fetchall()]

        # Screens with joined App/Role details
        cursor.execute("""
            SELECT s.id, s.app_id, s.role_id, s.screen_code, s.screen_name, s.route_path, 
                   s.cypress_ready, s.cypress_ready_status, s.screenshot_path, s.video_recording_path, 
                   s.when_tested, s.is_valid, s.complexity_score, s.estimated_loc, s.maintainability_score,
                   s.user_remarks, s.user_remark_status, s.required_components_json, s.actual_components_json,
                   s.actual_file_path, s.allowed_roles_text, s.supports_mobile, s.supports_tablet
            FROM screens s
        """)
        screens = [dict(r) for r in cursor.fetchall()]

        print(f"  [DB READ] Loaded {len(orgs)} organizations.")
        print(f"  [DB READ] Loaded {len(apps)} applications.")
        print(f"  [DB READ] Loaded {len(roles)} user roles.")
        print(f"  [DB READ] Loaded {len(screens)} screens registry records.")

    except Exception as e:
        print(f"[ERROR] Failed to query database: {e}")
        conn.close()
        return

    # Create compiled offline JSON
    offline_db = {
        "orgs": orgs,
        "apps": apps,
        "roles": roles,
        "screens": screens
    }

    # 2. Read template file
    with open(TEMPLATE_PATH, "r", encoding="utf-8") as f:
        html_content = f.read()

    # 3. Replace the placeholder const OFFLINE_DB block with our live SQL contents
    # We will locate the line `const OFFLINE_DB = { ... };` and replace it
    target_start = "const OFFLINE_DB = {"
    target_end = "};"
    
    start_idx = html_content.find(target_start)
    if start_idx == -1:
        print("[ERROR] Could not find 'const OFFLINE_DB' block in template dashboard file!")
        conn.close()
        return

    # Find the matching closing bracket + semicolon
    end_idx = html_content.find(target_end, start_idx)
    if end_idx == -1:
        print("[ERROR] Could not find the closing semicolon for OFFLINE_DB block!")
        conn.close()
        return

    # Format our data as beautiful formatted JSON
    serialized_data = json.dumps(offline_db, indent=4)
    
    # Surgical injection of the new JSON block
    new_html_content = html_content[:start_idx] + "const OFFLINE_DB = " + serialized_data + html_content[end_idx + 1:]

    # 4. Save compiled file
    with open(OUTPUT_PATH, "w", encoding="utf-8") as f:
        f.write(new_html_content)
    print(f"✨ Successfully compiled offline database into dashboard HTML!")
    print(f"  Report saved to: {OUTPUT_PATH}")

    # 5. Insert audit log into SQLite (correct signature)
    try:
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS governance_reports (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                html_report_path TEXT NOT NULL,
                report_type TEXT NOT NULL,
                created_at TEXT DEFAULT CURRENT_TIMESTAMP
            );
        """)
        
        now_str = datetime.now().isoformat()
        cursor.execute("""
            INSERT INTO governance_reports (app_id, report_name, html_report_path, report_type, created_at)
            VALUES (10, 'PrimeCare Visual Governance & Quality Dashboard', ?, 'interactive_governance_dashboard', ?);
        """, (OUTPUT_PATH, now_str))
        
        conn.commit()
        print("✨ Registered report generation event in SQL governance logs!")
    except Exception as e:
        print(f"[WARN] Failed to write report log to governance_reports table: {e}")

    conn.close()
    print("🏁 Interactive Dashboard Generation Loop Completed successfully!")

if __name__ == '__main__':
    main()
