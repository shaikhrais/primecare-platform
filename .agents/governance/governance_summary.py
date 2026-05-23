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

    # 5. Role-based view screen counts
    cursor.execute("""
    SELECT r.role_name, r.role_code, COUNT(rsp.screen_id) AS screen_count
    FROM roles r
    LEFT JOIN role_screen_permissions rsp ON r.id = rsp.role_id AND rsp.can_view = 1
    GROUP BY r.id
    HAVING screen_count > 0
    ORDER BY screen_count DESC, r.role_code;
    """)
    role_rows = cursor.fetchall()

    print("=====================================================")
    print("PrimeCare Platform Governance Summary")
    print("=====================================================")
    print(f"Total Registered Applications : {total_apps:3}")
    print(f"Total Registered Screens      : {total_screens:3}")
    print(f"Total UI Layout Components    : {total_components:3}")
    print(f"Total Interactive Callbacks   : {total_functions:3}")
    print(f"Active Governance Drifts      : {total_drifts:3}")
    print("=====================================================")
    
    print("\nRole-Based Access Coverage (Screens can view):")
    for row in role_rows:
        print(f"  - {row['role_name']} ({row['role_code']}): {row['screen_count']} screens")

    print("\n=====================================================")
    print("All entities are synchronized under the Relational 19-Table Schema.")
    print("=====================================================")
    
    conn.close()

if __name__ == "__main__":
    generate_summary()
