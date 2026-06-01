import sqlite3
import os
import json

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    # Get chiropractor role
    cursor.execute("SELECT * FROM roles WHERE role_code = 'chiropractor'")
    chiro_role = cursor.fetchone()
    if not chiro_role:
        print("Chiropractor role not found in DB!")
        return

    print("=== Chiropractor Role Info ===")
    for key in chiro_role.keys():
        print(f"{key}: {chiro_role[key]}")

    # Get chiropractor screens
    print("\n=== Chiropractor Screens ===")
    cursor.execute("SELECT * FROM screens WHERE role_id = ?", (chiro_role['id'],))
    screens = cursor.fetchall()
    print(f"Total Screens: {len(screens)}")
    if screens:
        print("Columns:", list(screens[0].keys()))
    for s in screens:
        sd = dict(s)
        print(f"Screen: {sd['screen_code']} | Route: {sd['route_path']} | Layout Reuse: {sd['layout_reuse_status']} | Nav Verified: {sd.get('content_only_navigation_verified')}")

    # Check test_users.json
    fixture_path = os.path.join(PROJECT_ROOT, "cypress", "fixtures", "governance", "test_users.json")
    if os.path.exists(fixture_path):
        with open(fixture_path, 'r') as f:
            users = json.load(f)
        chiro_user = next((u for u in users if u['role_code'] == 'chiropractor'), None)
        print("\n=== test_users.json Chiropractor entry ===")
        if chiro_user:
            print(json.dumps(chiro_user, indent=2))
        else:
            print("Chiropractor user not found in test_users.json!")

    conn.close()

if __name__ == '__main__':
    main()
