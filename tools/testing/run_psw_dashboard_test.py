import json
import os
import subprocess
import shutil

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
FIXTURE_PATH = os.path.join(PROJECT_ROOT, "cypress", "fixtures", "generated", "screen-tests.json")
SCREENSHOT_DIR = os.path.join(PROJECT_ROOT, "cypress", "screenshots", "db-screen-tests.cy.ts")
DEST_DIR = r"C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1"

def main():
    print("==============================================================")
    # 1. Read the exported JSON
    with open(FIXTURE_PATH, "r", encoding="utf-8") as f:
        master_fixture = json.load(f)

    try:
        # 2. Filter to keep only psw_dashboard_runtime
        single_test = [t for t in master_fixture["tests"] if t["test_code"] == "psw_dashboard_runtime"]
        if not single_test:
            print("Error: psw_dashboard_runtime not found in fixture!")
            return

        filtered_data = {"tests": single_test}
        
        # Write back the filtered JSON
        with open(FIXTURE_PATH, "w", encoding="utf-8") as f:
            json.dump(filtered_data, f, indent=2)
        print("Filtered cypress fixture to run ONLY: psw_dashboard_runtime")

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
        print("Executing Cypress test for PSW Dashboard...")
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

        # 5. Look for generated screenshots recursively
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
        print(f"Latest screenshot found: {latest_screenshot}")
        
        if latest_screenshot:
            dest_path = os.path.join(DEST_DIR, "psw_dashboard.png")
            shutil.copy(latest_screenshot, dest_path)
            print(f"Copied test screenshot to: {dest_path}")
        else:
            print("Warning: No screenshot was found!")
    finally:
        # Restore the full master fixture back to screen-tests.json
        with open(FIXTURE_PATH, "w", encoding="utf-8") as f:
            json.dump(master_fixture, f, indent=2)

if __name__ == "__main__":
    main()
