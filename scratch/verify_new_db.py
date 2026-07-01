import sqlite3
import os

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    print("==============================================================")
    print("VERIFYING NEW REFACTORED DATABASE SCHEMA AND COUNTS")
    print("==============================================================")

    # 1. Query row counts for all 15 new tables
    tables = [
        "apps", "roles", "screens", "ui_components", "apis", "role_screen_map", 
        "screen_component_map", "screen_api_map", "screen_requirements", 
        "screen_required_elements", "development_tasks", "screen_verification", 
        "cypress_results", "screen_issues", "auth_tests"
    ]
    for t in tables:
        c.execute(f"SELECT COUNT(*) FROM [{t}]")
        count = c.fetchone()[0]
        print(f"Table '{t}': {count} rows")

    # 2. Check stub screens
    print("\nChecking stub screens stage and Cypress status:")
    c.execute("SELECT id, screen_code, stage FROM screens WHERE stage = 'coded'")
    stubs = c.fetchall()
    print(f"  Total stub screens (coded stage): {len(stubs)}")
    
    # 3. Check screen verification
    c.execute("SELECT COUNT(*) FROM screen_verification")
    ver_count = c.fetchone()[0]
    print(f"  Total verified screens: {ver_count}")

    # 4. Check screen issues
    c.execute("SELECT issue_type, COUNT(*) FROM screen_issues GROUP BY issue_type")
    issues = c.fetchall()
    print("\nActive screen issues:")
    for iss in issues:
        print(f"  - {iss[0]}: {iss[1]} issues")

    conn.close()

if __name__ == "__main__":
    main()
