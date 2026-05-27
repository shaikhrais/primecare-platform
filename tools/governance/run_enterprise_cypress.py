import os
import sys
import time
import subprocess
import sqlite3
from datetime import datetime

DB_PATH = ".agents/governance/governance.db"

def now():
    return datetime.utcnow().isoformat()

def save_result(name, status, output, error=None):
    try:
        conn = sqlite3.connect(DB_PATH)
        cur = conn.cursor()
        cur.execute("DELETE FROM kpi_results WHERE kpi_code = ?;", (name,))
        cur.execute("""
          INSERT INTO kpi_results
          (kpi_code, kpi_name, kpi_value, kpi_status, proof_json, proof_log_path, measured_at)
          VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
        """, (
            name,
            name.replace("_", " ").title(),
            status,
            status,
            output[-2000:],
            "tools/governance/reports/enterprise_cypress.log"
        ))
        conn.commit()
        conn.close()
    except Exception as e:
        print(f"Error saving result to SQLite: {e}")

def create_failure_task(error_message):
    try:
        conn = sqlite3.connect(DB_PATH)
        cur = conn.cursor()
        
        # Get first screen ID to associate, or default to None
        screen_row = cur.execute("SELECT id, app_id FROM screens LIMIT 1;").fetchone()
        screen_id = screen_row[0] if screen_row else 1
        app_id = screen_row[1] if screen_row else 1

        cur.execute("""
            INSERT INTO implementation_tasks (app_id, task_type, related_screen_id, task_title, task_description, status, created_at)
            VALUES (?, 'cypress_test_failure', ?, ?, ?, 'pending', ?);
        """, (
            app_id,
            screen_id,
            "Fix Enterprise Cypress Spec Failure",
            error_message[:1000],
            now()
        ))
        conn.commit()
        conn.close()
        print("  Created implementation task in SQLite.")
    except Exception as e:
        print(f"Error creating failure task in SQLite: {e}")

def main():
    print("==============================================================")
    print("STARTING ENTERPRISE CYPRESS E2E & LOCAL AUTH PIPELINE")
    print("==============================================================")

    # 1. Start Node.js Mock App Server in background
    server_script = os.path.join("tools", "governance", "mock_app_server.js")
    print(f"Launching Mock App Server at http://localhost:3099...")
    
    server_proc = None
    try:
      server_proc = subprocess.Popen(["node", server_script], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, shell=True)
      # Give server a moment to start
      time.sleep(3)
      print("Server process started. Running specs...")
    except Exception as e:
      print(f"[FATAL] Failed to start mock server: {e}")
      sys.exit(1)

    # Define steps
    steps = [
        {
            "name": "generate_cypress_fixtures",
            "cmd": ["python", "tools/governance/generate_cypress_fixtures.py"]
        },
        {
            "name": "auth_login_spec",
            "cmd": ["cypress", "run", "--spec", f"cypress/e2e/generated/auth/auth_{os.environ.get('ROLE_CODE', 'psw').lower()}.cy.js"]
        },
        {
            "name": "language_governance_spec",
            "cmd": ["cypress", "run", "--spec", f"cypress/e2e/generated/language/language_{os.environ.get('ROLE_CODE', 'psw').lower()}.cy.js"]
        },
        {
            "name": "one_role_all_screens_spec",
            "cmd": ["cypress", "run", "--spec", f"cypress/e2e/generated/roles/role_{os.environ.get('ROLE_CODE', 'psw').lower()}_all_screens.cy.js"]
        },
        {
            "name": "one_app_all_roles_spec",
            "cmd": ["cypress", "run", "--spec", "cypress/e2e/generated/apps/*.cy.js"]
        },
        {
            "name": "org_full_e2e_spec",
            "cmd": ["cypress", "run", "--spec", "cypress/e2e/generated/org/org_full_ui.cy.js"]
        },
        {
            "name": "validate_screenshots",
            "cmd": ["python", "tools/governance/validate_screenshots.py"]
        },
        {
            "name": "generate_cypress_visual_dashboard",
            "cmd": ["python", "tools/governance/generate_cypress_visual_dashboard.py"]
        }
    ]

    failed_step = None
    
    # Ensure CYPRESS_BASE_URL is bound to localhost server
    os.environ["CYPRESS_BASE_URL"] = "http://localhost:3099"
    if "ROLE_CODE" not in os.environ:
        os.environ["ROLE_CODE"] = "psw"

    for step in steps:
        name = step["name"]
        cmd = step["cmd"]
        print(f"\n[RUNNING STEP] {name.replace('_', ' ').upper()}...")
        print("Command:", " ".join(cmd))

        # Run process synchronously
        cmd_str = " ".join(cmd) if isinstance(cmd, list) else cmd
        result = subprocess.run(cmd_str, capture_output=True, text=True, errors="ignore", shell=True)

        if result.returncode != 0:
            print(f"\n[ERROR] Step '{name}' failed with exit code {result.returncode}!")
            print("STDOUT:\n", result.stdout)
            print("STDERR:\n", result.stderr)
            
            # Save failed status
            save_result(name, "failed", result.stdout + "\n" + result.stderr)
            
            # Create failure task
            error_msg = f"Step '{name}' failed.\nSTDOUT:\n{result.stdout[-1000:]}\nSTDERR:\n{result.stderr[-1000:]}"
            create_failure_task(error_msg)
            
            failed_step = name
            break

        # Save success status
        save_result(name, "passed", result.stdout)
        print(f"[SUCCESS] Step '{name}' completed successfully.")

    # Cleanup backend server process
    if server_proc:
        print("\nTerminating Mock App Server...")
        server_proc.terminate()
        try:
            server_proc.wait(timeout=5)
        except Exception:
            server_proc.kill()
        print("Mock App Server terminated.")

    if failed_step:
        print(f"\n==============================================================")
        print(f"[CRITICAL FAILURE] Pipeline halted at step: '{failed_step}'.")
        print(f"==============================================================")
        sys.exit(1)

    print(f"\n==============================================================")
    print(f"[SUCCESS] Enterprise Cypress E2E Pipeline finished cleanly!")
    print(f"All specs passed. Real videos, screenshots, and visual score proofs verified.")
    print(f"==============================================================")
    sys.exit(0)

if __name__ == "__main__":
    main()
