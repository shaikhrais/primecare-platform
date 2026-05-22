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
    """Initializes the SQLite database schemas. If force_reset is True, tables are dropped first."""
    conn = get_connection()
    cursor = conn.cursor()
    
    if force_reset:
        print("Force resetting SQLite tables...")
        cursor.execute("PRAGMA foreign_keys = OFF;")
        
        # Drop 15 new tables in reverse dependency order
        cursor.execute("DROP TABLE IF EXISTS saved_reports;")
        cursor.execute("DROP TABLE IF EXISTS transactions;")
        cursor.execute("DROP TABLE IF EXISTS data_entries;")
        cursor.execute("DROP TABLE IF EXISTS governance_logs;")
        cursor.execute("DROP TABLE IF EXISTS function_components;")
        cursor.execute("DROP TABLE IF EXISTS screen_components;")
        cursor.execute("DROP TABLE IF EXISTS screen_functions;")
        cursor.execute("DROP TABLE IF EXISTS role_screen_permissions;")
        cursor.execute("DROP TABLE IF EXISTS sidebar_items;")
        cursor.execute("DROP TABLE IF EXISTS screens;")
        cursor.execute("DROP TABLE IF EXISTS app_roles;")
        cursor.execute("DROP TABLE IF EXISTS roles;")
        cursor.execute("DROP TABLE IF EXISTS apps;")
        cursor.execute("DROP TABLE IF EXISTS offices;")
        cursor.execute("DROP TABLE IF EXISTS orgs;")
        
        # Drop previous Level 1 to 4 tables
        cursor.execute("DROP TABLE IF EXISTS L4_rsi_functions_components;")
        cursor.execute("DROP TABLE IF EXISTS L3_roles__sidebar_items;")
        cursor.execute("DROP TABLE IF EXISTS L2_roles;")
        cursor.execute("DROP TABLE IF EXISTS L1_app;")
        
        # Drop old prefixed tables
        cursor.execute("DROP TABLE IF EXISTS c_sidebar_items;")
        cursor.execute("DROP TABLE IF EXISTS b_roles;")
        cursor.execute("DROP TABLE IF EXISTS a_apps;")
        
        # Drop original legacy tables
        cursor.execute("DROP TABLE IF EXISTS functions;")
        cursor.execute("DROP TABLE IF EXISTS components;")
        cursor.execute("DROP TABLE IF EXISTS features;")
        cursor.execute("DROP TABLE IF EXISTS fields;")
        cursor.execute("DROP TABLE IF EXISTS pages;")
        cursor.execute("DROP TABLE IF EXISTS intents;")
        cursor.execute("DROP TABLE IF EXISTS dashboards;")
        cursor.execute("DROP TABLE IF EXISTS sidebar_items_legacy;")
        cursor.execute("DROP TABLE IF EXISTS roles_legacy;")
        cursor.execute("DROP TABLE IF EXISTS apps_legacy;")
        
        cursor.execute("PRAGMA foreign_keys = ON;")
        conn.commit()

    # 1. ORGANIZATION
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS orgs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      org_code TEXT UNIQUE NOT NULL,
      org_name TEXT NOT NULL,
      status TEXT DEFAULT 'active',
      created_at TEXT DEFAULT CURRENT_TIMESTAMP
    );
    """)

    # 2. OFFICES / BUSINESS UNITS
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS offices (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      org_id INTEGER NOT NULL,
      office_code TEXT NOT NULL,
      office_name TEXT NOT NULL,
      office_type TEXT, -- corporate, franchise, clinic, support
      status TEXT DEFAULT 'active',
      FOREIGN KEY (org_id) REFERENCES orgs(id) ON DELETE CASCADE,
      UNIQUE(org_id, office_code)
    );
    """)

    # 3. APPS
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS apps (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      org_id INTEGER NOT NULL,
      app_code TEXT NOT NULL,
      app_name TEXT NOT NULL,
      platform TEXT, -- web, mobile, admin, worker
      status TEXT DEFAULT 'active',
      FOREIGN KEY (org_id) REFERENCES orgs(id) ON DELETE CASCADE,
      UNIQUE(org_id, app_code)
    );
    """)

    # 4. ROLES
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

    # 5. APP ROLE ACCESS
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS app_roles (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      role_id INTEGER NOT NULL,
      can_access INTEGER DEFAULT 1,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE,
      FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
      UNIQUE(app_id, role_id)
    );
    """)

    # 6. SCREENS
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS screens (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      screen_code TEXT NOT NULL, -- GLB-101, PSW-201
      screen_name TEXT NOT NULL,
      route_path TEXT NOT NULL,
      screen_type TEXT, -- dashboard, form, list, detail, report
      layout_key TEXT, -- masterLayout, clinicalLayout, adminLayout
      status TEXT DEFAULT 'active',
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE,
      UNIQUE(app_id, screen_code),
      UNIQUE(app_id, route_path)
    );
    """)

    # 7. SIDEBAR MENU
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS sidebar_items (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      parent_id INTEGER,
      screen_id INTEGER,
      label TEXT NOT NULL,
      icon TEXT,
      sort_order INTEGER DEFAULT 0,
      is_visible INTEGER DEFAULT 1,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE,
      FOREIGN KEY (parent_id) REFERENCES sidebar_items(id) ON DELETE CASCADE,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE SET NULL
    );
    """)

    # 8. ROLE SCREEN PERMISSION
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

    # 9. SCREEN FUNCTIONS
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS screen_functions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      screen_id INTEGER NOT NULL,
      function_code TEXT NOT NULL,
      function_name TEXT NOT NULL,
      function_type TEXT, -- button, api_action, shortcut, form_submit, export
      description TEXT,
      status TEXT DEFAULT 'active',
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE,
      UNIQUE(screen_id, function_code)
    );
    """)

    # 10. SCREEN COMPONENTS
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS screen_components (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      screen_id INTEGER NOT NULL,
      component_code TEXT NOT NULL,
      component_name TEXT NOT NULL,
      component_type TEXT, -- table, form, card, modal, chart, tab
      data_cy TEXT,
      sort_order INTEGER DEFAULT 0,
      is_required INTEGER DEFAULT 0,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE,
      UNIQUE(screen_id, component_code)
    );
    """)

    # 11. FUNCTION COMPONENT LINK
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS function_components (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      function_id INTEGER NOT NULL,
      component_id INTEGER NOT NULL,
      FOREIGN KEY (function_id) REFERENCES screen_functions(id) ON DELETE CASCADE,
      FOREIGN KEY (component_id) REFERENCES screen_components(id) ON DELETE CASCADE,
      UNIQUE(function_id, component_id)
    );
    """)

    # 12. GOVERNANCE AUDIT LOG
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS governance_logs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      org_id INTEGER NOT NULL,
      app_id INTEGER,
      screen_id INTEGER,
      log_type TEXT, -- drift, missing_route, duplicate_component, permission_error
      message TEXT NOT NULL,
      severity TEXT DEFAULT 'medium',
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (org_id) REFERENCES orgs(id) ON DELETE CASCADE,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE SET NULL,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE SET NULL
    );
    """)

    # 13. DATA ENTRIES LOG (Who did what, from which form, when)
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS data_entries (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      org_id INTEGER NOT NULL,
      app_id INTEGER NOT NULL,
      screen_id INTEGER NOT NULL,
      role_id INTEGER,
      user_id TEXT,
      entry_type TEXT NOT NULL, -- client_intake, visit_note, invoice, booking
      record_ref TEXT,          -- actual business record ID
      status TEXT DEFAULT 'draft', -- draft, submitted, approved, rejected
      data_json TEXT NOT NULL,  -- saved form data as JSON
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (org_id) REFERENCES orgs(id) ON DELETE CASCADE,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE,
      FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE SET NULL
    );
    """)

    # 14. TRANSACTIONS HISTORY (Action/Transaction ledger)
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS transactions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      org_id INTEGER NOT NULL,
      app_id INTEGER,
      screen_id INTEGER,
      user_id TEXT,
      role_id INTEGER,
      transaction_type TEXT NOT NULL, -- create, update, delete, approve, login
      entity_type TEXT NOT NULL,      -- client, booking, invoice, note
      entity_id TEXT,
      before_json TEXT,
      after_json TEXT,
      note TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (org_id) REFERENCES orgs(id) ON DELETE CASCADE,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE SET NULL,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE SET NULL,
      FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE SET NULL
    );
    """)

    # 15. SAVED REPORTS MEMORY (Compliance/Reporting memory)
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS saved_reports (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      org_id INTEGER NOT NULL,
      app_id INTEGER,
      report_name TEXT NOT NULL,
      report_type TEXT, -- daily, weekly, monthly, audit, revenue, user_activity
      filters_json TEXT,
      result_json TEXT,
      created_by TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (org_id) REFERENCES orgs(id) ON DELETE CASCADE,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE SET NULL
    );
    """)

    # Indexes
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_apps_org ON apps(org_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_roles_org ON roles(org_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_screens_app ON screens(app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_sidebar_app ON sidebar_items(app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_permissions_role ON role_screen_permissions(role_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_permissions_screen ON role_screen_permissions(screen_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_components_screen ON screen_components(screen_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_functions_screen ON screen_functions(screen_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_data_entries_org_app ON data_entries(org_id, app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_data_entries_screen ON data_entries(screen_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_transactions_org_user ON transactions(org_id, user_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_transactions_entity ON transactions(entity_type, entity_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_saved_reports_org ON saved_reports(org_id);")

    conn.commit()
    conn.close()
    print("PrimeCare 12-Table Relational SQLite Database schemas initialized.")

if __name__ == "__main__":
    init_db()
