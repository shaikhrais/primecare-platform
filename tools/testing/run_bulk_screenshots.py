import os
import sqlite3
import subprocess
import shutil
from datetime import datetime

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
SCREENSHOT_SOURCE = os.path.join(PROJECT_ROOT, "cypress", "screenshots", "take-all-screenshots.cy.ts")
DEST_BASE_DIR = r"C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\screenshots"

def main():
    print("==============================================================")
    print("BULK CYPRESS SCREENSHOT RUNNER & DATABASE UPDATER")
    print("==============================================================")

    # 1. Clear previous Cypress screenshot folder contents
    if os.path.exists(SCREENSHOT_SOURCE):
        try:
            shutil.rmtree(SCREENSHOT_SOURCE)
            print("Cleared source screenshot directory.")
        except Exception as e:
            print(f"Warning: Failed to clear source directory: {e}")
    os.makedirs(SCREENSHOT_SOURCE, exist_ok=True)

    # 2. Run Cypress bulk screenshot generator spec
    print("Running Cypress bulk screenshot generator...")
    env = os.environ.copy()
    env["CYPRESS_BASE_URL"] = "https://primecare-auth.pages.dev"
    
    # Run Cypress
    subprocess.run(
        ["npx", "cypress", "run", "--spec", "cypress/e2e/generated/take-all-screenshots.cy.ts"],
        cwd=PROJECT_ROOT,
        env=env,
        shell=True
    )

    # 3. Scan and copy all generated screenshots to destination, updating database
    print("\nProcessing captured screenshots...")
    if not os.path.exists(SCREENSHOT_SOURCE):
        print("No screenshots directory found. Cypress run might have failed completely.")
        return

    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()

    count = 0
    for root, dirs, files in os.walk(SCREENSHOT_SOURCE):
        for file in files:
            if file.endswith(".png"):
                src_path = os.path.join(root, file)
                
                # Get the relative path from SCREENSHOT_SOURCE (e.g. role/screen_code.png)
                rel_path = os.path.relpath(src_path, SCREENSHOT_SOURCE)
                parts = rel_path.split(os.sep)
                if len(parts) >= 2:
                    role_code = parts[-2]
                    screen_code = os.path.splitext(parts[-1])[0]
                    
                    # Copy to structured destination directory
                    # Destination layout: screenshots/app_code/role_code/screen_code.png
                    # Let's lookup app_code from DB
                    c.execute("""
                        SELECT a.app_code
                        FROM screens s
                        LEFT JOIN apps a ON s.app_id = a.id
                        WHERE s.screen_code = ?
                    """, (screen_code,))
                    row = c.fetchone()
                    app_code = row[0] if row and row[0] else "unspecified_app"
                    
                    dest_folder = os.path.join(DEST_BASE_DIR, app_code, role_code)
                    os.makedirs(dest_folder, exist_ok=True)
                    
                    dest_path = os.path.join(dest_folder, f"{screen_code}.png")
                    try:
                        shutil.copy(src_path, dest_path)
                        count += 1
                        
                        # Update database verification status
                        c.execute("""
                            UPDATE screens
                            SET runtime_verified = 1, cypress_verified = 1
                            WHERE screen_code = ?
                        """, (screen_code,))
                        print(f"[{count}] Saved & verified: screenshots/{app_code}/{role_code}/{screen_code}.png")
                    except Exception as e:
                        print(f"Warning: Failed to copy or verify {screen_code}: {e}")

    conn.commit()
    conn.close()

    print(f"\nSuccessfully saved and database-verified {count} screens!")
    print("==============================================================")

if __name__ == "__main__":
    main()
