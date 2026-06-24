import sqlite3
import os

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

if not os.path.exists(db_path):
    print("Database not found at:", db_path)
    exit(1)

conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# Check if already exists
cursor.execute("SELECT id FROM screens WHERE screen_name = 'ScreenProgressDashboardScreen'")
row = cursor.fetchone()

if not row:
    cursor.execute("""
        INSERT INTO screens (
            app_id, screen_code, screen_name, route_path, is_route_active, actual_file_path, allowed_roles_text,
            design_stage, html_stage, component_stage, logic_stage, api_stage, db_stage, validation_stage, qa_stage, final_stage, progress_percent, blocker, next_action
        ) VALUES (
            5, 'screen_progress_dashboard', 'ScreenProgressDashboardScreen', '/management/screen-progress-dashboard', 1, 'packages/primecare_ui/lib/src/screens/management/screen_progress_dashboard.dart', 'ROLE_ADMIN,compliance',
            'DESIGN_APPROVED', 'HTML_RESPONSIVE_DONE', 'COMP_FINAL', 'LOGIC_CLEAN', 'API_ERROR_HANDLED', 'DB_FULLY_CONNECTED', 'VALIDATION_FULL', 'QA_PASSED', 'FINAL_FURNISHED', 100, '', ''
        )
    """)
    conn.commit()
    print("ScreenProgressDashboardScreen inserted into screens table successfully.")
else:
    print("ScreenProgressDashboardScreen already exists in database.")

conn.close()
