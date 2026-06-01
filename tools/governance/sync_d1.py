import subprocess
import json
import sqlite3
import os
import argparse

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
DATABASE_NAME = "primecare-governance-db"

def run_command(cmd):
    result = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="ignore", shell=True)
    return result

def pull_from_d1():
    print(f"[PULL] Pulling crowdsourced feedback from Cloudflare D1 ('{DATABASE_NAME}')...")
    
    # Query screens feedback from Cloudflare D1 using Wrangler in JSON format
    cmd = f'npx wrangler d1 execute {DATABASE_NAME} --command="SELECT screen_code, user_remarks, user_remark_status, is_valid FROM screens WHERE user_remarks IS NOT NULL OR user_remark_status != \'none\' OR is_valid = 1" --json --remote'
    res = run_command(cmd)
    
    if res.returncode != 0:
        print("[ERROR] Failed to query D1 database!")
        print("STDOUT:", res.stdout)
        print("STDERR:", res.stderr)
        return

    try:
        # Wrangler outputs D1 results in a JSON envelope containing query objects
        data = json.loads(res.stdout)
        # Handle different wrangler json formats
        rows = []
        if isinstance(data, list) and len(data) > 0:
            rows = data[0].get("results", [])
        elif isinstance(data, dict):
            rows = data.get("results", [])

        if not rows:
            print("[INFO] No active remote reviews or manual approvals found in Cloudflare D1.")
            return

        print(f"  Found {len(rows)} remote records. Merging into local database '{DB_PATH}'...")
        conn = sqlite3.connect(DB_PATH)
        cursor = conn.cursor()

        updated_count = 0
        for row in rows:
            code = row.get("screen_code")
            remarks = row.get("user_remarks")
            status = row.get("user_remark_status", "none")
            is_valid = row.get("is_valid", 0)

            # Update local DB if remote is valid/has comments
            cursor.execute("""
                UPDATE screens
                SET user_remarks = ?, user_remark_status = ?, is_valid = MAX(is_valid, ?)
                WHERE LOWER(REPLACE(screen_code, '_', '')) = LOWER(REPLACE(?, '_', ''))
            """, (remarks, status, is_valid, code))
            if cursor.rowcount > 0:
                updated_count += 1

        conn.commit()
        conn.close()
        print(f"[SUCCESS] Merged remote reviews for {updated_count} screens into local database.")

    except Exception as e:
        print("[ERROR] Error parsing or merging D1 results:", str(e))
        print("Raw Output:", res.stdout[:500])

def push_to_d1():
    print(f"[PUSH] Pushing local Cypress E2E metrics and test coverage to Cloudflare D1 ('{DATABASE_NAME}')...")
    
    if not os.path.exists(DB_PATH):
        print(f"[ERROR] Local database not found at '{DB_PATH}'!")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    cursor.execute("""
        SELECT screen_code, cypress_ready, cypress_ready_status, actual_file_path, 
               complexity_score, estimated_loc, maintainability_score, is_valid,
               user_remarks, user_remark_status
        FROM screens
    """)
    rows = cursor.fetchall()
    conn.close()

    print(f"  Found {len(rows)} local screens. Compiling update batches...")

    # Build SQL queries to batch execute remotely to minimize Wrangler CLI startup overhead
    sql_statements = []
    for r in rows:
        code, ready, ready_status, actual_path, complexity, loc, maint, is_valid, remarks, status = r
        
        # Escape strings
        escaped_ready_status = ready_status.replace("'", "''") if ready_status else "untested"
        escaped_actual = actual_path.replace("'", "''") if actual_path else ""
        escaped_remarks = remarks.replace("'", "''") if remarks else ""
        escaped_status = status.replace("'", "''") if status else "none"
        
        sql = f"UPDATE screens SET cypress_ready = {ready or 0}, cypress_ready_status = '{escaped_ready_status}', actual_file_path = '{escaped_actual}', complexity_score = {complexity or 0}, estimated_loc = {loc or 0}, maintainability_score = {maint or 0}, is_valid = MAX(is_valid, {is_valid or 0}), user_remarks = '{escaped_remarks}', user_remark_status = '{escaped_status}' WHERE LOWER(REPLACE(screen_code, '_', '')) = LOWER(REPLACE('{code}', '_', ''));"
        sql_statements.append(sql)

    # To avoid huge command line arguments, we write sql statements to a temporary file and execute it in one shot!
    temp_sql_file = os.path.join(PROJECT_ROOT, "scratch", "temp_push_d1.sql")
    os.makedirs(os.path.dirname(temp_sql_file), exist_ok=True)
    
    with open(temp_sql_file, "w", encoding="utf-8") as f:
        f.write("\n".join(sql_statements))

    print(f"  Batching {len(sql_statements)} updates via Wrangler D1 execution...")
    cmd = f'npx wrangler d1 execute {DATABASE_NAME} --file="{temp_sql_file}" --remote'
    res = run_command(cmd)

    # Clean up temp file
    try:
        os.remove(temp_sql_file)
    except Exception:
        pass

    if res.returncode != 0:
        print("[ERROR] Failed to push metrics to Cloudflare D1!")
        print("STDOUT:", res.stdout)
        print("STDERR:", res.stderr)
    else:
        print(f"[SUCCESS] Uploaded all E2E metrics and local E2E test coverage to Cloudflare D1 database.")

def main():
    parser = argparse.ArgumentParser(description="Synchronize between Cloudflare D1 database and local SQLite database.")
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--pull", action="store_true", help="Download crowdsourced remarks/likes from Cloudflare D1 and merge into local database")
    group.add_argument("--push", action="store_true", help="Upload local Cypress coverage metrics, LOC, and widget complexity to Cloudflare D1")
    
    args = parser.parse_args()

    if args.pull:
        pull_from_d1()
    elif args.push:
        push_to_d1()

if __name__ == "__main__":
    main()
