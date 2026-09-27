import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("==============================================================")
    print("PRIMECARE GOVERNANCE: STAGE 17 DDL MIGRATIONS & SEEDING")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # 1. Extend apps table
    app_cols = [
        ("default_layout_key", "TEXT"),
        ("app_shell_type", "TEXT"),
        ("theme_config_json", "TEXT"),
        ("branding_json", "TEXT")
    ]

    print("Altering apps table...")
    for col, col_type in app_cols:
        try:
            cursor.execute(f"ALTER TABLE apps ADD COLUMN {col} {col_type};")
            print(f"  Added column {col} to apps.")
        except sqlite3.OperationalError as e:
            if "duplicate column name" in str(e):
                print(f"  Column {col} already exists in apps. Skipping.")
            else:
                print(f"  Error adding {col}: {e}")

    # 2. Extend roles table
    role_cols = [
        ("topbar_config_json", "TEXT"),
        ("sidebar_config_json", "TEXT"),
        ("default_dashboard_screen_code", "TEXT"),
        ("allowed_menu_json", "TEXT"),
        ("role_layout_key", "TEXT"),
        ("navigation_style", "TEXT")
    ]

    print("\nAltering roles table...")
    for col, col_type in role_cols:
        try:
            cursor.execute(f"ALTER TABLE roles ADD COLUMN {col} {col_type};")
            print(f"  Added column {col} to roles.")
        except sqlite3.OperationalError as e:
            if "duplicate column name" in str(e):
                print(f"  Column {col} already exists in roles. Skipping.")
            else:
                print(f"  Error adding {col}: {e}")

    # 3. Extend screens table
    screen_cols = [
        ("content_layout_type", "TEXT"),
        ("requires_sidebar", "INTEGER DEFAULT 1"),
        ("requires_topbar", "INTEGER DEFAULT 1"),
        ("parent_layout_key", "TEXT"),
        ("menu_label", "TEXT"),
        ("menu_icon", "TEXT"),
        ("menu_order", "INTEGER DEFAULT 0"),
        ("show_in_sidebar", "INTEGER DEFAULT 1")
    ]

    print("\nAltering screens table...")
    for col, col_type in screen_cols:
        try:
            cursor.execute(f"ALTER TABLE screens ADD COLUMN {col} {col_type};")
            print(f"  Added column {col} to screens.")
        except sqlite3.OperationalError as e:
            if "duplicate column name" in str(e):
                print(f"  Column {col} already exists in screens. Skipping.")
            else:
                print(f"  Error adding {col}: {e}")

    # 4. Seed three new governance functions
    print("\nSeeding Stage 17 governance functions...")
    functions_to_seed = [
        (
         'audit_role_navigation',
         'Audit Role Navigation Configuration',
         'role_nav_audit',
         'Scan all roles, generate high-fidelity topbar, sidebar, and allowed menu JSON hierarchies, and document role layouts.',
         'roles',
         'SELECT id, role_code, role_name FROM roles;',
         'python tools/governance/audit_role_navigation.py',
         'Roles populated with topbar, sidebar, allowed menu, and navigation style JSON structures.',
         'All roles in database are documented with navigation structures.',
         'roles',
         'topbar_config_json,sidebar_config_json,default_dashboard_screen_code,allowed_menu_json,role_layout_key,navigation_style',
         'json_log',
         'tools/governance/reports/role_navigation_report.json',
         110
        ),
        (
         'configure_app_shells',
         'Configure Application Shells & Branding',
         'app_shell_config',
         'Generate dynamic theme config and branding details for all sub-portal applications under apps table.',
         'apps',
         'SELECT id, app_code, app_name FROM apps;',
         'python tools/governance/configure_app_shells.py',
         'Apps populated with brand configuration, layout keys, and shell types.',
         'All active applications are documented with premium brand configuration.',
         'apps',
         'default_layout_key,app_shell_type,theme_config_json,branding_json',
         'json_log',
         'tools/governance/reports/app_shells_report.json',
         120
        ),
        (
         'reconcile_screen_layouts',
         'Reconcile Screen Content Layouts',
         'screen_layout_reconcile',
         'Scan all visual screens, align content layout types, required sidebar/topbar settings, menu labels, icons, orders, and visibilities.',
         'screens',
         'SELECT id, screen_name, screen_type FROM screens;',
         'python tools/governance/reconcile_screen_layouts.py',
         'Screens populated with content layout styles, sidebar/topbar expectations, and menu positioning indicators.',
         'All active screens are reconciled with appropriate content layout mappings and menu settings.',
         'screens',
         'content_layout_type,requires_sidebar,requires_topbar,parent_layout_key,menu_label,menu_icon,menu_order,show_in_sidebar',
         'json_log',
         'tools/governance/reports/screen_layouts_report.json',
         130
        )
    ]

    for row in functions_to_seed:
        try:
            cursor.execute("""
            INSERT INTO governance_functions
            (function_code, function_name, function_type, purpose_text, input_source, input_query, run_command, expected_output_text, success_condition_text, updates_table, updates_fields_text, proof_type, proof_output_path, run_order)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
            """, row)
            print(f"  Seeded governance function: {row[0]}")
        except sqlite3.IntegrityError:
            cursor.execute("""
            UPDATE governance_functions
            SET function_name = ?,
                function_type = ?,
                purpose_text = ?,
                input_source = ?,
                input_query = ?,
                run_command = ?,
                expected_output_text = ?,
                success_condition_text = ?,
                updates_table = ?,
                updates_fields_text = ?,
                proof_type = ?,
                proof_output_path = ?,
                run_order = ?,
                last_run_status = 'pending',
                last_run_at = NULL,
                last_error = NULL
            WHERE function_code = ?;
            """, row[1:] + (row[0],))
            print(f"  Updated and reset governance function: {row[0]}")

    conn.commit()
    conn.close()
    print("\nStage 17 migrations and seeding complete.")

if __name__ == '__main__':
    main()
