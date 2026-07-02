import json
import os
import subprocess
import shutil

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
FIXTURE_PATH = os.path.join(PROJECT_ROOT, "cypress", "fixtures", "generated", "screen-tests.json")
SCREENSHOT_DIR = os.path.join(PROJECT_ROOT, "cypress", "screenshots", "db-screen-tests.cy.ts")
DEST_DIR = r"C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1"

# The 18 test codes for PSW role
PSW_TEST_CODES = [
    "psw_dashboard_runtime",
    "psw_analytics_runtime",
    "psw_clients_runtime",
    "psw_compliance_runtime",
    "psw_messages_runtime",
    "psw_shift_tracker_runtime",
    "psw_tasks_runtime",
    "psw_visit_notes_runtime",
    "psw_workflow_runtime",
    "psw_command_center_runtime",
    "psw_my_shifts_runtime",
    "psw_client_profile_runtime",
    "psw_vitals_log_runtime",
    "psw_incident_report_runtime",
    "psw_care_plan_runtime",
    "psw_documents_runtime",
    "shift_tasks_runtime",
    "vitals_entry_runtime"
]

def main():
    print("==============================================================")
    # 1. Read the exported JSON
    with open(FIXTURE_PATH, "r", encoding="utf-8") as f:
        master_fixture = json.load(f)

    try:
        # 2. Filter to keep only PSW tests
        psw_tests = [t for t in master_fixture["tests"] if t["test_code"] in PSW_TEST_CODES]
        if not psw_tests:
            print("Error: No PSW tests found in fixture!")
            return

        filtered_data = {"tests": psw_tests}
        
        # Write back the filtered JSON
        with open(FIXTURE_PATH, "w", encoding="utf-8") as f:
            json.dump(filtered_data, f, indent=2)
        print(f"Filtered cypress fixture to run ONLY: {len(psw_tests)} PSW tests")

        # 3. Clean old screenshots
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

        # 4. Run Cypress E2E spec
        print("Executing Cypress tests for PSW role screens...")
        env = os.environ.copy()
        env["CYPRESS_BASE_URL"] = "https://primecare-auth.pages.dev"
        result = subprocess.run(
            ["npx", "cypress", "run", "--spec", "cypress/e2e/generated/db-screen-tests.cy.ts"],
            cwd=PROJECT_ROOT,
            env=env,
            shell=True,
            capture_output=True,
            text=True,
            encoding="utf-8",
            errors="replace"
        )
        
        print(result.stdout.encode('ascii', errors='replace').decode('ascii'))
        print(result.stderr.encode('ascii', errors='replace').decode('ascii'))

        # 5. Copy all generated screenshots to the destination directory
        print("Copying screenshots...")
        if os.path.exists(SCREENSHOT_DIR):
            for root, dirs, files in os.walk(SCREENSHOT_DIR):
                for file in files:
                    if file.endswith(".png"):
                        src_path = os.path.join(root, file)
                        dest_path = os.path.join(DEST_DIR, file)
                        try:
                            shutil.copy(src_path, dest_path)
                            print(f"Copied screenshot to: {dest_path}")
                        except Exception as e:
                            print(f"Error copying {src_path}: {e}")
    finally:
        # Restore the full master fixture back to screen-tests.json
        with open(FIXTURE_PATH, "w", encoding="utf-8") as f:
            json.dump(master_fixture, f, indent=2)

if __name__ == "__main__":
    main()
