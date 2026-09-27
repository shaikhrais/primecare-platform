import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print(f"🚀 Initiating Database Procedure Seeding on '{DB_PATH}'...")
    
    if not os.path.exists(DB_PATH):
        print(f"[ERROR] Database not found at: {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # 1. Create table
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS governance_procedures (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            phase TEXT NOT NULL,
            step_number INTEGER NOT NULL,
            step_name TEXT NOT NULL,
            command_to_run TEXT,
            description TEXT NOT NULL,
            expected_output TEXT NOT NULL,
            created_at TEXT DEFAULT CURRENT_TIMESTAMP
        );
    """)
    
    # Clean previous seeds
    cursor.execute("DELETE FROM governance_procedures")

    # 2. Define procedure steps
    procedures = [
        # Phase 1: Pre-Flight Checks
        (
            "Pre-Flight Checks", 
            1, 
            "Static File Sweep & Health Check",
            "python tools/governance/governance_kpi_manager.py --pre-flight",
            "Scans all 948 screen records in the registry to verify if their corresponding Flutter source Dart code exists physically on the filesystem.",
            "List of missing files, pre-flight file integrity score, and router mapping percentage."
        ),
        (
            "Pre-Flight Checks", 
            2, 
            "Cypress Spec Evaluation",
            "python tools/governance/governance_kpi_manager.py --e2e-readiness",
            "Performs a sweep of the cypress/e2e/ folder to check if a valid screen-level visual cypress specification file exists for every registered screen.",
            "E2E spec coverage percentage and list of screen codes missing verification spec files."
        ),
        # Phase 2: E2E Cypress Execution
        (
            "E2E Testing", 
            3, 
            "Execute Role-Based E2E Test Suite",
            "$env:ROLE_CODE=\"<role>\"; cypress run --spec \"cypress/e2e/02_language/language_<role>.cy.js\"",
            "Runs cypress headless testing suite under a specific clinical user role (e.g. psw, rn, rpn, clinical_director) to verify visual layouts and switch languages.",
            "Cypress test spec summary with 100% clean passes, saved screenshots, and visual videos."
        ),
        # Phase 3: Post-Flight & Dashboards
        (
            "Post-Flight QA", 
            4, 
            "Test Registry KPI Alignment",
            "python tools/governance/governance_kpi_manager.py --post-flight",
            "Reads generated cypress visual results JSON and aligns pass/fail verification states with active records inside the local sqlite database.",
            "Successful reconciliation report and updated `is_valid` state markers in the DB."
        ),
        (
            "Post-Flight QA", 
            5, 
            "Interactive Quality Dashboard Compilation",
            "python tools/governance/generate_interactive_dashboard.py",
            "Pulls live orgs, apps, roles, and screens databases from SQLite and bakes them directly into an offline-capable HTML visual report bundle.",
            "Saved visual dashboard file at tools/governance/reports/interactive_governance_dashboard.html."
        ),
        # Phase 4: Lightning-Fast Individual Feedback
        (
            "Lightning-Fast Feedback", 
            6, 
            "Log Single-Screen Direct Remark & Sync",
            "python tools/governance/feedback.py <screen_code> \"<your feedback>\" [status]",
            "Direct lightweight logging CLI tool. Updates the local SQLite record for a single screen and instantly syncs that screen's remark to Cloudflare D1.",
            "Vibrant CLI success logs confirming instant D1 sync under 2 seconds."
        ),
        # Phase 5: Cloudflare Edge Sync
        (
            "Cloudflare Edge Sync", 
            7, 
            "Batch Push SQLite to Cloudflare D1",
            "$env:PYTHONUTF8=1; python tools/governance/sync_d1.py --push",
            "Compiles and pushes all E2E spec registry verification updates, complexity scores, LOC counts, and remarks in batch to Cloudflare D1 cloud.",
            "Wrangler execution success confirming live publish to remote D1 edge database."
        ),
        (
            "Cloudflare Edge Sync", 
            8, 
            "Batch Pull D1 Remote Remarks",
            "$env:PYTHONUTF8=1; python tools/governance/sync_d1.py --pull",
            "Retrieves all crowdsourced comments and manual review responses submitted by external QA reviewers on the live deployed web portal.",
            "Local database sync success merging feedback and comments safely."
        )
    ]

    # 3. Seed table
    cursor.executemany("""
        INSERT INTO governance_procedures (phase, step_number, step_name, command_to_run, description, expected_output)
        VALUES (?, ?, ?, ?, ?, ?)
    """, procedures)

    conn.commit()
    
    # Verify print
    cursor.execute("SELECT count(*) FROM governance_procedures")
    count = cursor.fetchone()[0]
    print(f"✨ Successfully seeded {count} step-by-step procedures into 'governance_procedures' table!")
    
    conn.close()

if __name__ == '__main__':
    main()
