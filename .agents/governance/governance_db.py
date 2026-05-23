import sqlite3
import os

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def get_connection():
    """Returns a connection to the SQLite database with Foreign Keys enabled."""
    conn = sqlite3.connect(DB_PATH)
    conn.execute("PRAGMA foreign_keys = ON;")
    conn.row_factory = sqlite3.Row
    return conn

def init_db(force_reset=False):
    """Initializes the SQLite database schemas for the Ultimate Software Governance Engine (19 Tables)."""
    conn = get_connection()
    cursor = conn.cursor()
    
    if force_reset:
        print("Force resetting SQLite tables...")
        cursor.execute("PRAGMA foreign_keys = OFF;")
        
        tables_to_drop = [
            "governance_reports",
            "governance_snapshots",
            "implementation_tasks",
            "drift_findings",
            "test_cases",
            "role_function_permissions",
            "role_screen_permissions",
            "screen_functions",
            "screen_components",
            "db_schema_columns",
            "db_schema_tables",
            "screen_api_links",
            "api_endpoints",
            "screen_file_links",
            "code_files",
            "screens",
            "roles",
            "apps",
            "orgs"
        ]
        for t in tables_to_drop:
            cursor.execute(f"DROP TABLE IF EXISTS [{t}];")
            
        cursor.execute("PRAGMA foreign_keys = ON;")
        conn.commit()

    # 1. Orgs
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS orgs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      org_code TEXT UNIQUE NOT NULL,
      org_name TEXT NOT NULL,
      status TEXT DEFAULT 'active',
      created_at TEXT DEFAULT CURRENT_TIMESTAMP
    );
    """)

    # 2. Apps
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS apps (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      org_id INTEGER NOT NULL,
      app_code TEXT NOT NULL,
      app_name TEXT NOT NULL,
      platform TEXT,
      framework TEXT,
      repo_name TEXT,
      root_path TEXT,
      status TEXT DEFAULT 'active',
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (org_id) REFERENCES orgs(id) ON DELETE CASCADE,
      UNIQUE(org_id, app_code)
    );
    """)

    # 3. Roles
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS roles (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      org_id INTEGER NOT NULL,
      role_code TEXT NOT NULL,
      role_name TEXT NOT NULL,
      role_level INTEGER DEFAULT 1,
      status TEXT DEFAULT 'active',
      FOREIGN KEY (org_id) REFERENCES orgs(id) ON DELETE CASCADE,
      UNIQUE(org_id, role_code)
    );
    """)

    # 4. Screens
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS screens (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      screen_code TEXT NOT NULL,
      screen_name TEXT NOT NULL,
      route_path TEXT NOT NULL,
      layout_key TEXT,
      screen_type TEXT,
      implementation_status TEXT DEFAULT 'planned',
      file_path TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE,
      UNIQUE(app_id, screen_code),
      UNIQUE(app_id, route_path)
    );
    """)

    # 5. Code Files
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS code_files (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      file_name TEXT NOT NULL,
      file_path TEXT NOT NULL,
      file_type TEXT,
      language TEXT,
      folder_path TEXT,
      is_generated INTEGER DEFAULT 0,
      status TEXT DEFAULT 'active',
      last_scanned_at TEXT,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE,
      UNIQUE(app_id, file_path)
    );
    """)

    # 6. Screen File Links
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS screen_file_links (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      screen_id INTEGER NOT NULL,
      file_id INTEGER NOT NULL,
      link_type TEXT,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE,
      FOREIGN KEY (file_id) REFERENCES code_files(id) ON DELETE CASCADE,
      UNIQUE(screen_id, file_id)
    );
    """)

    # 7. API Endpoints
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS api_endpoints (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      endpoint_code TEXT,
      route_path TEXT NOT NULL,
      http_method TEXT NOT NULL,
      controller_name TEXT,
      service_name TEXT,
      auth_required INTEGER DEFAULT 1,
      implementation_status TEXT DEFAULT 'planned',
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE,
      UNIQUE(app_id, route_path, http_method)
    );
    """)

    # 8. Screen API Links
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS screen_api_links (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      screen_id INTEGER NOT NULL,
      api_id INTEGER NOT NULL,
      purpose TEXT,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE,
      FOREIGN KEY (api_id) REFERENCES api_endpoints(id) ON DELETE CASCADE,
      UNIQUE(screen_id, api_id)
    );
    """)

    # 9. DB Tables Registry
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS db_schema_tables (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      table_name TEXT NOT NULL,
      table_type TEXT,
      status TEXT DEFAULT 'active',
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE,
      UNIQUE(app_id, table_name)
    );
    """)

    # 10. DB Columns Registry
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS db_schema_columns (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      table_id INTEGER NOT NULL,
      column_name TEXT NOT NULL,
      data_type TEXT NOT NULL,
      is_nullable INTEGER DEFAULT 1,
      is_primary INTEGER DEFAULT 0,
      is_foreign INTEGER DEFAULT 0,
      default_value TEXT,
      foreign_table_name TEXT,
      foreign_column_name TEXT,
      FOREIGN KEY (table_id) REFERENCES db_schema_tables(id) ON DELETE CASCADE,
      UNIQUE(table_id, column_name)
    );
    """)

    # 11. Components
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS screen_components (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      screen_id INTEGER NOT NULL,
      component_code TEXT NOT NULL,
      component_name TEXT NOT NULL,
      component_type TEXT,
      data_cy TEXT,
      file_path TEXT,
      implementation_status TEXT DEFAULT 'planned',
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE,
      UNIQUE(screen_id, component_code)
    );
    """)

    # 12. Functions / Actions
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS screen_functions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      screen_id INTEGER NOT NULL,
      function_code TEXT NOT NULL,
      function_name TEXT NOT NULL,
      function_type TEXT,
      api_id INTEGER,
      implementation_status TEXT DEFAULT 'planned',
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE,
      FOREIGN KEY (api_id) REFERENCES api_endpoints(id) ON DELETE SET NULL,
      UNIQUE(screen_id, function_code)
    );
    """)

    # 13. Role Screen Permissions
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS role_screen_permissions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      role_id INTEGER NOT NULL,
      screen_id INTEGER NOT NULL,
      can_view INTEGER DEFAULT 0,
      can_create INTEGER DEFAULT 0,
      can_edit INTEGER DEFAULT 0,
      can_delete INTEGER DEFAULT 0,
      can_export INTEGER DEFAULT 0,
      FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE,
      UNIQUE(role_id, screen_id)
    );
    """)

    # 14. Function Permissions
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS role_function_permissions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      role_id INTEGER NOT NULL,
      function_id INTEGER NOT NULL,
      can_execute INTEGER DEFAULT 0,
      FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
      FOREIGN KEY (function_id) REFERENCES screen_functions(id) ON DELETE CASCADE,
      UNIQUE(role_id, function_id)
    );
    """)

    # 15. Test Cases
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS test_cases (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      test_name TEXT NOT NULL,
      test_type TEXT,
      file_path TEXT,
      related_screen_id INTEGER,
      related_api_id INTEGER,
      status TEXT DEFAULT 'active',
      last_run_status TEXT,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE,
      FOREIGN KEY (related_screen_id) REFERENCES screens(id) ON DELETE SET NULL,
      FOREIGN KEY (related_api_id) REFERENCES api_endpoints(id) ON DELETE SET NULL
    );
    """)

    # 16. Drift Findings
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS drift_findings (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      finding_type TEXT NOT NULL,
      severity TEXT DEFAULT 'medium',
      related_screen_id INTEGER,
      related_file_id INTEGER,
      related_api_id INTEGER,
      message TEXT NOT NULL,
      status TEXT DEFAULT 'open',
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE,
      FOREIGN KEY (related_screen_id) REFERENCES screens(id) ON DELETE SET NULL,
      FOREIGN KEY (related_file_id) REFERENCES code_files(id) ON DELETE SET NULL,
      FOREIGN KEY (related_api_id) REFERENCES api_endpoints(id) ON DELETE SET NULL
    );
    """)

    # 17. AI Agent Tasks
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS implementation_tasks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      task_title TEXT NOT NULL,
      task_description TEXT,
      priority TEXT DEFAULT 'medium',
      task_type TEXT,
      related_screen_id INTEGER,
      related_api_id INTEGER,
      related_file_id INTEGER,
      assigned_agent TEXT,
      status TEXT DEFAULT 'pending',
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE,
      FOREIGN KEY (related_screen_id) REFERENCES screens(id) ON DELETE SET NULL,
      FOREIGN KEY (related_api_id) REFERENCES api_endpoints(id) ON DELETE SET NULL,
      FOREIGN KEY (related_file_id) REFERENCES code_files(id) ON DELETE SET NULL
    );
    """)

    # 18. Governance Snapshots
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS governance_snapshots (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      snapshot_name TEXT,
      snapshot_type TEXT,
      snapshot_json TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE
    );
    """)

    # 19. Governance Reports
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS governance_reports (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      report_name TEXT,
      report_type TEXT,
      html_report_path TEXT,
      generated_by TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE
    );
    """)

    # Create optimized indexing structures
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_apps_org ON apps(org_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_roles_org ON roles(org_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_screens_app ON screens(app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_code_files_app ON code_files(app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_api_endpoints_app ON api_endpoints(app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_db_schema_tables_app ON db_schema_tables(app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_permissions_role ON role_screen_permissions(role_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_permissions_screen ON role_screen_permissions(screen_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_components_screen ON screen_components(screen_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_functions_screen ON screen_functions(screen_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_drift_findings_app ON drift_findings(app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_tasks_app ON implementation_tasks(app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_snapshots_app ON governance_snapshots(app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_reports_app ON governance_reports(app_id);")

    conn.commit()
    conn.close()
    print("PrimeCare 19-Table Relational Ultimate SQLite Database schemas initialized.")

if __name__ == "__main__":
    init_db()
