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
        # 2. Filter to keep only psw_documents_runtime
        single_test = [t for t in master_fixture["tests"] if t["test_code"] == "psw_documents_runtime"]
        if not single_test:
            print("Error: psw_documents_runtime not found in fixture!")
            return

        filtered_data = {"tests": single_test}
        
        # Write back the filtered JSON
        with open(FIXTURE_PATH, "w", encoding="utf-8") as f:
            json.dump(filtered_data, f, indent=2)
        print("Filtered cypress fixture to run ONLY: psw_documents_runtime")

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
        print("Executing Cypress test for PSW Documents...")
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

        # 5. Copy the screenshot
        if os.path.exists(SCREENSHOT_DIR):
            for root, dirs, files in os.walk(SCREENSHOT_DIR):
                for file in files:
                    if file.endswith(".png"):
                        src_path = os.path.join(root, file)
                        dest_path = os.path.join(DEST_DIR, "psw_documents.png")
                        try:
                            shutil.copy(src_path, dest_path)
                            print(f"Copied test screenshot to: {dest_path}")
                        except Exception as e:
                            print(f"Error copying {src_path}: {e}")
    finally:
        # Restore the full master fixture back to screen-tests.json
        with open(FIXTURE_PATH, "w", encoding="utf-8") as f:
            json.dump(master_fixture, f, indent=2)

if __name__ == "__main__":
    main()
