import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.abspath(os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db"))

def main():
    print("Executing Database Migration: Adding Enterprise Cypress E2E Columns...")
    
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # Migrate screens table
    cursor.execute("PRAGMA table_info(screens)")
    screens_cols = {col[1] for col in cursor.fetchall()}

    screens_new_columns = [
        ("cypress_spec_path", "TEXT"),
        ("cypress_last_status", "TEXT DEFAULT 'not_run'"),
        ("cypress_last_error", "TEXT"),
        ("cypress_last_run_at", "TEXT"),
        ("cypress_video_path", "TEXT"),
        ("cypress_screenshot_path", "TEXT"),
        ("screenshot_file_exists", "INTEGER DEFAULT 0"),
        ("screenshot_file_size_bytes", "INTEGER DEFAULT 0"),
        ("screenshot_blank_detected", "INTEGER DEFAULT 0"),
        ("screenshot_visual_score", "INTEGER DEFAULT 0"),
        ("screenshot_validation_status", "TEXT DEFAULT 'pending'"),
        ("visual_proof_verified", "INTEGER DEFAULT 0")
    ]

    for col_name, col_type in screens_new_columns:
        if col_name not in screens_cols:
            cursor.execute(f"ALTER TABLE screens ADD COLUMN {col_name} {col_type};")
            print(f"  Added to screens: {col_name} ({col_type})")
        else:
            print(f"  Column screens.{col_name} already exists.")

    # Migrate roles table
    cursor.execute("PRAGMA table_info(roles)")
    roles_cols = {col[1] for col in cursor.fetchall()}

    roles_new_columns = [
        ("test_email", "TEXT"),
        ("test_password_secret_ref", "TEXT"),
        ("auth_test_status", "TEXT DEFAULT 'not_run'"),
        ("auth_last_error", "TEXT"),
        ("auth_last_run_at", "TEXT"),
        ("auth_screenshot_path", "TEXT"),
        ("auth_video_path", "TEXT")
    ]

    for col_name, col_type in roles_new_columns:
        if col_name not in roles_cols:
            cursor.execute(f"ALTER TABLE roles ADD COLUMN {col_name} {col_type};")
            print(f"  Added to roles: {col_name} ({col_type})")
        else:
            print(f"  Column roles.{col_name} already exists.")

    # Update credentials
    print("Updating credentials for active roles...")
    cursor.execute("SELECT role_code FROM roles")
    roles = cursor.fetchall()
    for role in roles:
        role_code = role[0]
        test_email = f"qa.{role_code}@test.primecare.local"
        cursor.execute("""
            UPDATE roles 
            SET test_email = ?, test_password_secret_ref = ?
            WHERE role_code = ? AND (test_email IS NULL OR test_password_secret_ref IS NULL)
        """, (test_email, "TEST_DEFAULT_PASSWORD", role_code))
        
    print("Enforcing strict active languages (en, fr, es)...")
    # Verify/update language governance
    cursor.execute("""
        UPDATE language_registry
        SET enabled = CASE
          WHEN locale_code IN ('en','fr','es') THEN 1
          ELSE 0
        END;
    """)
    cursor.execute("""
        UPDATE apps
        SET supported_locales_json = '["en","fr","es"]';
    """)
    cursor.execute("""
        UPDATE roles
        SET allowed_locales_json = '["en","fr","es"]';
    """)

    conn.commit()
    conn.close()
    print("[SUCCESS] SQLite migration completed cleanly.")

if __name__ == '__main__':
    main()
