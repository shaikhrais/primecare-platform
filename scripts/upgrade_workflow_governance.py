import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def upgrade_schema():
    print("=====================================================")
    print("Executing Stage 6 Enterprise Workflow Remodeling Migration")
    print("=====================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: SQLite database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    # 1. Safely alter screens table to add all 9 workflow governance and anti-fake columns
    new_columns = [
        ("workflow_verified", "INTEGER DEFAULT 0"),
        ("workflow_name", "TEXT"),
        ("workflow_stage", "TEXT"),
        ("upstream_screen_codes", "TEXT"),
        ("downstream_screen_codes", "TEXT"),
        ("runtime_video_path", "TEXT"),
        ("network_log_path", "TEXT"),
        ("console_log_path", "TEXT"),
        ("proof_hash", "TEXT")
    ]

    cursor.execute("PRAGMA table_info(screens);")
    existing_cols = [row['name'] for row in cursor.fetchall()]

    for col_name, col_def in new_columns:
        if col_name not in existing_cols:
            print(f"Adding column '{col_name}' to 'screens' table...")
            cursor.execute(f"ALTER TABLE screens ADD COLUMN {col_name} {col_def};")
        else:
            print(f"Column '{col_name}' already exists in screens table.")

    conn.commit()

    # 2. Create the master table workflow_runtime_checks
    print("Deploying master table 'workflow_runtime_checks'...")
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS workflow_runtime_checks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      role_id INTEGER NOT NULL,
      workflow_name TEXT NOT NULL UNIQUE,
      workflow_steps_text TEXT,
      login_verified INTEGER DEFAULT 0,
      navigation_verified INTEGER DEFAULT 0,
      data_flow_verified INTEGER DEFAULT 0,
      mutation_verified INTEGER DEFAULT 0,
      audit_verified INTEGER DEFAULT 0,
      workflow_status TEXT DEFAULT 'pending',
      proof_log_path TEXT,
      screenshot_path TEXT,
      network_log_path TEXT,
      console_log_path TEXT,
      proof_hash TEXT,
      last_checked_at TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (app_id) REFERENCES apps(id),
      FOREIGN KEY (role_id) REFERENCES roles(id)
    );
    """)
    conn.commit()
    print("Table 'workflow_runtime_checks' successfully deployed.")

    # 3. Seed workflows for standard enterprise roles
    print("Seeding role-based workflows...")
    
    # Let's get app and role IDs dynamically
    cursor.execute("SELECT id, app_code FROM apps WHERE app_code IN ('ui', 'go', 'ci', 'cl', 'co');")
    apps_map = {row['app_code']: row['id'] for row in cursor.fetchall()}
    
    cursor.execute("SELECT id, role_code FROM roles;")
    roles_map = {row['role_code']: row['id'] for row in cursor.fetchall()}

    # Resolve fallbacks
    app_id = apps_map.get('ui') or apps_map.get('go') or 1
    role_admin_id = roles_map.get('ROLE_ADMIN') or 1
    role_caregiver_id = roles_map.get('ROLE_CAREGIVER') or roles_map.get('ROLE_PSW') or 1
    role_clinician_id = roles_map.get('ROLE_CLINICIAN') or 1
    role_cfo_id = roles_map.get('ROLE_FINANCEDIRECTOR') or roles_map.get('ROLE_FINANCE_DIRECTOR') or 1
    role_executive_id = roles_map.get('ROLE_EXECUTIVE') or 1

    workflows = [
        (app_id, role_caregiver_id, "Caregiver Shift Intake Flow", 
         "Login -> Open Assigned Shift -> Open Client Portal -> Log ADL Observation -> Complete Shift Tasks -> Generate Visit Note -> Verify API Ledger Mutation -> Logout"),
        
        (app_id, role_clinician_id, "Clinician Charting Flow", 
         "Login -> Open Patient Chart -> Conduct SOAP Assessment -> Map Telus billing -> Authorize Medication logs -> Sync API Gateway -> Verify DB records -> Logout"),
        
        (app_id, role_cfo_id, "Double-Entry Financial Remittance Flow", 
         "Login -> Load ledger Balance Sheet -> Run Plaid reconciliation -> Remit HST/GST tax payload -> Compile Forecasting -> Sync ledger microservices -> Verify DB ledger entries -> Logout"),
        
        (app_id, role_executive_id, "Executive Command KPI Dashboard Flow", 
         "Login -> Load Enterprise KPI CommandCenter -> Analyze Staffing overview -> Verify Service Quality issues -> Track branch performance -> Sync Edge worker -> Logout"),
        
        (app_id, role_admin_id, "SSO Key Rotation & Edge Security Flow", 
         "Login -> Audit Edge routing wranglers -> Run RSA SSO key rotation -> Execute SQLite DB sweep -> Check serverless API caches -> Verify security logs -> Logout")
    ]

    for app, role, name, steps in workflows:
        try:
            cursor.execute("""
            INSERT INTO workflow_runtime_checks (app_id, role_id, workflow_name, workflow_steps_text)
            VALUES (?, ?, ?, ?);
            """, (app, role, name, steps))
            print(f"Seeded workflow: '{name}'")
        except sqlite3.IntegrityError:
            print(f"Workflow '{name}' already seeded.")

    conn.commit()
    conn.close()
    print("\nDatabase remodeled and enqueued for E2E workflow verifications!")

if __name__ == "__main__":
    upgrade_schema()
