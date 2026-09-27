import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def upgrade_database():
    print("=====================================================")
    print("Executing Stage 6 Quality & Logic Metrics Migration")
    print("=====================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: SQLite database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    # 1. Alter screens table to add all 22 columns + 8 runtime columns (Self-healing)
    new_columns = [
        ("code_scan_status", "TEXT DEFAULT 'pending'"),
        ("real_code_found", "INTEGER DEFAULT 0"),
        ("real_component_count", "INTEGER DEFAULT 0"),
        ("real_button_count", "INTEGER DEFAULT 0"),
        ("real_api_call_count", "INTEGER DEFAULT 0"),
        ("empty_placeholder_detected", "INTEGER DEFAULT 0"),
        ("hardcoded_mock_data_detected", "INTEGER DEFAULT 0"),
        ("fake_handler_detected", "INTEGER DEFAULT 0"),
        ("null_onpressed_detected", "INTEGER DEFAULT 0"),
        ("real_business_logic_found", "INTEGER DEFAULT 0"),
        ("provider_or_controller_found", "INTEGER DEFAULT 0"),
        ("repository_or_service_found", "INTEGER DEFAULT 0"),
        ("runtime_clicked", "INTEGER DEFAULT 0"),
        ("runtime_data_loaded", "INTEGER DEFAULT 0"),
        ("runtime_api_success", "INTEGER DEFAULT 0"),
        ("runtime_save_tested", "INTEGER DEFAULT 0"),
        ("implementation_depth_score", "INTEGER DEFAULT 0"),
        ("implementation_depth_status", "TEXT DEFAULT 'not_checked'"),
        ("code_evidence_text", "TEXT"),
        ("missing_implementation_text", "TEXT"),
        ("agent_next_action", "TEXT"),
        # New Runtime Columns
        ("runtime_opened", "INTEGER DEFAULT 0"),
        ("runtime_navigation_tested", "INTEGER DEFAULT 0"),
        ("runtime_form_submit_tested", "INTEGER DEFAULT 0"),
        ("runtime_search_tested", "INTEGER DEFAULT 0"),
        ("runtime_table_loaded", "INTEGER DEFAULT 0"),
        ("runtime_modal_tested", "INTEGER DEFAULT 0"),
        ("runtime_permission_tested", "INTEGER DEFAULT 0"),
        ("runtime_verification_score", "INTEGER DEFAULT 0")
    ]

    cursor.execute("PRAGMA table_info(screens);")
    existing_cols = [row['name'] for row in cursor.fetchall()]

    for col_name, col_def in new_columns:
        if col_name not in existing_cols:
            print(f"Adding column '{col_name}' to 'screens' table...")
            cursor.execute(f"ALTER TABLE screens ADD COLUMN {col_name} {col_def};")
        else:
            print(f"Column '{col_name}' already exists.")

    conn.commit()

    # 2. Deploy relational quality view
    print("Deploying view 'v_screens_need_real_code_check'...")
    cursor.execute("DROP VIEW IF EXISTS v_screens_need_real_code_check;")
    cursor.execute("""
    CREATE VIEW v_screens_need_real_code_check AS
    SELECT
      id,
      app_id,
      role_id,
      screen_code,
      screen_name,
      actual_file_path,
      screen_type,
      verification_status,
      implementation_depth_score,
      implementation_depth_status,
      agent_next_action
    FROM screens
    WHERE implementation_depth_status != 'verified'
       OR implementation_depth_status IS NULL
       OR empty_placeholder_detected = 1
       OR fake_handler_detected = 1
       OR null_onpressed_detected = 1
       OR runtime_clicked = 0
       OR runtime_data_loaded = 0;
    """)

    conn.commit()
    print("Quality view successfully deployed.")

    # 3. Seed deep code verification tasks for all unverified screens
    print("Seeding 'deep_code_verification' tasks...")
    # Clean out any old/unfinished ones first to prevent duplication
    cursor.execute("DELETE FROM implementation_tasks WHERE task_type = 'deep_code_verification';")
    
    cursor.execute("""
    INSERT INTO implementation_tasks (
      app_id, 
      task_title, 
      task_description, 
      priority, 
      task_type, 
      related_screen_id, 
      assigned_agent, 
      status, 
      created_at
    )
    SELECT
      app_id,
      'Deep code verification: ' || screen_name,
      'Open real file, verify components, buttons, APIs, business logic, runtime click, data load, and update implementation depth fields.',
      'high',
      'deep_code_verification',
      id,
      'antigravity_agent',
      'pending',
      CURRENT_TIMESTAMP
    FROM screens
    WHERE implementation_depth_status IS NULL
       OR implementation_depth_status != 'verified';
    """)
    
    conn.commit()
    
    cursor.execute("SELECT COUNT(*) FROM implementation_tasks WHERE task_type = 'deep_code_verification';")
    task_count = cursor.fetchone()[0]
    print(f"Successfully enqueued {task_count} deep code verification tasks.")

    conn.close()
    print("\nMigration Completed. Database upgraded to Stage 6 quality parameters!")

if __name__ == "__main__":
    upgrade_database()
