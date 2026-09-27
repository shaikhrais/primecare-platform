import os
import sqlite3
import json
from datetime import datetime

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def now():
    return datetime.utcnow().isoformat() + "Z"

def main():
    print("==============================================================")
    print("PRIMECARE GOVERNANCE: COMPONENT GOVERNANCE SEEDER SWEEP")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # 1. Add summary fields to screens table if missing
    screen_cols = [
        ("component_count", "INTEGER DEFAULT 0"),
        ("required_component_count", "INTEGER DEFAULT 0"),
        ("tested_component_count", "INTEGER DEFAULT 0"),
        ("failed_component_count", "INTEGER DEFAULT 0"),
        ("component_governance_status", "TEXT DEFAULT 'pending'")
    ]
    print("Extending screens table with component summary columns...")
    for col, col_type in screen_cols:
        try:
            cursor.execute(f"ALTER TABLE screens ADD COLUMN {col} {col_type};")
            print(f"  Successfully added column {col} to screens.")
        except sqlite3.OperationalError as e:
            if "duplicate column name" in str(e):
                print(f"  Column {col} already exists. Skipping.")
            else:
                print(f"  Error adding {col}: {e}")

    # 2. Create ui_components table
    print("\nCreating ui_components table...")
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS ui_components (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER,
      screen_id INTEGER,

      component_code TEXT NOT NULL,
      component_name TEXT NOT NULL,
      component_type TEXT NOT NULL,
      -- shell, topbar, sidebar, button, form, field, table, card, modal, chart, list, loading, error, success

      data_cy TEXT,
      file_path TEXT,
      parent_component_code TEXT,

      expected_behavior TEXT,
      is_interactive INTEGER DEFAULT 0,
      is_required INTEGER DEFAULT 1,

      flutter_widget_test_path TEXT,
      cypress_visual_test_path TEXT,

      component_status TEXT DEFAULT 'planned',
      test_status TEXT DEFAULT 'not_run',

      proof_log_path TEXT,
      screenshot_path TEXT,

      created_at TEXT DEFAULT CURRENT_TIMESTAMP,

      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE SET NULL,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE,

      UNIQUE(screen_id, component_code)
    );
    """)
    print("  Table ui_components verified/created successfully.")

    # 3. Create component_test_cases table
    print("\nCreating component_test_cases table...")
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS component_test_cases (
      id INTEGER PRIMARY KEY AUTOINCREMENT,

      component_id INTEGER NOT NULL,
      test_code TEXT NOT NULL,
      test_name TEXT NOT NULL,
      test_type TEXT NOT NULL,
      -- flutter_widget, cypress_visual, accessibility, responsive, interaction

      test_command TEXT,
      expected_result TEXT,

      status TEXT DEFAULT 'not_run',
      last_run_at TEXT,
      proof_log_path TEXT,
      screenshot_path TEXT,
      error_message TEXT,

      FOREIGN KEY (component_id) REFERENCES ui_components(id) ON DELETE CASCADE,

      UNIQUE(component_id, test_code)
    );
    """)
    print("  Table component_test_cases verified/created successfully.")

    # 4. Create component_test_runs table
    print("\nCreating component_test_runs table...")
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS component_test_runs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,

      test_case_id INTEGER NOT NULL,
      run_status TEXT DEFAULT 'started',
      command_run TEXT,
      output_log TEXT,
      error_log TEXT,

      started_at TEXT DEFAULT CURRENT_TIMESTAMP,
      completed_at TEXT,

      FOREIGN KEY (test_case_id) REFERENCES component_test_cases(id) ON DELETE CASCADE
    );
    """)
    print("  Table component_test_runs verified/created successfully.")

    # 5. Create Governance Views
    print("\nInstantiating view v_component_governance_summary...")
    cursor.execute("DROP VIEW IF EXISTS v_component_governance_summary;")
    cursor.execute("""
    CREATE VIEW v_component_governance_summary AS
    SELECT
      s.id AS screen_id,
      s.screen_name,
      COUNT(c.id) AS total_components,
      SUM(CASE WHEN c.is_required = 1 THEN 1 ELSE 0 END) AS required_components,
      SUM(CASE WHEN c.test_status = 'passed' THEN 1 ELSE 0 END) AS passed_components,
      SUM(CASE WHEN c.test_status = 'failed' THEN 1 ELSE 0 END) AS failed_components,
      CASE
        WHEN COUNT(c.id) = 0 THEN 'no_components'
        WHEN SUM(CASE WHEN c.test_status = 'failed' THEN 1 ELSE 0 END) > 0 THEN 'failed'
        WHEN SUM(CASE WHEN c.is_required = 1 AND c.test_status != 'passed' THEN 1 ELSE 0 END) > 0 THEN 'pending_tests'
        ELSE 'passed'
      END AS component_status
    FROM screens s
    LEFT JOIN ui_components c ON c.screen_id = s.id
    GROUP BY s.id, s.screen_name;
    """)
    print("  View v_component_governance_summary verified/created successfully.")

    print("\nInstantiating view v_component_test_queue...")
    cursor.execute("DROP VIEW IF EXISTS v_component_test_queue;")
    cursor.execute("""
    CREATE VIEW v_component_test_queue AS
    SELECT
      tc.id AS test_case_id,
      c.component_code,
      c.component_name,
      c.component_type,
      c.data_cy,
      s.screen_name,
      s.route_path,
      tc.test_type,
      tc.test_command,
      tc.status
    FROM component_test_cases tc
    JOIN ui_components c ON c.id = tc.component_id
    LEFT JOIN screens s ON s.id = c.screen_id
    WHERE tc.status != 'passed'
    ORDER BY c.component_type, c.component_name;
    """)
    print("  View v_component_test_queue verified/created successfully.")

    # 6. Seed core layout components
    print("\nSeeding core layout components inside ui_components...")
    core_components = [
        ('app_shell', 'App Shell', 'shell', 'app-shell', 'Persistent app shell renders topbar/sidebar/content slot.', 0, 1),
        ('app_topbar', 'App Topbar', 'topbar', 'app-topbar', 'Topbar renders role title, language switcher, profile/actions.', 1, 1),
        ('app_sidebar', 'App Sidebar', 'sidebar', 'app-sidebar', 'Sidebar renders role navigation items.', 1, 1),
        ('app_content_slot', 'App Content Slot', 'shell', 'app-content-slot', 'Screen content loads inside shell without rebuilding shell.', 0, 1),
        ('language_switcher', 'Language Switcher', 'topbar', 'topbar-language-switcher', 'Switches active language EN/FR/ES.', 1, 1),
        ('loading_state', 'Loading State', 'loading', 'screen-loading', 'Shows loading state while data loads.', 0, 1),
        ('error_state', 'Error State', 'error', 'screen-error', 'Shows error state when API/action fails.', 0, 1),
        ('success_state', 'Success State', 'success', 'screen-success', 'Shows success state after completed action.', 0, 1)
    ]
    for row in core_components:
        cursor.execute("""
        INSERT OR IGNORE INTO ui_components
        (component_code, component_name, component_type, data_cy, expected_behavior, is_interactive, is_required)
        VALUES (?, ?, ?, ?, ?, ?, ?);
        """, row)
    print(f"  Successfully seeded/verified {len(core_components)} core components.")

    # 7. Auto-create screen components
    print("\nAuto-generating screen components from screens table...")
    # Screen Root Component
    cursor.execute("""
    INSERT OR IGNORE INTO ui_components
    (app_id, screen_id, component_code, component_name, component_type, data_cy, expected_behavior, is_interactive, is_required)
    SELECT
      app_id,
      id,
      screen_code || '_root',
      screen_name || ' Root',
      'screen_root',
      lower(replace(screen_code, '_', '-')) || '-screen',
      'Root screen container must render and be visible.',
      0,
      1
    FROM screens;
    """)
    # Screen Title Component
    cursor.execute("""
    INSERT OR IGNORE INTO ui_components
    (app_id, screen_id, component_code, component_name, component_type, data_cy, expected_behavior, is_interactive, is_required)
    SELECT
      app_id,
      id,
      screen_code || '_title',
      screen_name || ' Title',
      'title',
      lower(replace(screen_code, '_', '-')) || '-title',
      'Screen title must render and be visible.',
      0,
      1
    FROM screens;
    """)
    # Screen Content Component
    cursor.execute("""
    INSERT OR IGNORE INTO ui_components
    (app_id, screen_id, component_code, component_name, component_type, data_cy, expected_behavior, is_interactive, is_required)
    SELECT
      app_id,
      id,
      screen_code || '_content',
      screen_name || ' Content',
      'content',
      lower(replace(screen_code, '_', '-')) || '-content',
      'Primary content area must render and not be blank.',
      0,
      1
    FROM screens;
    """)
    print("  Screen components generated.")

    # 8. Create component test cases
    print("\nAuto-generating component test cases...")
    # Flutter Widget test cases
    cursor.execute("""
    INSERT OR IGNORE INTO component_test_cases
    (component_id, test_code, test_name, test_type, test_command, expected_result)
    SELECT
      id,
      component_code || '_flutter_widget_test',
      component_name || ' Flutter Widget Test',
      'flutter_widget',
      'flutter test packages/primecare_ui/test/components',
      component_name || ' renders in Flutter widget test.'
    FROM ui_components;
    """)
    # Cypress Visual test cases
    cursor.execute("""
    INSERT OR IGNORE INTO component_test_cases
    (component_id, test_code, test_name, test_type, test_command, expected_result)
    SELECT
      id,
      component_code || '_cypress_visual_test',
      component_name || ' Cypress Visual Test',
      'cypress_visual',
      'cypress run --spec "cypress/e2e/07_visual_components/**/*.cy.js"',
      component_name || ' is visible in deployed browser UI.'
    FROM ui_components;
    """)
    print("  Component test cases populated successfully.")

    # 9. Add/update seed and runner governance functions
    print("\nAdding Stage 22 Component Governance functions inside SQLite...")
    functions_to_seed = [
        (
         'seed_component_governance',
         'Seed Component Governance',
         'db_update',
         'Create ui_components and component_test_cases from screens table.',
         'python tools/governance/seed_component_governance.py',
         'ui_components and component_test_cases populated.',
         'ui_components',
         'json_log',
         96
        ),
        (
         'run_component_tests',
         'Run Component Tests',
         'component_test',
         'Run Flutter widget tests and Cypress visual component tests.',
         'python tools/governance/run_component_tests.py',
         'All required components pass Flutter widget and Cypress visual tests.',
         'component_test_cases',
         'test_log',
         97
        )
    ]
    for row in functions_to_seed:
        try:
            cursor.execute("""
            INSERT INTO governance_functions
            (function_code, function_name, function_type, purpose_text, run_command, success_condition_text, updates_table, proof_type, run_order)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);
            """, row)
            print(f"  Inserted governance function: {row[0]}")
        except sqlite3.IntegrityError:
            cursor.execute("""
            UPDATE governance_functions
            SET function_name = ?,
                function_type = ?,
                purpose_text = ?,
                run_command = ?,
                success_condition_text = ?,
                updates_table = ?,
                proof_type = ?,
                run_order = ?,
                last_run_status = 'pending',
                last_run_at = NULL,
                last_error = NULL
            WHERE function_code = ?;
            """, row[1:] + (row[0],))
            print(f"  Updated and reset governance function: {row[0]}")

    conn.commit()
    conn.close()
    print("\nSeeding sweep completed successfully!")

if __name__ == '__main__':
    main()
