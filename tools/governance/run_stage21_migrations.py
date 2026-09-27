import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("==============================================================")
    print("PRIMECARE GOVERNANCE: STAGE 21 DDL MIGRATIONS & SEEDING")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # 1. Add verification fields to screens
    screen_cols = [
        ("translation_file_verified", "INTEGER DEFAULT 0"),
        ("hardcoded_visible_text_count", "INTEGER DEFAULT 0"),
        ("translation_key_usage_verified", "INTEGER DEFAULT 0"),
        ("generated_locale_files_json", "TEXT")
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

    # 2. Create translation_files table
    print("\nCreating translation_files table...")
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS translation_files (
      id INTEGER PRIMARY KEY AUTOINCREMENT,

      locale_code TEXT NOT NULL,
      file_path TEXT NOT NULL,

      translation_key_count INTEGER DEFAULT 0,
      missing_key_count INTEGER DEFAULT 0,

      generated_at TEXT,
      verified INTEGER DEFAULT 0,

      created_at TEXT DEFAULT CURRENT_TIMESTAMP
    );
    """)
    print("  Table translation_files created successfully.")

    # 3. Seed extract_translation_keys governance function
    print("\nSeeding Stage 21 governance function...")
    row = (
         'extract_translation_keys',
         'Extract Translation Keys',
         'scan',
         'Scan Flutter files for hardcoded visible text, create translation keys, generate locale JSON/ARB files, and update SQLite language tables.',
         'screens',
         'SELECT id, screen_name, actual_file_path FROM screens;',
         'python tools/governance/extract_translation_keys.py',
         'All visible text elements extracted. Physical ARB locale files created and translation values populated.',
         'All visible text uses translation keys and locale files generated.',
         'translation_keys,translation_values,screen_translation_map,translation_files',
         'translation_file_verified,hardcoded_visible_text_count,translation_key_usage_verified,generated_locale_files_json',
         'json_log',
         'tools/governance/reports/translation_extraction_report.json',
         85
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
    print("\nStage 21 DDL migrations and seeding complete.")

if __name__ == '__main__':
    main()
