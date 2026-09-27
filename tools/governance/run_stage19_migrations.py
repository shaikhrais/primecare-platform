import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("==============================================================")
    print("PRIMECARE GOVERNANCE: STAGE 19 DDL MIGRATIONS & SEEDING")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # 1. Extend apps table
    app_cols = [
        ("default_locale", "TEXT DEFAULT 'en'"),
        ("supported_locales_json", "TEXT DEFAULT '[\"en\"]'"),
        ("i18n_strategy", "TEXT DEFAULT 'arb'"),
        ("translation_file_path", "TEXT")
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
        ("preferred_locale", "TEXT DEFAULT 'en'"),
        ("allowed_locales_json", "TEXT DEFAULT '[\"en\"]'"),
        ("show_language_switcher", "INTEGER DEFAULT 1")
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
        ("language_test_required", "INTEGER DEFAULT 1"),
        ("language_switcher_visible", "INTEGER DEFAULT 0"),
        ("language_switcher_data_cy", "TEXT"),
        ("supported_screen_locales_json", "TEXT DEFAULT '[\"en\"]'"),
        ("translation_keys_json", "TEXT"),
        ("missing_translation_keys_json", "TEXT"),
        ("hardcoded_text_detected", "INTEGER DEFAULT 0"),
        ("language_change_runtime_verified", "INTEGER DEFAULT 0"),
        ("language_persistence_verified", "INTEGER DEFAULT 0"),
        ("language_sidebar_verified", "INTEGER DEFAULT 0"),
        ("language_topbar_verified", "INTEGER DEFAULT 0"),
        ("language_content_verified", "INTEGER DEFAULT 0"),
        ("language_kpi_score", "INTEGER DEFAULT 0"),
        ("language_test_status", "TEXT DEFAULT 'pending'"),
        ("language_test_log_path", "TEXT"),
        ("language_screenshot_path", "TEXT")
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

    # 4. Create language_kpi_results table
    print("\nCreating language_kpi_results table...")
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS language_kpi_results (
      id INTEGER PRIMARY KEY AUTOINCREMENT,

      app_id INTEGER,
      role_id INTEGER,
      screen_id INTEGER,

      locale TEXT NOT NULL,

      switcher_visible INTEGER DEFAULT 0,
      switcher_clicked INTEGER DEFAULT 0,
      topbar_translated INTEGER DEFAULT 0,
      sidebar_translated INTEGER DEFAULT 0,
      content_translated INTEGER DEFAULT 0,
      missing_key_count INTEGER DEFAULT 0,
      hardcoded_text_count INTEGER DEFAULT 0,
      persistence_verified INTEGER DEFAULT 0,

      kpi_score INTEGER DEFAULT 0,
      kpi_status TEXT DEFAULT 'pending',

      proof_log_path TEXT,
      screenshot_path TEXT,

      tested_at TEXT DEFAULT CURRENT_TIMESTAMP,

      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE SET NULL,
      FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE SET NULL,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE SET NULL
    );
    """)
    print("  Table language_kpi_results created successfully.")

    # 5. Seed test_language_governance governance function
    print("\nSeeding Stage 19 governance function...")
    row = (
         'test_language_governance',
         'Test Language Governance',
         'cypress',
         'Verify topbar language switcher, language change, sidebar translation, content translation, persistence, missing keys, and screenshots.',
         'screens',
         'SELECT id, screen_name, route_path FROM screens WHERE language_test_required = 1;',
         'python tools/governance/test_language_governance.py',
         'Language switcher works across topbar/sidebar/content and persists after reload.',
         'All required language tests pass and language_kpi_results are saved.',
         'language_kpi_results',
         'switcher_visible,switcher_clicked,topbar_translated,sidebar_translated,content_translated,persistence_verified,kpi_score,kpi_status',
         'video_screenshot',
         'cypress/videos/language/',
         150
    )

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
    print("\nStage 19 migrations and seeding complete.")

if __name__ == '__main__':
    main()
