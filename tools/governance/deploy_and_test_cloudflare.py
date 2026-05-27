import os
import sys
import time
import subprocess
import re
import sqlite3
import urllib.request
from datetime import datetime

DB_PATH = ".agents/governance/governance.db"
LOG_PATH = "tools/governance/reports/build_deployment.log"

def now():
    return datetime.utcnow().isoformat()

def log(msg):
    timestamp = now()
    line = f"[{timestamp}] {msg}"
    print(line)
    try:
        with open(LOG_PATH, "a", encoding="utf-8") as f:
            f.write(line + "\n")
    except Exception as e:
        print(f"Error writing to log: {e}")

def save_result(name, status, output):
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
            LOG_PATH
        ))
        conn.commit()
        conn.close()
        log(f"Saved KPI result '{name}' to SQLite as '{status}'.")
    except Exception as e:
        log(f"Error saving result to SQLite: {e}")

def create_failure_task(error_message):
    try:
        conn = sqlite3.connect(DB_PATH)
        cur = conn.cursor()
        screen_row = cur.execute("SELECT id, app_id FROM screens LIMIT 1;").fetchone()
        screen_id = screen_row[0] if screen_row else 1
        app_id = screen_row[1] if screen_row else 1

        cur.execute("""
            INSERT INTO implementation_tasks (app_id, task_type, related_screen_id, task_title, task_description, status, created_at)
            VALUES (?, 'cloudflare_deploy_test_failure', ?, ?, ?, 'pending', ?);
        """, (
            app_id,
            screen_id,
            "Fix Live Cloudflare Pages E2E Spec Failure",
            error_message[:1000],
            now()
        ))
        conn.commit()
        conn.close()
        log("Created failure implementation task in SQLite.")
    except Exception as e:
        log(f"Error creating failure task in SQLite: {e}")

def run_command(cmd, cwd=None, env=None):
    if isinstance(cmd, list):
        cmd_str = " ".join(cmd)
    else:
        cmd_str = cmd
        
    log(f"Running command: {cmd_str} (CWD: {cwd or '.'})")
    
    # Clean env copies for process
    proc_env = os.environ.copy()
    if env:
        proc_env.update(env)
    
    result = subprocess.run(cmd_str, capture_output=True, text=True, errors="ignore", shell=True, cwd=cwd, env=proc_env)
    
    if result.returncode != 0:
        log(f"[ERROR] Command failed with exit code {result.returncode}!")
        log(f"STDOUT:\n{result.stdout}")
        log(f"STDERR:\n{result.stderr}")
    else:
        log(f"[SUCCESS] Command completed successfully.")
        
    return result

def main():
    if os.path.exists(LOG_PATH):
        try:
            os.remove(LOG_PATH)
        except Exception:
            pass

    log("==============================================================")
    log("STARTING LIVE CLOUDFLARE PAGES BUILD & DEPLOYMENT E2E PIPELINE")
    log("==============================================================")

    # Step 1: Clean and Build the real primecare_auth Flutter Web app
    auth_app_path = os.path.join("apps", "primecare_auth")
    
    log("Cleaning flutter cache...")
    run_command(["flutter", "clean"], cwd=auth_app_path)
    
    log("Resolving flutter dependencies...")
    pub_get_res = run_command(["flutter", "pub", "get"], cwd=auth_app_path)
    if pub_get_res.returncode != 0:
        log("[FATAL] flutter pub get failed!")
        sys.exit(1)
        
    log("Compiling Web bundle in Release mode...")
    build_res = run_command([
        "flutter", "build", "web", "--release",
        "--dart-define=API_BASE_URL=https://primecare-api.itpro-mohammed.workers.dev/api"
    ], cwd=auth_app_path)
    
    if build_res.returncode != 0:
        log("[FATAL] flutter build web failed!")
        sys.exit(1)
        
    log("Real primecare_auth compiled successfully to apps/primecare_auth/build/web.")

    # Step 2: Deploy compiled build folder to Cloudflare Pages using Wrangler
    log("Deploying build/web to Cloudflare Pages project 'primecare-auth'...")
    deploy_res = run_command([
        "npx", "wrangler", "pages", "deploy", "build/web",
        "--project-name", "primecare-auth", "--commit-dirty=true"
    ], cwd=auth_app_path)
    
    if deploy_res.returncode != 0:
        log("[FATAL] Cloudflare Pages wrangler deploy failed!")
        sys.exit(1)

    # Step 3: Capture public deployed pages.dev URL from Wrangler stdout
    deploy_output = deploy_res.stdout + "\n" + deploy_res.stderr
    # Search for https://*.primecare-auth.pages.dev or general pages.dev domain
    url_match = re.search(r"https://[a-zA-Z0-9.-]+\.pages\.dev", deploy_output)
    
    if not url_match:
        # Fallback to standard alias
        deployed_url = "https://primecare-auth.pages.dev"
        log(f"[WARNING] Could not find live preview URL in wrangler output. Using production alias: {deployed_url}")
    else:
        deployed_url = url_match.group(0)
        log(f"Captured deployed Cloudflare Pages URL: {deployed_url}")

    # Step 4: Validate public URL returns HTTP 200 status via network probe
    log(f"Probing public URL {deployed_url} for HTTP 200 status...")
    attempts = 5
    url_ready = False
    for attempt in range(attempts):
        try:
            req = urllib.request.Request(
                deployed_url, 
                headers={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}
            )
            with urllib.request.urlopen(req, timeout=10) as response:
                status_code = response.getcode()
                if status_code == 200:
                    log(f"[SUCCESS] Public Cloudflare URL {deployed_url} is fully active! Status code: 200.")
                    url_ready = True
                    break
                else:
                    log(f"Attempt {attempt + 1}: Received status code {status_code}. Retrying in 3 seconds...")
        except Exception as e:
            log(f"Attempt {attempt + 1}: Error connecting to {deployed_url}: {e}. Retrying in 3 seconds...")
        time.sleep(3)

    if not url_ready:
        log(f"[FATAL] Deployed Cloudflare Pages URL {deployed_url} is not returning HTTP 200 OK!")
        sys.exit(1)

    # Step 5: Dynamically run Cypress E2E specs against the public URL
    cypress_env = {
        "CYPRESS_BASE_URL": deployed_url,
        "ROLE_CODE": "psw"
    }
    
    log(f"Generating fresh E2E fixtures targeting {deployed_url}...")
    fixtures_res = run_command(["python", "tools/governance/generate_cypress_fixtures.py"])
    if fixtures_res.returncode != 0:
        log("[FATAL] Fixture generation failed!")
        sys.exit(1)

    role_code = cypress_env.get("ROLE_CODE", "psw").lower()

    # Step 6: First run ONLY: auth spec per role to verify auth page is visible on Cloudflare
    log(f"\n[RUNNING STEP] LIVE AUTH LOGIN SPEC FOR ROLE '{role_code}' (CYPRESS)...")
    auth_spec_res = run_command([
        "cypress", "run", "--spec", f"cypress/e2e/01_auth/auth_{role_code}.cy.js"
    ], env=cypress_env)

    if auth_spec_res.returncode != 0:
        log(f"[FATAL] Live auth spec for role '{role_code}' failed against Cloudflare URL!")
        save_result("auth_login_spec", "failed", auth_spec_res.stdout + "\n" + auth_spec_res.stderr)
        create_failure_task(f"Cypress auth spec failed on Cloudflare URL: {deployed_url}")
        sys.exit(1)
        
    save_result("auth_login_spec", "passed", auth_spec_res.stdout)
    log("[SUCCESS] Live Auth Login spec passed cleanly against Cloudflare!")

    # Step 7: Run remaining specs sequentially
    remaining_steps = [
        {
            "name": "language_governance_spec",
            "cmd": ["cypress", "run", "--spec", f"cypress/e2e/02_language/language_{role_code}.cy.js"]
        },
        {
            "name": "one_role_all_screens_spec",
            "cmd": ["cypress", "run", "--spec", f"cypress/e2e/04_roles/role_{role_code}_all_screens.cy.js"]
        },
        {
            "name": "one_app_all_roles_spec",
            "cmd": ["cypress", "run", "--spec", "cypress/e2e/05_apps/*.cy.js"]
        },
        {
            "name": "org_full_e2e_spec",
            "cmd": ["cypress", "run", "--spec", "cypress/e2e/06_org/org_full_ui.cy.js"]
        }
    ]

    failed_step = None
    for step in remaining_steps:
        name = step["name"]
        cmd = step["cmd"]
        log(f"\n[RUNNING STEP] {name.replace('_', ' ').upper()} (CYPRESS)...")
        
        step_res = run_command(cmd, env=cypress_env)
        
        if step_res.returncode != 0:
            log(f"[ERROR] Step '{name}' failed against Cloudflare URL!")
            save_result(name, "failed", step_res.stdout + "\n" + step_res.stderr)
            create_failure_task(f"Cypress Step '{name}' failed on Cloudflare URL: {deployed_url}")
            failed_step = name
            break
            
        save_result(name, "passed", step_res.stdout)
        log(f"[SUCCESS] Step '{name}' completed successfully against Cloudflare.")

    if failed_step:
        log(f"\n[CRITICAL FAILURE] Pipeline halted at step: '{failed_step}'.")
        sys.exit(1)

    # Step 8: Validate Captured Screenshots using Pillow complexity scorer
    log("\n[RUNNING STEP] pillow screenshot complexity validation...")
    val_res = run_command(["python", "tools/governance/validate_screenshots.py"])
    if val_res.returncode != 0:
        log("[ERROR] Pillow screenshot validation failed!")
        save_result("validate_screenshots", "failed", val_res.stdout + "\n" + val_res.stderr)
        sys.exit(1)
        
    save_result("validate_screenshots", "passed", val_res.stdout)
    log("[SUCCESS] Pillow screenshot validation completed successfully.")

    # Step 9: Recompile dark mode visual dashboard
    log("\n[RUNNING STEP] generating dynamic dark-mode reporting dashboard...")
    dash_res = run_command(["python", "tools/governance/generate_cypress_visual_dashboard.py"])
    if dash_res.returncode != 0:
        log("[ERROR] Visual Dashboard generation failed!")
        save_result("generate_cypress_visual_dashboard", "failed", dash_res.stdout + "\n" + dash_res.stderr)
        sys.exit(1)
        
    save_result("generate_cypress_visual_dashboard", "passed", dash_res.stdout)
    save_result("visual_proof_validation", "passed", f"Successfully ran all 5 specs against public Cloudflare Pages URL: {deployed_url}")
    log("[SUCCESS] Visual Dashboard recompiled successfully.")

    log("\n==============================================================")
    log(f"[SUCCESS] Live Cloudflare Pages E2E Pipeline completed cleanly!")
    log(f"Real app deployed to: {deployed_url}")
    log(f"All specs passed. Real screenshots & Pillow metrics verified.")
    log("==============================================================")
    sys.exit(0)

if __name__ == "__main__":
    main()
