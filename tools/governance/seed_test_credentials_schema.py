import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("==============================================================")
    print("PRIMECARE GOVERNANCE: TEST CREDENTIALS SCHEMA MIGRATION")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()

    # 1. Alter roles table to add columns (idempotent check)
    columns_to_add = [
        ("test_email", "TEXT"),
        ("test_password_secret_ref", "TEXT DEFAULT 'TEST_DEFAULT_PASSWORD'"),
        ("test_user_seed_status", "TEXT DEFAULT 'not_seeded'"),
        ("test_user_id", "TEXT"),
        ("test_login_verified", "INTEGER DEFAULT 0"),
        ("test_login_last_status", "TEXT DEFAULT 'not_run'"),
        ("test_login_last_error", "TEXT"),
        ("test_login_last_run_at", "TEXT")
    ]

    # Get existing columns
    cur.execute("PRAGMA table_info(roles);")
    existing_cols = [row[1] for row in cur.fetchall()]

    for col_name, col_type in columns_to_add:
        if col_name not in existing_cols:
            print(f"Adding column '{col_name}' to roles table...")
            cur.execute(f"ALTER TABLE roles ADD COLUMN {col_name} {col_type};")
        else:
            print(f"Column '{col_name}' already exists in roles table.")

    # 2. Create seed tracking table
    print("Creating role_test_user_seeds table if not exists...")
    cur.execute("""
    CREATE TABLE IF NOT EXISTS role_test_user_seeds (
      id INTEGER PRIMARY KEY AUTOINCREMENT,

      role_id INTEGER NOT NULL,
      app_id INTEGER,

      role_code TEXT NOT NULL,
      test_email TEXT NOT NULL,
      password_secret_ref TEXT DEFAULT 'TEST_DEFAULT_PASSWORD',

      seed_source TEXT DEFAULT 'api',
      -- api, db, manual

      seed_status TEXT DEFAULT 'pending',
      -- pending, created, exists, failed

      api_endpoint TEXT,
      api_status_code INTEGER,
      api_response_json TEXT,

      login_verified INTEGER DEFAULT 0,
      login_status TEXT DEFAULT 'not_run',
      login_error TEXT,

      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      updated_at TEXT,

      FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE SET NULL,

      UNIQUE(role_id, test_email)
    );
    """)

    # 3. Generate test email for every role
    print("Generating standard test emails for all roles...")
    cur.execute("""
    UPDATE roles
    SET
      test_email = 'qa.' || lower(replace(role_code, ' ', '_')) || '@test.primecare.local',
      test_password_secret_ref = 'TEST_DEFAULT_PASSWORD'
    WHERE test_email IS NULL OR test_email = '';
    """)

    # 4. Insert role seed records
    print("Inserting seed tracking records into role_test_user_seeds...")
    cur.execute("""
    INSERT OR IGNORE INTO role_test_user_seeds
    (role_id, app_id, role_code, test_email, password_secret_ref, seed_status)
    SELECT
      id,
      NULL,
      role_code,
      test_email,
      'TEST_DEFAULT_PASSWORD',
      'pending'
    FROM roles
    WHERE test_email IS NOT NULL
      AND test_email != '';
    """)

    conn.commit()
    conn.close()
    print("Migration finished cleanly.")

if __name__ == '__main__':
    main()
