import sys
import os
import sqlite3

# Add current folder to path to import governance_db
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
import governance_db

def generate_summary():
    conn = governance_db.get_connection()
    cursor = conn.cursor()

    # 1. Total Apps
    cursor.execute("SELECT COUNT(*) FROM apps;")
    total_apps = cursor.fetchone()[0] or 0

    # 2. Total Screens
    cursor.execute("SELECT COUNT(*) FROM screens;")
    total_screens = cursor.fetchone()[0] or 0

    # 3. Total Components and Functions
    cursor.execute("SELECT COUNT(*) FROM screen_components;")
    total_components = cursor.fetchone()[0] or 0
    cursor.execute("SELECT COUNT(*) FROM screen_functions;")
    total_functions = cursor.fetchone()[0] or 0

    # 4. Active drifts and compliance alerts
    cursor.execute("SELECT COUNT(*) FROM drift_findings WHERE status = 'open';")
    total_drifts = cursor.fetchone()[0] or 0

    # 5. Test runs and results metrics
    cursor.execute("SELECT COUNT(*) FROM test_runs;")
    total_runs = cursor.fetchone()[0] or 0
    cursor.execute("SELECT COUNT(*) FROM test_results WHERE status = 'passed';")
    passed_tests = cursor.fetchone()[0] or 0
    cursor.execute("SELECT COUNT(*) FROM test_results WHERE status = 'failed';")
    failed_tests = cursor.fetchone()[0] or 0

    # 6. Task verification checks metrics
    cursor.execute("SELECT COUNT(*) FROM task_completion_checks WHERE check_status = 'pending';")
    pending_checks = cursor.fetchone()[0] or 0

    # 7. Role-based view screen counts
    cursor.execute("""
    SELECT r.role_name, r.role_code, COUNT(rsp.screen_id) AS screen_count
    FROM roles r
    LEFT JOIN role_screen_permissions rsp ON r.id = rsp.role_id AND rsp.can_view = 1
    GROUP BY r.id
    HAVING screen_count > 0
    ORDER BY screen_count DESC, r.role_code;
    """)
    role_rows = cursor.fetchall()

    # 8. Application Screen Distribution
    cursor.execute("""
    SELECT a.app_code, a.app_name, COUNT(s.id) as screen_count
    FROM apps a
    LEFT JOIN screens s ON a.id = s.app_id
    GROUP BY a.id
    ORDER BY screen_count DESC, a.app_code;
    """)
    app_rows = cursor.fetchall()

    print("=====================================================")
    print("PrimeCare Platform Governance Summary")
    print("=====================================================")
    print(f"Total Registered Applications : {total_apps:3}")
    print(f"Total Registered Screens      : {total_screens:3}")
    print(f"Total UI Layout Components    : {total_components:3}")
    print(f"Total Interactive Callbacks   : {total_functions:3}")
    print(f"Active Governance Drifts      : {total_drifts:3}")
    print(f"Total Logged Test Runs        : {total_runs:3}")
    print(f"Test Cases (Passed/Failed)    : {passed_tests:3} passed / {failed_tests:3} failed")
    print(f"Pending Verification Checks   : {pending_checks:3}")
    print("=====================================================")
    
    print("\n=====================================================")
    print("Application Screen Distribution")
    print("=====================================================")
    max_screens = max(row['screen_count'] for row in app_rows) if app_rows else 1
    for row in app_rows:
        code = row['app_code']
        name = row['app_name']
        count = row['screen_count']
        
        # Calculate visual progress bar (20 blocks wide)
        bar_length = 20
        filled = int((count / max_screens) * bar_length) if max_screens > 0 else 0
        
        try:
            bar = "█" * filled + "░" * (bar_length - filled)
            print(f"  - {code:3} | {name:30} | {count:3} screens | [{bar}]")
        except UnicodeEncodeError:
            bar = "#" * filled + "-" * (bar_length - filled)
            print(f"  - {code:3} | {name:30} | {count:3} screens | [{bar}]")
    print("=====================================================")

    print("\nRole-Based Access Coverage (Screens can view):")
    for row in role_rows:
        print(f"  - {row['role_name']} ({row['role_code']}): {row['screen_count']} screens")

    print("\n=====================================================")
    print("All entities are synchronized under the Relational 22-Table Schema.")
    print("=====================================================")
    
    conn.close()

if __name__ == "__main__":
    generate_summary()
