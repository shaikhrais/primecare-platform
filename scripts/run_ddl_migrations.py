import sqlite3
import os
import sys

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

COLUMNS_TO_ADD = [
    ("required_components_json", "TEXT"),
    ("actual_components_json", "TEXT"),
    ("missing_components_json", "TEXT"),
    ("required_buttons_json", "TEXT"),
    ("actual_buttons_json", "TEXT"),
    ("missing_buttons_json", "TEXT"),
    ("required_functions_json", "TEXT"),
    ("actual_functions_json", "TEXT"),
    ("missing_functions_json", "TEXT"),
    ("required_apis_json", "TEXT"),
    ("actual_apis_json", "TEXT"),
    ("missing_apis_json", "TEXT"),
    ("required_responsive_json", "TEXT"),
    ("actual_responsive_json", "TEXT"),
    ("missing_responsive_json", "TEXT"),
    ("code_gap_summary", "TEXT"),
    ("implementation_plan_text", "TEXT"),
    ("ready_for_implementation", "INTEGER DEFAULT 0")
]

def main():
    print("==============================================================")
    print("PRIMECARE DDL SCHEMA MIGRATIONS: ADDING TRACKING COLUMNS")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        sys.exit(1)

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # Get existing columns
    cursor.execute("PRAGMA table_info(screens)")
    existing_cols = {row[1] for row in cursor.fetchall()}

    # Add missing columns
    altered_any = False
    for col_name, col_type in COLUMNS_TO_ADD:
        if col_name not in existing_cols:
            print(f"Adding column: {col_name} ({col_type})...")
            cursor.execute(f"ALTER TABLE screens ADD COLUMN {col_name} {col_type};")
            altered_any = True
        else:
            print(f"Column already exists: {col_name}")

    # Create the view
    print("Creating/Replacing view 'v_screen_code_gap_plan'...")
    cursor.execute("DROP VIEW IF EXISTS v_screen_code_gap_plan;")
    cursor.execute("""
    CREATE VIEW v_screen_code_gap_plan AS
    SELECT
      id,
      app_id,
      screen_code,
      screen_name,
      actual_file_path,

      required_components_json,
      actual_components_json,
      missing_components_json,

      required_buttons_json,
      actual_buttons_json,
      missing_buttons_json,

      required_functions_json,
      actual_functions_json,
      missing_functions_json,

      required_apis_json,
      actual_apis_json,
      missing_apis_json,

      code_gap_summary,
      implementation_plan_text,
      ready_for_implementation

    FROM screens
    WHERE
      ready_for_implementation = 0
      OR missing_components_json IS NOT NULL
      OR missing_buttons_json IS NOT NULL
      OR missing_functions_json IS NOT NULL
      OR missing_apis_json IS NOT NULL;
    """)

    conn.commit()
    conn.close()
    print("==============================================================")
    print("DDL SCHEMA MIGRATIONS COMPLETED SUCCESSFULLY!")
    print("==============================================================")

if __name__ == '__main__':
    main()
