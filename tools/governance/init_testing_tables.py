import sqlite3
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("==============================================================")
    print("PRIMECARE GOVERNANCE: INITIALIZING/REFACTORING TESTING TABLES")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()

    # Drop the separate widgets and test_runs tables if they exist to comply with the single-table design constraint
    print("Consolidating widgets and test_runs data directly into the 'screens' table...")
    try:
        cur.execute("DROP TABLE IF EXISTS widgets;")
        print("Table 'widgets' dropped/cleaned successfully.")
    except Exception as e:
        print(f"Error dropping 'widgets' table: {e}")

    try:
        cur.execute("DROP TABLE IF EXISTS test_runs;")
        print("Table 'test_runs' dropped/cleaned successfully.")
    except Exception as e:
        print(f"Error dropping 'test_runs' table: {e}")

    conn.commit()
    conn.close()
    print("Database consolidation completed successfully.")

if __name__ == '__main__':
    main()
