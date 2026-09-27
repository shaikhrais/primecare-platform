import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("==============================================================")
    print("PRIMECARE GOVERNANCE: STAGE 18 DDL MIGRATIONS & SEEDING")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # 1. Extend screens table
    screen_cols = [
        ("shell_layout_key", "TEXT"),
        ("content_slot_key", "TEXT"),
        ("topbar_rebuild_count", "INTEGER DEFAULT 0"),
        ("sidebar_rebuild_count", "INTEGER DEFAULT 0"),
        ("content_rebuild_count", "INTEGER DEFAULT 0"),
        ("shell_reload_detected", "INTEGER DEFAULT 0"),
        ("content_only_navigation_verified", "INTEGER DEFAULT 0"),
        ("layout_reuse_status", "TEXT DEFAULT 'unknown'")
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

    # 2. Seed verify_layout_reuse governance function
    print("\nSeeding Stage 18 governance function...")
    row = (
         'verify_layout_reuse',
         'Verify App Shell & Sidebar Layout Reuse',
         'layout_reuse_audit',
         'Scan all screens, verify GoRouter ShellRoute and RoleShellLayout, validate topbar/sidebar persist during routing, measure rebuild boundaries, and check data-cy keys.',
         'screens',
         "SELECT id, screen_name, route_path FROM screens WHERE layout_reuse_status = 'unknown';",
         'python tools/governance/verify_layout_reuse.py',
         'Screens verified for shell persistence and content-only reconstruction. Rebuild indicators logged.',
         'All active screens are verified for layout reuse and persistent app shells.',
         'screens',
         'shell_layout_key,content_slot_key,topbar_rebuild_count,sidebar_rebuild_count,content_rebuild_count,shell_reload_detected,content_only_navigation_verified,layout_reuse_status',
         'json_log',
         'tools/governance/reports/layout_reuse_report.json',
         140
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
    print("\nStage 18 migrations and seeding complete.")

if __name__ == '__main__':
    main()
