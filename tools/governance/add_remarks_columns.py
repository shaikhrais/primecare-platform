import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print(f"🚀 Initiating database migration...")
    if not os.path.exists(DB_PATH):
        print(f"[ERROR] Database not found at: {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # Get existing columns
    cursor.execute("PRAGMA table_info(screens)")
    existing_cols = {col[1] for col in cursor.fetchall()}

    new_columns = [
        ("user_remarks", "TEXT"),
        ("user_remark_status", "TEXT DEFAULT 'none'")
    ]

    migrated = False
    for col_name, col_type in new_columns:
        if col_name not in existing_cols:
            cursor.execute(f"ALTER TABLE screens ADD COLUMN {col_name} {col_type};")
            print(f"  [MIGRATED] Added column: {col_name} ({col_type})")
            migrated = True
        else:
            print(f"  [EXISTING] Column '{col_name}' already present.")

    if migrated:
        conn.commit()
        print("✨ Database migration completed successfully and changes committed!")
    else:
        print("✨ No migration needed. All columns are already present.")

    conn.close()

if __name__ == '__main__':
    main()
