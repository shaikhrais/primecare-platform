import sqlite3
import os
import subprocess

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
DATABASE_NAME = "primecare-governance-db"
SQL_FILE = os.path.join(PROJECT_ROOT, "scratch", "procedures_push.sql")

def run_command(cmd):
    result = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="ignore", shell=True)
    return result

def main():
    print("🚀 Compiling D1 procedure upload batch...")
    
    if not os.path.exists(DB_PATH):
        print(f"[ERROR] Local SQLite database not found at {DB_PATH}!")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("SELECT id, phase, step_number, step_name, command_to_run, description, expected_output FROM governance_procedures")
    rows = cursor.fetchall()
    conn.close()

    statements = ["DELETE FROM governance_procedures;"]
    for r in rows:
        id_val, phase, step_num, step_name, cmd, desc, out = r
        
        # Escape single quotes for SQL
        escaped_cmd = cmd.replace("'", "''") if cmd else ""
        escaped_desc = desc.replace("'", "''")
        escaped_out = out.replace("'", "''")
        escaped_phase = phase.replace("'", "''")
        escaped_step_name = step_name.replace("'", "''")
        
        sql = (
            f"INSERT INTO governance_procedures (id, phase, step_number, step_name, command_to_run, description, expected_output) "
            f"VALUES ({id_val}, '{escaped_phase}', {step_num}, '{escaped_step_name}', '{escaped_cmd}', '{escaped_desc}', '{escaped_out}');"
        )
        statements.append(sql)

    with open(SQL_FILE, "w", encoding="utf-8") as f:
        f.write("\n".join(statements))

    print(f"⚡ Batching {len(rows)} procedures via Wrangler execution...")
    cmd = f'npx wrangler d1 execute {DATABASE_NAME} --file="{SQL_FILE}" --remote'
    res = run_command(cmd)
    
    # Cleanup
    try:
        os.remove(SQL_FILE)
    except Exception:
        pass

    if res.returncode == 0:
        print("🚀 Successfully synced all governance procedures to Cloudflare D1 database!")
    else:
        print("[ERROR] Failed to push procedures to D1!")
        print(res.stderr)

if __name__ == '__main__':
    main()
