import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("==============================================================")
    print("PRIMECARE GOVERNANCE: RESETTING FUNCTION RUN STATUS TO PENDING")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    cursor.execute("""
        UPDATE governance_functions
        SET last_run_status = 'pending',
            last_run_at = NULL,
            last_error = NULL;
    """)
    conn.commit()
    print("All governance functions reset to 'pending'.")

    # Also delete existing runs to make it clean
    cursor.execute("DELETE FROM governance_function_runs;")
    conn.commit()
    print("Cleared governance_function_runs history.")

    conn.close()

if __name__ == '__main__':
    main()
