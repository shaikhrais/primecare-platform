# Scripts - Category: remodel | Purpose: Remodel the SQLite database to collapse screen metadata, functions, permissions, and file checks into one single master screens table.
import os
import sqlite3
import json

# Absolute path resolution relative to project root
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

ALLOWED_TABLES = {
    "orgs",
    "apps",
    "roles",
    "screens",
    "api_endpoints",
    "code_files",
    "implementation_tasks",
    "governance_findings",
    "test_cases",
    "release_operations",
    "governance_reports",
    "governance_health_scores"
}

def consolidate_to_12_tables():
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    # Disable foreign keys temporarily during schema remodeling
    cursor.execute("PRAGMA foreign_keys = OFF;")

    # 1. Fetch current screens data
    print("Fetching screens data...")
    cursor.execute("SELECT * FROM screens;")
    old_screens = cursor.fetchall()
    print(f"  Loaded {len(old_screens)} screens from current registry.")

    # 2. Re-create screens table with consolidated columns
    print("Re-creating screens table with collapsed columns...")
    cursor.execute("DROP TABLE IF EXISTS screens_temp;")
    cursor.execute("""
    CREATE TABLE screens_temp (
      id INTEGER PRIMARY KEY AUTOINCREMENT,

      app_id INTEGER NOT NULL,
      role_id INTEGER,

      screen_code TEXT NOT NULL,
      screen_name TEXT NOT NULL,

      route_path TEXT,

      expected_file_path TEXT,
      actual_file_path TEXT,

      screen_type TEXT, -- dashboard, crud, workflow, analytics

      -- REAL VERIFICATION
      file_exists INTEGER DEFAULT 0,
      import_works INTEGER DEFAULT 0,
      class_exists INTEGER DEFAULT 0,
      route_exists INTEGER DEFAULT 0,
      widget_exported INTEGER DEFAULT 0,
      widget_renders INTEGER DEFAULT 0,

      -- COMPONENTS
      component_list_text TEXT,
      component_behavior_text TEXT,
      component_audit_json TEXT,

      -- BUTTONS / FUNCTIONS
      button_list_text TEXT,
      function_list_text TEXT,
      function_audit_json TEXT,

      -- APIS
      api_call_list_text TEXT,
      api_audit_json TEXT,

      -- ROLE ACCESS
      allowed_roles_text TEXT,

      -- RESPONSIVE
      supports_4k INTEGER DEFAULT 0,
      supports_3k INTEGER DEFAULT 0,
      supports_2k INTEGER DEFAULT 0,
      supports_1k INTEGER DEFAULT 0,
      supports_tablet INTEGER DEFAULT 0,
      supports_mobile INTEGER DEFAULT 0,

      -- STATUS
      screen_status TEXT DEFAULT 'planned',
      verification_status TEXT DEFAULT 'pending',

      -- PROBLEMS
      problem_summary TEXT,
      suggested_fix TEXT,

      -- PROOF
      proof_log_path TEXT,
      screenshot_path TEXT,

      last_checked_at TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,

      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE,
      FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE SET NULL,
      UNIQUE(app_id, screen_code)
    );
    """)

    # 3. For each screen, aggregate data from old child tables and migrate
    migrated_count = 0
    for scr in old_screens:
        scr_id = scr['id']
        app_id = scr['app_id']
        role_id = None
        screen_code = scr['screen_code']
        screen_name = scr['screen_name']
        route_path = scr['route_path']
        screen_type = scr['screen_type']
        file_path = scr['file_path']
        implementation_status = scr['implementation_status'] or 'planned'
        created_at = scr['created_at']

        # Determine if role_id is None, query it from role_screen_permissions fallback if missing
        if not role_id:
            cursor.execute("SELECT role_id FROM role_screen_permissions WHERE screen_id = ? LIMIT 1;", (scr_id,))
            role_row = cursor.fetchone()
            if role_row:
                role_id = role_row['role_id']

        # A. Query Allowed Roles (RBAC)
        cursor.execute("""
            SELECT r.role_code 
            FROM role_screen_permissions rsp 
            JOIN roles r ON rsp.role_id = r.id 
            WHERE rsp.screen_id = ?;
        """, (scr_id,))
        roles_rows = cursor.fetchall()
        allowed_roles_text = ", ".join([r['role_code'] for r in roles_rows]) if roles_rows else None

        # B. Query Screen Functions & APIs
        cursor.execute("SELECT * FROM screen_functions WHERE screen_id = ?;", (scr_id,))
        funcs_rows = cursor.fetchall()
        
        function_list = []
        function_audit = []
        api_calls = []
        api_audit = []
        button_list = []

        for idx, fn in enumerate(funcs_rows):
            f_code = fn['function_code']
            f_name = fn['function_name']
            f_type = fn['function_type'] or 'callback'
            api_id = fn['api_id']
            
            function_list.append(f"{idx+1}. {f_code} - {f_name}")
            function_audit.append({
                "code": f_code,
                "name": f_name,
                "type": f_type,
                "expected_result": fn['expected_result'] or "HTTP 200 OK"
            })
            
            if 'button' in f_type.lower() or 'button' in f_code.lower() or 'button' in f_name.lower():
                button_list.append(f_name)

            if api_id:
                # Retrieve api route path
                cursor.execute("SELECT route_path, http_method FROM api_endpoints WHERE id = ?;", (api_id,))
                api_row = cursor.fetchone()
                if api_row:
                    api_call_desc = f"{api_row['http_method']} {api_row['route_path']}"
                    api_calls.append(api_call_desc)
                    api_audit.append({
                        "id": api_id,
                        "method": api_row['http_method'],
                        "route": api_row['route_path']
                    })

        function_list_text = "\n".join(function_list) if function_list else None
        function_audit_json = json.dumps(function_audit) if function_audit else None
        button_list_text = ", ".join(button_list) if button_list else None
        
        api_call_list_text = ", ".join(list(set(api_calls))) if api_calls else None
        api_audit_json = json.dumps(api_audit) if api_audit else None

        # C. Query File Verification Checks
        cursor.execute("SELECT * FROM file_verification_checks WHERE screen_id = ? LIMIT 1;", (scr_id,))
        chk = cursor.fetchone()

        file_exists = 0
        import_works = 0
        class_exists = 0
        route_exists = 0
        widget_exported = 0
        widget_renders = 0
        
        component_list_text = None
        component_behavior_text = None
        component_audit_json = None
        
        verification_status = 'pending'
        problem_summary = None
        suggested_fix = None
        proof_log_path = None
        last_checked_at = None
        actual_file_path = None

        if chk:
            file_exists = chk['file_exists'] or 0
            import_works = chk['import_works'] or 0
            class_exists = chk['class_exists'] or 0
            route_exists = chk['route_exists'] or 0
            widget_exported = chk['widget_exported'] or 0
            widget_renders = chk['widget_renders'] or 0
            
            component_list_text = chk['component_list_text']
            component_behavior_text = chk['component_behavior_text']
            component_audit_json = chk['component_audit_json']
            
            verification_status = chk['verification_status'] or 'pending'
            proof_log_path = chk['proof_log_path']
            last_checked_at = chk['checked_at']
            actual_file_path = file_path if file_exists else None

            if verification_status == 'failed':
                problem_summary = chk['error_message'] or "Physical file does not conform to standards"
                suggested_fix = "Verify physical StatefulWidget class declaration, export routes, and inject operational ElevatedButton callback widgets."

        # Map responsive supports (default: dashboard screens support all viewports, others standard)
        supports_all = 1 if (verification_status == 'passed' or screen_type == 'dashboard') else 0

        # Insert flat record into screens_temp
        cursor.execute("""
        INSERT INTO screens_temp (
            id, app_id, role_id, screen_code, screen_name, route_path, expected_file_path, actual_file_path,
            screen_type, file_exists, import_works, class_exists, route_exists, widget_exported, widget_renders,
            component_list_text, component_behavior_text, component_audit_json, button_list_text, function_list_text,
            function_audit_json, api_call_list_text, api_audit_json, allowed_roles_text, supports_4k, supports_3k,
            supports_2k, supports_1k, supports_tablet, supports_mobile, screen_status, verification_status,
            problem_summary, suggested_fix, proof_log_path, last_checked_at, created_at
        ) VALUES (
            ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
        );
        """, (
            scr_id, app_id, role_id, screen_code, screen_name, route_path, file_path, actual_file_path,
            screen_type, file_exists, import_works, class_exists, route_exists, widget_exported, widget_renders,
            component_list_text, component_behavior_text, component_audit_json, button_list_text, function_list_text,
            function_audit_json, api_call_list_text, api_audit_json, allowed_roles_text, supports_all, supports_all,
            supports_all, supports_all, supports_all, supports_all, implementation_status, verification_status,
            problem_summary, suggested_fix, proof_log_path, last_checked_at, created_at
        ))
        migrated_count += 1

    print(f"  Successfully migrated {migrated_count} screen rows into temporary master registry.")

    # 4. Swap tables and drop temporary schema
    print("\nSwapping screens table and dropping temporary schema...")
    cursor.execute("DROP VIEW IF EXISTS v_unverified_files;")
    cursor.execute("DROP VIEW IF EXISTS v_role_screen_coverage;")
    cursor.execute("DROP TABLE IF EXISTS screens;")
    cursor.execute("ALTER TABLE screens_temp RENAME TO screens;")

    # 5. Drop obsolete tables
    obsolete_tables = [
        "screen_verification_checks",
        "screen_file_links",
        "file_verification_checks",
        "screen_components",
        "component_connection_checks",
        "role_screen_permissions",
        "screen_functions"
    ]
    print(f"\nPruning obsolete tables: {obsolete_tables}...")
    for t in obsolete_tables:
        cursor.execute(f"DROP TABLE IF EXISTS {t};")

    # 6. Drop any other table not in ALLOWED_TABLES
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';")
    tables = [r[0] for r in cursor.fetchall()]
    for t in tables:
        if t not in ALLOWED_TABLES:
            print(f"Pruning extra table: {t}")
            cursor.execute(f"DROP TABLE IF EXISTS {t};")

    # 7. Drop and Recreate Views to support collapsed schema
    print("\nRebuilding database views...")
    cursor.execute("DROP VIEW IF EXISTS v_unverified_files;")
    cursor.execute("""
    CREATE VIEW v_unverified_files AS
    SELECT id, expected_file_path, screen_name, verification_status
    FROM screens
    WHERE verification_status != 'passed';
    """)

    cursor.execute("DROP VIEW IF EXISTS v_role_screen_coverage;")
    cursor.execute("""
    CREATE VIEW v_role_screen_coverage AS
    SELECT 
        r.id AS role_id,
        r.role_name,
        r.role_code,
        COUNT(s.id) AS screens_count,
        CASE 
            WHEN COUNT(s.id) >= 5 THEN 'good'
            WHEN COUNT(s.id) = 1 THEN 'only_dashboard'
            ELSE 'weak'
        END AS coverage_status
    FROM roles r
    LEFT JOIN screens s ON s.role_id = r.id OR (',' || s.allowed_roles_text || ',') LIKE ('%,' || r.role_code || ',%')
    GROUP BY r.id;
    """)

    # Re-enable foreign key constraints
    cursor.execute("PRAGMA foreign_keys = ON;")

    # 8. Commit and VACUUM
    print("\nExecuting database optimization (VACUUM)...")
    conn.commit()
    conn.isolation_level = None
    conn.execute("VACUUM;")
    conn.close()

    print("\nRelational Streamlining Complete. Exactly 12 tables and 2 views remain in governance.db.")

if __name__ == "__main__":
    consolidate_to_12_tables()
