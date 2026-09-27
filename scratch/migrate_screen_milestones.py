import sqlite3
import os
import subprocess

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
DATABASE_NAME = "primecare-governance-db"
SQL_FILE = os.path.join(PROJECT_ROOT, "scratch", "milestones_push.sql")

def run_command(cmd):
    result = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="ignore", shell=True)
    return result

def main():
    print("🚀 Compiling D1 screen milestones push batch...")
    
    if not os.path.exists(DB_PATH):
        print(f"[ERROR] Local SQLite database not found at {DB_PATH}!")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("SELECT screen_code, pre_test_ready, routes_files_ready, layout_ready, code_ready, data_code_ready, presentation_ready FROM screen_milestones")
    rows = cursor.fetchall()
    conn.close()

    statements = ["DELETE FROM screen_milestones;"]
    for r in rows:
        code, pre, r_f, lay, code_r, data_r, pres = r
        sql = (
            f"INSERT INTO screen_milestones (screen_code, pre_test_ready, routes_files_ready, layout_ready, code_ready, data_code_ready, presentation_ready) "
            f"VALUES ('{code}', {pre}, {r_f}, {lay}, {code_r}, {data_r}, {pres});"
        )
        statements.append(sql)

    with open(SQL_FILE, "w", encoding="utf-8") as f:
        f.write("\n".join(statements))

    print(f"⚡ Batching {len(rows)} screen milestones via Wrangler D1 execution...")
    cmd = f'npx wrangler d1 execute {DATABASE_NAME} --file="{SQL_FILE}" --remote'
    res = run_command(cmd)
    
    # Cleanup
    try:
        os.remove(SQL_FILE)
    except Exception:
        pass

    if res.returncode == 0:
        print("🚀 Successfully synced all screen milestones to Cloudflare D1 database!")
    else:
        print("[ERROR] Failed to push screen milestones to D1!")
        print(res.stderr)

if __name__ == '__main__':
    main()
