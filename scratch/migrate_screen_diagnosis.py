import sqlite3
import os

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def migrate():
    if not os.path.exists(db_path):
        print(f"Database not found at {db_path}")
        return

    conn = sqlite3.connect(db_path)
    c = conn.cursor()

    # 1. Add columns to screens table if they don't exist
    columns_to_add = [
        ("diagnosis_enabled", "INTEGER DEFAULT 0"),
        ("diagnosis_reply_status", "TEXT DEFAULT 'NOT_TESTED'"),
        ("diagnosis_last_question", "TEXT"),
        ("diagnosis_last_answer", "TEXT"),
        ("diagnosis_last_checked_at", "TEXT"),
        ("diagnosis_error", "TEXT")
    ]

    # Get existing columns
    c.execute("PRAGMA table_info(screens)")
    existing_cols = [row[1] for row in c.fetchall()]

    for col_name, col_type in columns_to_add:
        if col_name not in existing_cols:
            alter_query = f"ALTER TABLE screens ADD COLUMN {col_name} {col_type}"
            c.execute(alter_query)
            print(f"Added column {col_name} to screens table.")
        else:
            print(f"Column {col_name} already exists in screens table.")

    # 2. Create screen_diagnosis_tests table
    create_table_query = """
    CREATE TABLE IF NOT EXISTS screen_diagnosis_tests (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        screen_id INTEGER,
        route_path TEXT,
        question TEXT,
        answer TEXT,
        reply_status TEXT,
        missing_items TEXT,
        tested_at TEXT,
        error_message TEXT
    )
    """
    c.execute(create_table_query)
    print("Created table screen_diagnosis_tests (if it did not exist).")

    # Set diagnosis_enabled = 1 for all screens by default to enable testing
    c.execute("UPDATE screens SET diagnosis_enabled = 1")
    print("Set diagnosis_enabled = 1 for all screens.")

    conn.commit()
    conn.close()
    print("Migration completed successfully.")

if __name__ == "__main__":
    migrate()
