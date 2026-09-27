import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("==============================================================")
    print("PRIMECARE GOVERNANCE: STAGE 20 DDL MIGRATIONS & SEEDING")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # 1. Add verification fields to screens
    screen_cols = [
        ("language_codes_tested_json", "TEXT"),
        ("missing_language_codes_json", "TEXT"),
        ("rtl_layout_verified", "INTEGER DEFAULT 0"),
        ("language_translation_complete", "INTEGER DEFAULT 0"),
        ("language_switch_runtime_verified", "INTEGER DEFAULT 0"),
        ("language_kpi_status", "TEXT DEFAULT 'pending'")
    ]

    print("Altering screens table...")
    for col, col_type in screen_cols:
        try:
            cursor.execute(f"ALTER TABLE screens ADD COLUMN {col} {col_type};")
            print(f"  Added column {col} to screens.")
        except sqlite3.OperationalError as e:
            if "duplicate column name" in str(e):
                print(f"  Column {col} already exists in screens. Skipping.")
            else:
                print(f"  Error adding {col}: {e}")

    # 2. Create language_registry table
    print("\nCreating language_registry table...")
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS language_registry (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      locale_code TEXT UNIQUE NOT NULL,   -- en, fr, es, hi, gu, ar, ur
      language_name TEXT NOT NULL,
      native_name TEXT,
      text_direction TEXT DEFAULT 'ltr',  -- ltr or rtl
      enabled INTEGER DEFAULT 1,
      is_default INTEGER DEFAULT 0,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP
    );
    """)
    print("  Table language_registry created.")

    # Seed language_registry
    print("Seeding language_registry table...")
    languages = [
        ('en', 'English', 'English', 'ltr', 1, 1),
        ('fr', 'French', 'Français', 'ltr', 1, 0),
        ('es', 'Spanish', 'Español', 'ltr', 1, 0),
        ('hi', 'Hindi', 'हिन्दी', 'ltr', 0, 0),
        ('gu', 'Gujarati', 'ગુજરાતી', 'ltr', 0, 0),
        ('ar', 'Arabic', 'العربية', 'rtl', 0, 0),
        ('ur', 'Urdu', 'اردو', 'rtl', 0, 0)
    ]
    for row in languages:
        try:
            cursor.execute("""
            INSERT OR IGNORE INTO language_registry
            (locale_code, language_name, native_name, text_direction, enabled, is_default)
            VALUES (?, ?, ?, ?, ?, ?);
            """, row)
        except Exception as e:
            print(f"  Error seeding language {row[0]}: {e}")
    print("  Seeded 7 languages cleanly.")

    # 3. Create translation_keys table
    print("\nCreating translation_keys table...")
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS translation_keys (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      key_code TEXT UNIQUE NOT NULL,
      key_group TEXT,
      default_text TEXT NOT NULL,
      description TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP
    );
    """)
    print("  Table translation_keys created.")

    # 4. Create translation_values table
    print("\nCreating translation_values table...")
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS translation_values (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      key_id INTEGER NOT NULL,
      locale_code TEXT NOT NULL,
      translated_text TEXT NOT NULL,
      verified INTEGER DEFAULT 0,
      last_verified_at TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (key_id) REFERENCES translation_keys(id) ON DELETE CASCADE,
      UNIQUE(key_id, locale_code)
    );
    """)
    print("  Table translation_values created.")

    # 5. Create screen_translation_map table
    print("\nCreating screen_translation_map table...")
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS screen_translation_map (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      screen_id INTEGER NOT NULL,
      key_id INTEGER NOT NULL,
      usage_type TEXT, -- title, button, label, menu, error, success
      data_cy TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE,
      FOREIGN KEY (key_id) REFERENCES translation_keys(id) ON DELETE CASCADE,
      UNIQUE(screen_id, key_id, usage_type)
    );
    """)
    print("  Table screen_translation_map created.")

    # 6. Create language_verification_results table
    print("\nCreating language_verification_results table...")
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS language_verification_results (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      screen_id INTEGER,
      locale_code TEXT NOT NULL,
      switcher_visible INTEGER DEFAULT 0,
      language_changed INTEGER DEFAULT 0,
      content_translated INTEGER DEFAULT 0,
      topbar_translated INTEGER DEFAULT 0,
      sidebar_translated INTEGER DEFAULT 0,
      rtl_layout_ok INTEGER DEFAULT 0,
      missing_key_count INTEGER DEFAULT 0,
      hardcoded_text_count INTEGER DEFAULT 0,
      kpi_score INTEGER DEFAULT 0,
      status TEXT DEFAULT 'pending',
      proof_log_path TEXT,
      screenshot_path TEXT,
      tested_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE SET NULL
    );
    """)
    print("  Table language_verification_results created.")

    # 7. Instantiate v_missing_translations view
    print("\nCreating view v_missing_translations...")
    cursor.execute("DROP VIEW IF EXISTS v_missing_translations;")
    cursor.execute("""
    CREATE VIEW v_missing_translations AS
    SELECT
      tk.key_code,
      tk.default_text,
      lr.locale_code,
      lr.language_name
    FROM translation_keys tk
    CROSS JOIN language_registry lr
    LEFT JOIN translation_values tv
      ON tv.key_id = tk.id
     AND tv.locale_code = lr.locale_code
    WHERE lr.enabled = 1
      AND tv.id IS NULL;
    """)
    print("  View v_missing_translations created.")

    # 8. Instantiate v_screen_language_readiness view
    print("\nCreating view v_screen_language_readiness...")
    cursor.execute("DROP VIEW IF EXISTS v_screen_language_readiness;")
    cursor.execute("""
    CREATE VIEW v_screen_language_readiness AS
    SELECT
      s.id AS screen_id,
      s.screen_name,
      COUNT(DISTINCT stm.key_id) AS translation_keys_used,
      COUNT(DISTINCT lvr.locale_code) AS locales_tested,
      SUM(CASE WHEN lvr.status = 'passed' THEN 1 ELSE 0 END) AS passed_language_tests,
      s.language_kpi_status
    FROM screens s
    LEFT JOIN screen_translation_map stm ON stm.screen_id = s.id
    LEFT JOIN language_verification_results lvr ON lvr.screen_id = s.id
    GROUP BY s.id, s.screen_name, s.language_kpi_status;
    """)
    print("  View v_screen_language_readiness created.")

    # 9. Seed audit_language_data governance function
    print("\nSeeding Stage 20 governance function...")
    row = (
         'audit_language_data',
         'Audit Language Data Governance',
         'cypress',
         'Scan screens codebase, extract visible text elements, seed database translation keys and multilingual values, perform Right-to-Left (RTL) verification and language switching runtime assertions.',
         'screens',
         'SELECT id, screen_name, route_path FROM screens;',
         'python tools/governance/audit_language_data.py',
         'Multilingual translation keys, values and E2E RTL verification results saved inside registry.',
         'All active screens have complete language data coverage and passed language_verification_results.',
         'language_verification_results',
         'switcher_visible,language_changed,content_translated,topbar_translated,sidebar_translated,rtl_layout_ok,missing_key_count,hardcoded_text_count,kpi_score,status',
         'video_screenshot',
         'cypress/videos/language/',
         160
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
    print("\nStage 20 DDL migrations and seeding complete.")

if __name__ == '__main__':
    main()
