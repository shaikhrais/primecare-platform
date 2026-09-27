import os
import sqlite3

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    # Find all corporate stubs
    features_dir = os.path.join(PROJECT_ROOT, "apps", "primecare_corporate", "lib", "features")
    stubs = []
    for root, dirs, files in os.walk(features_dir):
        for f in files:
            if f.endswith("_screen.dart") and not f.endswith("_controller.dart"):
                rel_path = os.path.relpath(os.path.join(root, f), PROJECT_ROOT).replace("\\", "/")
                stubs.append((f, rel_path))

    print(f"Found {len(stubs)} screen files in corporate features:")
    
    # Check if they exist in DB
    mismatched = []
    matched = []
    missing_in_db = []
    
    for f_name, rel_path in stubs:
        # Deduce class name and screen_code
        # e.g., hr_director_dashboard_screen.dart -> HrDirectorDashboardScreen -> hr_director_dashboard
        screen_code = f_name.replace("_screen.dart", "")
        # query by screen_code
        cursor.execute("SELECT id, screen_name, actual_file_path, cypress_ready FROM screens WHERE screen_code = ?;", (screen_code,))
        row = cursor.fetchone()
        if row:
            if row["actual_file_path"] != rel_path:
                mismatched.append({
                    "id": row["id"],
                    "screen_name": row["screen_name"],
                    "screen_code": screen_code,
                    "db_path": row["actual_file_path"],
                    "actual_path": rel_path,
                    "cypress_ready": row["cypress_ready"]
                })
            else:
                matched.append((screen_code, rel_path))
        else:
            missing_in_db.append((screen_code, rel_path))

    print(f"\nMatched: {len(matched)}")
    print(f"Missing in DB: {len(missing_in_db)}")
    for m in missing_in_db:
        print(f"  Code: {m[0]} | Path: {m[1]}")
        
    print(f"\nMismatched path in DB: {len(mismatched)}")
    for m in mismatched:
        print(f"  ID: {m['id']} | Code: {m['screen_code']} | DB Path: {m['db_path']} | Actual Path: {m['actual_path']} | Cypress Ready: {m['cypress_ready']}")
        
    conn.close()

if __name__ == "__main__":
    main()
