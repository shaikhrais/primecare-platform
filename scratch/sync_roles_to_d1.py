import sqlite3
import os
import subprocess

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
DATABASE_NAME = "primecare-governance-db"

def run_command(cmd):
    result = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="ignore", shell=True)
    return result

def main():
    if not os.path.exists(DB_PATH):
        print(f"[ERROR] Local database not found at '{DB_PATH}'!")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("SELECT role_code, post_login_route FROM roles;")
    rows = cursor.fetchall()
    conn.close()

    print(f"Found {len(rows)} roles. Compiling SQL statements...")

    sql_statements = []
    for role_code, post_login_route in rows:
        if post_login_route:
            escaped_route = post_login_route.replace("'", "''")
            sql = f"UPDATE roles SET post_login_route = '{escaped_route}' WHERE role_code = '{role_code}';"
            sql_statements.append(sql)

    temp_sql_file = os.path.join(PROJECT_ROOT, "scratch", "temp_sync_roles.sql")
    with open(temp_sql_file, "w", encoding="utf-8") as f:
        f.write("\n".join(sql_statements))

    print(f"Executing {len(sql_statements)} remote updates in D1...")
    cmd = f'npx wrangler d1 execute {DATABASE_NAME} --file="{temp_sql_file}" --remote'
    res = run_command(cmd)

    try:
        os.remove(temp_sql_file)
    except Exception:
        pass

    if res.returncode != 0:
        print("[ERROR] Failed to sync roles to Cloudflare D1!")
        print("STDOUT:", res.stdout)
        print("STDERR:", res.stderr)
    else:
        print("[SUCCESS] Successfully synchronized all role route configurations to Cloudflare D1.")

if __name__ == '__main__':
    main()
