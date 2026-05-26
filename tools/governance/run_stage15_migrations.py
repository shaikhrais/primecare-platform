import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("==============================================================")
    print("PRIMECARE GOVERNANCE: STAGE 15 DDL MIGRATIONS & SEEDING")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # Drop existing view and tables for a clean rebuild
    cursor.execute("DROP VIEW IF EXISTS v_governance_function_queue;")
    cursor.execute("DROP TABLE IF EXISTS governance_function_results;")
    cursor.execute("DROP TABLE IF EXISTS governance_function_runs;")
    cursor.execute("DROP TABLE IF EXISTS governance_functions;")
    print("Dropped legacy views and tables cleanly.")

    # Phase 2 - Add screen fields if missing
    columns_to_add = [
        ("data_cy_required_json", "TEXT"),
        ("data_cy_found_json", "TEXT"),
        ("data_cy_missing_json", "TEXT"),
        ("cypress_ready", "INTEGER DEFAULT 0"),
        ("cypress_ready_status", "TEXT DEFAULT 'not_ready'"),
        ("actual_component_tree_json", "TEXT"),
        ("missing_component_tree_json", "TEXT"),
        ("component_scan_status", "TEXT DEFAULT 'pending'"),
        ("component_scan_log", "TEXT"),
        ("component_scan_at", "TEXT")
    ]

    for col_name, col_type in columns_to_add:
        try:
            cursor.execute(f"ALTER TABLE screens ADD COLUMN {col_name} {col_type};")
            print(f"Added column {col_name} to screens table.")
        except sqlite3.OperationalError as e:
            if "duplicate column name" in str(e):
                print(f"Column {col_name} already exists in screens table. Skipping.")
            else:
                print(f"Error adding {col_name}: {e}")

    try:
        cursor.execute("ALTER TABLE api_endpoints ADD COLUMN avg_latency_ms INTEGER;")
        print("Added column avg_latency_ms to api_endpoints table.")
    except sqlite3.OperationalError as e:
        if "duplicate column name" in str(e):
            print("Column avg_latency_ms already exists in api_endpoints table. Skipping.")
        else:
            print(f"Error adding avg_latency_ms: {e}")

    # Phase 1 - Add tables
    cursor.execute("""
    CREATE TABLE governance_functions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      function_code TEXT UNIQUE NOT NULL,
      function_name TEXT NOT NULL,
      function_type TEXT NOT NULL,
      purpose_text TEXT NOT NULL,
      input_source TEXT,
      input_query TEXT,
      run_command TEXT NOT NULL,
      expected_output_text TEXT,
      success_condition_text TEXT NOT NULL,
      updates_table TEXT,
      updates_fields_text TEXT,
      proof_required INTEGER DEFAULT 1,
      proof_type TEXT,
      proof_output_path TEXT,
      run_order INTEGER DEFAULT 100,
      is_active INTEGER DEFAULT 1,
      last_run_status TEXT DEFAULT 'not_run',
      last_run_at TEXT,
      last_error TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP
    );
    """)
    print("Created table governance_functions.")

    cursor.execute("""
    CREATE TABLE governance_function_runs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      function_id INTEGER NOT NULL,
      task_id INTEGER,
      run_status TEXT DEFAULT 'started',
      command_run TEXT,
      output_log TEXT,
      error_log TEXT,
      rows_scanned INTEGER DEFAULT 0,
      rows_updated INTEGER DEFAULT 0,
      issues_found INTEGER DEFAULT 0,
      tasks_created INTEGER DEFAULT 0,
      proof_json TEXT,
      proof_log_path TEXT,
      proof_screenshot_path TEXT,
      proof_video_path TEXT,
      proof_report_path TEXT,
      started_at TEXT DEFAULT CURRENT_TIMESTAMP,
      completed_at TEXT,
      FOREIGN KEY (function_id) REFERENCES governance_functions(id) ON DELETE CASCADE,
      FOREIGN KEY (task_id) REFERENCES implementation_tasks(id) ON DELETE SET NULL
    );
    """)
    print("Created table governance_function_runs.")

    cursor.execute("""
    CREATE TABLE governance_function_results (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      run_id INTEGER NOT NULL,
      function_id INTEGER NOT NULL,
      target_table TEXT,
      target_id INTEGER,
      target_name TEXT,
      result_status TEXT NOT NULL,
      result_summary TEXT,
      before_json TEXT,
      after_json TEXT,
      suggested_fix TEXT,
      created_task_id INTEGER,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (run_id) REFERENCES governance_function_runs(id) ON DELETE CASCADE,
      FOREIGN KEY (function_id) REFERENCES governance_functions(id) ON DELETE CASCADE
    );
    """)
    print("Created table governance_function_results.")

    # Phase 4 - Create Runner View
    cursor.execute("""
    CREATE VIEW v_governance_function_queue AS
    SELECT
      id AS function_id,
      function_code,
      function_name,
      function_type,
      purpose_text,
      input_source,
      input_query,
      run_command,
      success_condition_text,
      updates_table,
      updates_fields_text,
      proof_type,
      proof_output_path,
      run_order,
      last_run_status,
      last_error
    FROM governance_functions
    WHERE is_active = 1
      AND (
        last_run_status IS NULL
        OR last_run_status != 'passed'
      )
    ORDER BY run_order ASC, id ASC;
    """)
    print("Created view v_governance_function_queue.")

    # Phase 3 - Seed Governance Functions
    functions_to_seed = [
        (
         'scan_screen_components',
         'Scan Screen Components',
         'scan',
         'Open every screen actual_file_path, detect Flutter widgets, buttons, form fields, API usage, fake handlers, null handlers, and data-cy/test keys.',
         'screens',
         "SELECT id, screen_name, actual_file_path FROM screens WHERE actual_file_path IS NOT NULL AND actual_file_path != '';",
         'python tools/governance/scan_screen_components.py',
         'screens.actual_component_tree_json, data_cy_found_json, data_cy_missing_json, cypress_ready_status updated.',
         'All screens scanned and component_scan_status = scanned.',
         'screens',
         'actual_component_tree_json,data_cy_found_json,data_cy_missing_json,cypress_ready,cypress_ready_status,component_scan_status,component_scan_log,component_scan_at',
         'json_log',
         'tools/governance/reports/component_scan_report.json',
         10
        ),
        (
         'add_missing_data_cy',
         'Add Missing Data-CY Keys',
         'agent_fix',
         'For every screen where data_cy_missing_json is not empty, open file and add Flutter Key and Semantics labels for root, title, content, buttons, fields, loading, error, and success states.',
         'screens',
         'SELECT id, screen_name, actual_file_path, data_cy_missing_json FROM screens WHERE cypress_ready = 0;',
         'python tools/governance/add_data_cy_to_flutter.py',
         'Missing Key/Semantics test hooks added to screen files.',
         'After rerun, cypress_ready = 1 for updated screens and fake/null handlers = 0.',
         'screens',
         'data_cy_found_json,data_cy_missing_json,cypress_ready,cypress_ready_status',
         'log',
         'tools/governance/reports/add_data_cy_report.log',
         20
        ),
        (
         'generate_cypress_fixtures',
         'Generate Cypress Fixtures',
         'cypress',
         'Export screens, roles, apps, and API endpoint data from SQLite into Cypress fixture JSON files.',
         'screens,roles,apps,api_endpoints',
         'SELECT * FROM screens;',
         'python tools/governance/generate_cypress_fixtures.py',
         'cypress/fixtures/governance/screens.json and api_endpoints.json generated.',
         'Fixture files exist and contain active screens and endpoints.',
         'files',
         'cypress/fixtures/governance/*.json',
         'json',
         'cypress/fixtures/governance/screens.json',
         30
        ),
        (
         'run_single_screen_cypress',
         'Run Single Screen Cypress Test',
         'cypress',
         'Run Cypress for one screen using route_path and data_cy_map from SQLite fixture.',
         'screens',
         'SELECT * FROM screens WHERE cypress_ready = 1;',
         'npx cypress run --spec cypress/e2e/screen/screen_single.cy.js',
         'One screen opens, root/title/content visible, major buttons clickable.',
         'Cypress exits 0 and screenshot/video proof exists.',
         'screens',
         'cypress_last_status,cypress_last_error,cypress_last_run_at,cypress_video_path,cypress_screenshot_path',
         'video_screenshot',
         'cypress/videos/',
         40
        ),
        (
         'run_role_all_screens_cypress',
         'Run Role All Screens Cypress Test',
         'cypress',
         'Login as one role and test all screens allowed for that role. Stop on first failure.',
         'roles,screens',
         'SELECT * FROM roles;',
         'npx cypress run --spec cypress/e2e/role/role_all_screens.cy.js',
         'Role login works and all allowed screens open with required data-cy elements.',
         'Cypress exits 0 for role flow.',
         'test_cases',
         'last_run_status,proof_log_path',
         'video_screenshot',
         'cypress/videos/',
         50
        ),
        (
         'test_all_api_endpoints',
         'Test All API Endpoints',
         'api_test',
         'Call all non-backend API endpoints directly without UI using seeded credentials.',
         'api_endpoints',
         'SELECT * FROM api_endpoints WHERE is_backend_only = 0;',
         'python tools/governance/test_api_endpoints.py',
         'Every active API returns expected status, latency, and JSON shape.',
         'No active API fails. Failed APIs create implementation_tasks.',
         'api_endpoints',
         'health_status,last_tested_at,avg_latency_ms',
         'json_log',
         'tools/governance/reports/api_endpoint_test_report.json',
         60
        ),
        (
         'update_screen_kpis',
         'Update Screen KPI Fields',
         'kpi_update',
         'Calculate LOC, complexity, button count, component count, API count, maintainability score, and technical debt score from real code.',
         'screens',
         'SELECT id, screen_name, actual_file_path FROM screens;',
         'python tools/governance/update_screen_kpis.py',
         'Screen KPI fields updated from physical code scan.',
         'estimated_loc > 0 and scores populated for all active screens.',
         'screens',
         'estimated_loc,complexity_score,maintainability_score,technical_debt_score,real_component_count,real_button_count,real_api_call_count',
         'json_log',
         'tools/governance/reports/screen_kpi_report.json',
         70
        ),
        (
         'generate_final_governance_report',
         'Generate Final Governance HTML Report',
         'report',
         'Generate HTML report showing screens, components, data-cy readiness, API readiness, Cypress readiness, failed tasks, and next actions.',
         'all',
         'SELECT * FROM screens;',
         'python tools/governance/generate_governance_html_report.py',
         'HTML report created.',
         'Report file exists and lists pass/fail items clearly.',
         'governance_reports',
         'html_report_path,report_type,created_at',
         'html_report',
         'tools/governance/reports/final_governance_report.html',
         100
        )
    ]

    for row in functions_to_seed:
        cursor.execute("""
        INSERT INTO governance_functions
        (function_code, function_name, function_type, purpose_text, input_source, input_query, run_command, expected_output_text, success_condition_text, updates_table, updates_fields_text, proof_type, proof_output_path, run_order)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
        """, row)

    conn.commit()
    conn.close()
    print("Seeded all governance functions successfully.")

if __name__ == '__main__':
    main()
