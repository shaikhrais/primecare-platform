import sqlite3
import os
import subprocess

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
DATABASE_NAME = "primecare-governance-db"

def run_command(cmd):
    result = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="ignore", shell=True)
    return result

def main():
    print("🚀 Registering the Clinical QA Handoff Flow inside SQLite...")
    
    if not os.path.exists(DB_PATH):
        print(f"[ERROR] Database not found at: {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # Define the new procedure details
    phase = "Clinical Flow QA"
    step_num = 9
    step_name = "Clinical Handoff Workflow Test Runner"
    cmd = "python tools/governance/test_flow_runner.py"
    desc = "Orchestration runner that lists target clinical workflow KPIs first, marks targeted screens as ready in local SQLite and D1, and outlines Cypress execution steps."
    expected_out = "Visual targets prepared and live edge D1 DB updated."

    # Check if already exists to prevent duplicate runs
    cursor.execute("SELECT id FROM governance_procedures WHERE command_to_run = ?", (cmd,))
    row = cursor.fetchone()
    
    if row:
        print("  Procedure already registered in local database. Re-syncing record...")
        cursor.execute("""
            UPDATE governance_procedures
            SET phase = ?, step_number = ?, step_name = ?, description = ?, expected_output = ?
            WHERE command_to_run = ?
        """, (phase, step_num, step_name, desc, expected_out, cmd))
    else:
        cursor.execute("""
            INSERT INTO governance_procedures (phase, step_number, step_name, command_to_run, description, expected_output)
            VALUES (?, ?, ?, ?, ?, ?)
        """, (phase, step_num, step_name, cmd, desc, expected_out))
        print("✨ Successfully inserted Clinical QA Flow into local SQLite governance_procedures!")

    conn.commit()
    conn.close()

    # Sync directly to Cloudflare D1
    print("⚡ Syncing new procedure to Cloudflare D1 edge database...")
    escaped_phase = phase.replace("'", "''")
    escaped_step_name = step_name.replace("'", "''")
    escaped_cmd = cmd.replace("'", "''")
    escaped_desc = desc.replace("'", "''")
    escaped_out = expected_out.replace("'", "''")

    sql_command = (
        f"INSERT INTO governance_procedures (phase, step_number, step_name, command_to_run, description, expected_output) "
        f"SELECT '{escaped_phase}', {step_num}, '{escaped_step_name}', '{escaped_cmd}', '{escaped_desc}', '{escaped_out}' "
        f"WHERE NOT EXISTS (SELECT 1 FROM governance_procedures WHERE command_to_run = '{escaped_cmd}');"
    )

    cmd_cf = f'npx wrangler d1 execute {DATABASE_NAME} --command="{sql_command}" --remote'
    res = run_command(cmd_cf)

    if res.returncode == 0:
        print("🚀 Successfully saved and synchronized new testing procedure to Cloudflare D1!")
    else:
        print("[WARN] Cloudflare D1 sync failed. Will sync on next batch update.")
        print(res.stderr)

if __name__ == '__main__':
    main()
