import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def init_tables():
    print("==============================================================")
    print("INITIALIZING PRIMECARE GOVERNANCE FUNCTIONS SYSTEM")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # Enable foreign keys
    cursor.execute("PRAGMA foreign_keys = ON;")

    # 1. Create governance_functions table
    print("Creating table 'governance_functions'...")
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS governance_functions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,

      app_id INTEGER,
      screen_id INTEGER,

      function_code TEXT NOT NULL,
      function_name TEXT NOT NULL,
      function_type TEXT NOT NULL,
      -- ui_button, api_test, kpi_update, db_update, agent_fix, report_generate

      purpose_text TEXT,
      input_json TEXT,
      expected_output_json TEXT,

      related_api_route TEXT,
      related_api_method TEXT,

      handler_file_path TEXT,
      handler_function_name TEXT,

      run_command TEXT,
      success_condition_text TEXT,

      stores_result_in_table TEXT,
      stores_result_field TEXT,

      last_run_status TEXT DEFAULT 'not_run',
      last_run_at TEXT,
      last_error TEXT,

      proof_log_path TEXT,
      proof_json TEXT,

      created_at TEXT DEFAULT CURRENT_TIMESTAMP,

      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE SET NULL,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE SET NULL,

      UNIQUE(function_code)
    );
    """)

    # 2. Create kpi_results table
    print("Creating table 'kpi_results'...")
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS kpi_results (
      id INTEGER PRIMARY KEY AUTOINCREMENT,

      app_id INTEGER,
      screen_id INTEGER,
      function_id INTEGER,

      kpi_code TEXT NOT NULL,
      kpi_name TEXT NOT NULL,

      kpi_value TEXT,
      kpi_status TEXT,
      -- passed, failed, warning

      measured_at TEXT DEFAULT CURRENT_TIMESTAMP,

      proof_json TEXT,
      proof_log_path TEXT,

      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE SET NULL,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE SET NULL,
      FOREIGN KEY (function_id) REFERENCES governance_functions(id) ON DELETE SET NULL
    );
    """)

    # 3. Create agent_function_runs table
    print("Creating table 'agent_function_runs'...")
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS agent_function_runs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,

      function_id INTEGER NOT NULL,
      task_id INTEGER,

      agent_name TEXT,
      run_status TEXT DEFAULT 'started',

      command_run TEXT,
      output_log TEXT,
      error_log TEXT,

      files_changed_text TEXT,
      db_updates_text TEXT,

      started_at TEXT DEFAULT CURRENT_TIMESTAMP,
      completed_at TEXT,

      FOREIGN KEY (function_id) REFERENCES governance_functions(id) ON DELETE CASCADE,
      FOREIGN KEY (task_id) REFERENCES implementation_tasks(id) ON DELETE SET NULL
    );
    """)

    # 4. Seed initial functions
    print("Seeding initial 4 functions in 'governance_functions'...")
    initial_funcs = [
        ('test_public_urls', 'Test Public App URLs', 'kpi_update',
         'Check all public deployed URLs return HTTP 200 and load app shell.',
         'node scripts/test_public_urls.js',
         'All URLs return 200 and load within limit.',
         'kpi_results'),

        ('test_api_endpoints', 'Test API Endpoints', 'api_test',
         'Call API endpoints directly without UI and verify response status/data.',
         'node scripts/test_api_endpoints.js',
         'All required APIs return expected status and JSON.',
         'kpi_results'),

        ('verify_screen_runtime', 'Verify Screen Runtime', 'agent_fix',
         'Open screen, click buttons, verify data/API/save and proof.',
         'node scripts/verify_screens.js',
         'Screen opens, data loads, buttons work, proof saved.',
         'screens'),

        ('update_screen_kpis', 'Update Screen KPI Fields', 'kpi_update',
         'Calculate load time, API latency, render time, complexity, LOC.',
         'node scripts/update_screen_kpis.js',
         'KPI fields updated in SQLite.',
         'screens')
    ]

    for code, name, ftype, purpose, cmd, success, target_table in initial_funcs:
        cursor.execute("""
            INSERT INTO governance_functions 
            (function_code, function_name, function_type, purpose_text, run_command, success_condition_text, stores_result_in_table, app_id)
            VALUES (?, ?, ?, ?, ?, ?, ?, 1)
            ON CONFLICT(function_code) DO UPDATE SET
                function_name=excluded.function_name,
                function_type=excluded.function_type,
                purpose_text=excluded.purpose_text,
                run_command=excluded.run_command,
                success_condition_text=excluded.success_condition_text,
                stores_result_in_table=excluded.stores_result_in_table;
        """, (code, name, ftype, purpose, cmd, success, target_table))

    conn.commit()
    conn.close()
    print("SUCCESS: Tables initialized and initial functions seeded!")

if __name__ == '__main__':
    init_tables()
