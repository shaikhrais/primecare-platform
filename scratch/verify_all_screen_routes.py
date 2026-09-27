import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("==============================================================")
    print("VERIFYING ROUTE COMPLETENESS ACROSS ALL CLINIC PORTAL SCREENS")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    # Query all screens
    cursor.execute("""
        SELECT s.id, s.screen_code, s.screen_name, s.route_path, a.app_name, r.role_code, r.role_name
        FROM screens s
        LEFT JOIN apps a ON s.app_id = a.id
        LEFT JOIN roles r ON s.role_id = r.id
    """)
    screens = cursor.fetchall()
    
    total_screens = len(screens)
    role_missing = []
    general_missing = []
    valid_routes = 0

    for s in screens:
        route = s["route_path"]
        code = s["screen_code"]
        name = s["screen_name"]
        app = s["app_name"] or "Unknown App"
        role_name = s["role_name"]
        role_code = s["role_code"]

        if not route or route.strip() == "" or route.lower() == "null":
            if role_code:
                role_missing.append((code, name, app, role_name, role_code))
            else:
                general_missing.append((code, name, app))
        else:
            valid_routes += 1

    print(f"Total Screens Checked: {total_screens}")
    print(f"Screens with Valid Routes: {valid_routes} ({valid_routes/total_screens*100:.1f}%)")
    print(f"Role-assigned Screens with Missing Routes: {len(role_missing)}")
    print(f"General/Unassigned Screens with Missing Routes: {len(general_missing)}")

    if role_missing:
        print("\n--- ROLE-SPECIFIC SCREENS WITH MISSING ROUTES (CRITICAL!) ---")
        for i, (code, name, app, role_name, role_code) in enumerate(role_missing, 1):
            print(f"{i}. [{app} | {role_name} ({role_code})] Code: '{code}' | Name: '{name}'")
    else:
        print("\n[SUCCESS] All role-specific screens have valid routes!")

    conn.close()

if __name__ == "__main__":
    main()
