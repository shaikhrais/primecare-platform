import os
import sqlite3
import datetime

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    print("==============================================================")
    print("IMPORTING CYPRESS RESULTS TO SCREENS IN GOVERNANCE DB")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    # 1. Identify the latest test run
    c.execute("""
        SELECT run_id, total_tests, passed_tests, failed_tests, started_at, finished_at
        FROM screen_test_runs
        ORDER BY id DESC LIMIT 1
    """)
    run_row = c.fetchone()
    if not run_row:
        print("No test runs found in the database. Run Cypress tests first.")
        conn.close()
        return

    run_id = run_row["run_id"]
    print(f"Processing latest test run: {run_id}")
    print(f"  Total tests: {run_row['total_tests']}")
    print(f"  Passed tests: {run_row['passed_tests']}")
    print(f"  Failed tests: {run_row['failed_tests']}")
    print(f"  Started at: {run_row['started_at']}")
    print(f"  Finished at: {run_row['finished_at']}")

    # 2. Fetch all results for this test run
    c.execute("""
        SELECT screen_id, status, error_message, finished_at
        FROM screen_test_results
        WHERE run_id = ?
    """, (run_id,))
    results = [dict(row) for row in c.fetchall()]
    print(f"\nFound {len(results)} screen results to sync.")

    now_str = datetime.datetime.utcnow().isoformat() + "Z"

    # 3. Update the screens table for each result
    for r in results:
        screen_id = r["screen_id"]
        status = r["status"]
        error_msg = r["error_message"]
        completed_at = r["finished_at"] or now_str

        if status == "passed":
            print(f"Screen ID {screen_id} -> PASSED. Syncing to screens...")
            # If passed, we set cypress_verified = 1, runtime_verified = 1, last_runtime_check, and we also make it production_ready!
            c.execute("""
                UPDATE screens
                SET cypress_verified = 1,
                    runtime_verified = 1,
                    last_runtime_check = ?,
                    production_ready = 1,
                    verification_notes = 'Cypress E2E test passed successfully.'
                WHERE id = ?
            """, (completed_at, screen_id))
        else:
            print(f"Screen ID {screen_id} -> FAILED. Error: {error_msg}")
            c.execute("""
                UPDATE screens
                SET cypress_verified = 0,
                    runtime_verified = 0,
                    production_ready = 0,
                    verification_notes = ?
                WHERE id = ?
            """, (error_msg, screen_id))

    conn.commit()
    conn.close()

    print("\n==============================================================")
    print("SCREENS SYNCHRONIZED SUCCESSFULLY FROM TEST RUN RESULTS!")
    print("==============================================================")

if __name__ == "__main__":
    main()
