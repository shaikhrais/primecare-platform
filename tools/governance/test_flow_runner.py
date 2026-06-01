import sqlite3
import os
import sys
import subprocess

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
DATABASE_NAME = "primecare-governance-db"

def run_command(cmd):
    result = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="ignore", shell=True)
    return result

def main():
    print("==============================================================")
    print("📋 CLINICAL WORKFLOW QUALITY ASSURANCE RUNNER")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"[ERROR] Local SQLite database not found at '{DB_PATH}'")
        sys.exit(1)

    # Prioritized Screen Codes for the Clinical Workflow Handoff
    target_screens = ["psw_workflow", "rn_workflow", "rpn_workflow", "rn_analytics", "clinical_dashboard"]

    # 1. Query & List KPIs FIRST before running test cases
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    placeholders = ",".join("?" for _ in target_screens)
    query = f"""
        SELECT screen_code, screen_name, complexity_score, estimated_loc, 
               cypress_ready, cypress_ready_status, is_valid, user_remark_status
        FROM screens
        WHERE screen_code IN ({placeholders})
        ORDER BY complexity_score DESC
    """
    cursor.execute(query, target_screens)
    screens = [dict(r) for r in cursor.fetchall()]

    print("\n🏆 TARGET CLINICAL FLOW KEY PERFORMANCE INDICATORS (KPIs):")
    print("-" * 110)
    print(f"{'Screen Code':<20} | {'Screen Name':<22} | {'Complexity':<10} | {'LOC':<6} | {'E2E Status':<12} | {'Remark Status':<15}")
    print("-" * 110)
    
    for s in screens:
        e2e_status = s["cypress_ready_status"] or "untested"
        remark_status = s["user_remark_status"] or "none"
        print(f"{s['screen_code']:<20} | {s['screen_name']:<22} | {s['complexity_score']:<10} | {s['estimated_loc']:<6} | {e2e_status:<12} | {remark_status:<15}")
    print("-" * 110)

    # 2. Make screens ready for first test in local SQLite
    print("\n⚡ Making targeted clinical screens READY for the first test run...")
    
    cursor.execute(f"""
        UPDATE screens
        SET cypress_ready = 1,
            cypress_ready_status = 'ready',
            is_valid = 0,
            user_remark_status = 'review_required',
            user_remarks = 'Procedural workflow reset. Initial E2E visual review scheduled.'
        WHERE screen_code IN ({placeholders})
    """, target_screens)
    
    conn.commit()
    conn.close()
    
    print("✨ Successfully marked target screens as READY in local SQLite database!")

    # 3. Synchronize status directly to Cloudflare D1 database
    print("⚡ Syncing testing ready state to Cloudflare D1 edge...")
    
    sql_updates = []
    for s in target_screens:
        sql = (
            f"UPDATE screens "
            f"SET cypress_ready = 1, "
            f"    cypress_ready_status = 'ready', "
            f"    is_valid = 0, "
            f"    user_remark_status = 'review_required', "
            f"    user_remarks = 'Procedural workflow reset. Initial E2E visual review scheduled.' "
            f"WHERE LOWER(REPLACE(screen_code, '_', '')) = LOWER(REPLACE('{s}', '_', ''));"
        )
        sql_updates.append(sql)

    temp_sql_file = os.path.join(PROJECT_ROOT, "scratch", "temp_flow_ready.sql")
    with open(temp_sql_file, "w", encoding="utf-8") as f:
        f.write("\n".join(sql_updates))

    cmd = f'npx wrangler d1 execute {DATABASE_NAME} --file="{temp_sql_file}" --remote'
    res = run_command(cmd)

    try:
        os.remove(temp_sql_file)
    except Exception:
        pass

    if res.returncode == 0:
        print("🚀 Successfully synced READY state to Cloudflare D1 edge!")
    else:
        print("[WARN] Cloudflare D1 sync failed. It will sync on next batch run.")
        print(res.stderr)

    # 4. Present the visual quality testing workflow steps
    print("\n==============================================================")
    print("🚀 FIRST TEST CASE EXECUTION FLOW GUIDE")
    print("==============================================================")
    print("To execute the first role-based visual handoff E2E test, run:")
    print("-" * 80)
    print("👉 STEP 1 (PSW Handoff Loop):")
    print("   $env:ROLE_CODE=\"psw\"; npx cypress run --spec \"cypress/e2e/02_language/language_psw.cy.js\"")
    print("\n👉 STEP 2 (RN Assessment Loop):")
    print("   $env:ROLE_CODE=\"rn\"; npx cypress run --spec \"cypress/e2e/02_language/language_rn.cy.js\"")
    print("\n👉 STEP 3 (RPN Treatment Loop):")
    print("   $env:ROLE_CODE=\"rpn\"; npx cypress run --spec \"cypress/e2e/02_language/language_rpn.cy.js\"")
    print("-" * 80)
    print("🏁 Execute the above commands to start harvesting fresh visual E2E screenshots!")

if __name__ == "__main__":
    main()
