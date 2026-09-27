import os
import re
import sys
import sqlite3
import subprocess
import time

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
CLINIC_APP_DIR = os.path.join(PROJECT_ROOT, "apps", "primecare_clinic")

def log(msg):
    print(f"[{time.strftime('%H:%M:%S')}] {msg}")

def run_command(cmd, cwd=None, env=None):
    cmd_str = " ".join(cmd) if isinstance(cmd, list) else cmd
    log(f"Running: {cmd_str}")
    proc_env = os.environ.copy()
    if env:
        proc_env.update(env)
    
    proc = subprocess.Popen(
        cmd_str,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        errors="ignore",
        shell=True,
        cwd=cwd,
        env=proc_env
    )
    
    output_lines = []
    # Stream the output line-by-line as it comes in
    while True:
        line = proc.stdout.readline()
        if not line and proc.poll() is not None:
            break
        if line:
            sys.stdout.write(line)
            sys.stdout.flush()
            output_lines.append(line)
            
    proc.wait()
    
    # Return a container compatible with the rest of the script
    class FinishedProcess:
        def __init__(self, returncode, stdout):
            self.returncode = returncode
            self.stdout = stdout
            self.stderr = ""
            
    return FinishedProcess(proc.returncode, "".join(output_lines))

def main():
    log("Step 1: Deploying apps/primecare_clinic to Cloudflare Pages project 'primecare-clinic'...")
    deploy_res = run_command([
        "wrangler", "pages", "deploy", "build/web",
        "--project-name", "primecare-clinic", "--commit-dirty=true"
    ], cwd=CLINIC_APP_DIR)
    
    if deploy_res.returncode != 0:
        log("Deploy failed!")
        log(f"STDOUT:\n{deploy_res.stdout}")
        log(f"STDERR:\n{deploy_res.stderr}")
        sys.exit(1)
        
    # Standardize to use consistent alias domain instead of unique subdomain preview hashes
    deployed_url = "https://primecare-clinic.pages.dev"
    match = re.search(r"https://[a-zA-Z0-9.-]+\.pages\.dev", deploy_res.stdout)
    if match:
        extracted_url = match.group(0).rstrip('/')
        sub_match = re.search(r"https://[a-zA-Z0-9-]+\.(primecare-[a-zA-Z0-9-]+)\.pages\.dev", extracted_url)
        if sub_match:
            deployed_url = f"https://{sub_match.group(1)}.pages.dev"
        elif "primecare-clinic" in extracted_url:
            deployed_url = "https://primecare-clinic.pages.dev"
        else:
            deployed_url = extracted_url
    log(f"Successfully deployed! Normalized URL: {deployed_url}")

    log("Step 2: Updating SQLite database with standardized clinic URL...")
    try:
        conn = sqlite3.connect(DB_PATH)
        cur = conn.cursor()
        cur.execute("""
            UPDATE roles
            SET primary_app_url = ?,
                auth_redirect_url = ?
            WHERE role_code = 'chiropractor'
        """, (deployed_url, f"{deployed_url}/auth/callback"))
        conn.commit()
        conn.close()
        log("SQLite database successfully updated.")
    except Exception as e:
        log(f"Error updating database: {e}")
        sys.exit(1)

    log("Step 3: Regenerating Cypress governance fixtures...")
    fixtures_res = run_command(["python", "tools/governance/generate_cypress_fixtures.py"])
    if fixtures_res.returncode != 0:
        log("Failed to regenerate Cypress fixtures!")
        sys.exit(1)
    log("Fixtures generated successfully.")

    log("Step 4: Running Chiropractor E2E Spec via Cypress...")
    cypress_env = {
        "CYPRESS_BASE_URL": deployed_url
    }
    
    cypress_res = run_command([
        "cypress", "run", "--spec", "cypress/e2e/04_roles/role_chiropractor_all_screens.cy.js"
    ], env=cypress_env)
    
    log(f"Cypress Execution completed with code: {cypress_res.returncode}")
    log("----- CYPRESS STDOUT -----")
    print(cypress_res.stdout)
    log("----- CYPRESS STDERR -----")
    print(cypress_res.stderr)
    
    if cypress_res.returncode != 0:
        log("Cypress Chiropractor E2E Sweep Failed!")
        sys.exit(1)
        
    log("All Chiropractor screens verified successfully!")
    sys.exit(0)

if __name__ == "__main__":
    main()
