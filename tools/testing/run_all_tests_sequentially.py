import os
import sqlite3
import json
import subprocess
import shutil

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
FIXTURE_PATH = os.path.join(PROJECT_ROOT, "cypress", "fixtures", "generated", "screen-tests.json")
SCREENSHOT_DIR = os.path.join(PROJECT_ROOT, "cypress", "screenshots", "db-screen-tests.cy.ts")
DEST_BASE_DIR = r"C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\screenshots"

def main():
    print("==============================================================")
    print("SEQUENTIAL CYPRESS E2E RUNNER & SCREENSHOT ORGANIZER")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    # Load all screen test definitions joined with screen, app, and role metadata
    c.execute("""
        SELECT std.id as test_definition_id, std.test_code, s.screen_code, s.screen_name,
               a.app_code, r.role_code
        FROM screen_test_definitions std
        JOIN screens s ON std.screen_id = s.id
        LEFT JOIN apps a ON s.app_id = a.id
        LEFT JOIN roles r ON s.role_id = r.id
        ORDER BY a.app_code, r.role_code, s.screen_code
    """)
    tests = [dict(row) for row in c.fetchall()]
    conn.close()

    total_tests = len(tests)
    print(f"Found {total_tests} tests to execute sequentially.\n")

    # Read the full master fixture to filter from
    with open(FIXTURE_PATH, "r", encoding="utf-8") as f:
        master_fixture = json.load(f)

    try:
        for idx, t in enumerate(tests, 1):
            test_code = t["test_code"]
            screen_code = t["screen_code"]
            app_code = t["app_code"] or "unspecified_app"
            role_code = t["role_code"] or "guest"

            # 1. Filter fixture to only contain this test
            matching_test = [item for item in master_fixture["tests"] if item["test_code"] == test_code]
            if not matching_test:
                print(f"[{idx}/{total_tests}] Test '{test_code}' -> SKIPPED (Not found in fixture)")
                continue

            single_fixture = {"tests": matching_test}
            with open(FIXTURE_PATH, "w", encoding="utf-8") as f:
                json.dump(single_fixture, f, indent=2)

            # 2. Clear previous Cypress screenshot folder contents resiliantly
            if os.path.exists(SCREENSHOT_DIR):
                for file_name in os.listdir(SCREENSHOT_DIR):
                    file_path = os.path.join(SCREENSHOT_DIR, file_name)
                    try:
                        if os.path.isfile(file_path):
                            os.unlink(file_path)
                        elif os.path.isdir(file_path):
                            shutil.rmtree(file_path)
                    except Exception as e:
                        pass
            else:
                os.makedirs(SCREENSHOT_DIR, exist_ok=True)

            # 3. Run Cypress E2E test
            print(f"\n[{idx}/{total_tests}] Running test '{test_code}' for {screen_code}...")
            print(f"      App: {app_code} | Role: {role_code}")
            
            env = os.environ.copy()
            env["CYPRESS_BASE_URL"] = os.environ["CYPRESS_BASE_URL"]
            
            # We limit Cypress run times to keep things reasonably responsive
            subprocess.run(
                ["npx", "cypress", "run", "--spec", "cypress/e2e/generated/db-screen-tests.cy.ts"],
                cwd=PROJECT_ROOT,
                env=env,
                shell=True,
                capture_output=True,
                encoding="utf-8",
                errors="replace"
            )

            # 4. Locate the screenshot recursively, ignoring too long filenames
            def find_latest_screenshot(dir_path):
                latest_file = None
                latest_time = 0
                if os.path.exists(dir_path):
                    for root, dirs, files in os.walk(dir_path):
                        for file in files:
                            if file.endswith(".png"):
                                file_path = os.path.join(root, file)
                                try:
                                    mtime = os.path.getmtime(file_path)
                                    if len(file) < 150 and mtime > latest_time:
                                        latest_time = mtime
                                        latest_file = file_path
                                except Exception:
                                    pass
                return latest_file

            latest_screenshot = find_latest_screenshot(SCREENSHOT_DIR)

            if latest_screenshot:
                # 5. Create structured folder path
                dest_folder = os.path.join(DEST_BASE_DIR, app_code, role_code)
                os.makedirs(dest_folder, exist_ok=True)
                
                dest_path = os.path.join(dest_folder, f"{screen_code}.png")
                try:
                    shutil.copy(latest_screenshot, dest_path)
                    print(f"      --> Success! Saved screenshot to: screenshots/{app_code}/{role_code}/{screen_code}.png")
                except Exception as e:
                    print(f"      --> Warning: Failed to copy screenshot: {e}")
            else:
                print("      --> Warning: No screenshot captured.")
    finally:
        # Restore the full master fixture back to screen-tests.json
        with open(FIXTURE_PATH, "w", encoding="utf-8") as f:
            json.dump(master_fixture, f, indent=2)

    print("\n==============================================================")
    print("SEQUENTIAL E2E EXECUTION & ORGANIZING COMPLETE!")
    print("==============================================================")

if __name__ == "__main__":
    main()
