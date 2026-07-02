import sqlite3
import os

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def main():
    if not os.path.exists(DB_PATH):
        print("Database file not found!")
        return

    size_before = os.path.getsize(DB_PATH)
    print(f"Size before optimization: {size_before / (1024 * 1024):.2f} MB")

    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()

    print("Cleaning up old logs and test run histories...")
    
    # 1. Truncate diagnostic conversations
    print("Truncating screen_diagnosis_tests...")
    cur.execute("DELETE FROM screen_diagnosis_tests;")

    # 2. Truncate component test runs
    print("Truncating component_test_runs...")
    cur.execute("DELETE FROM component_test_runs;")

    # 3. Truncate change history
    print("Truncating screen_change_history...")
    cur.execute("DELETE FROM screen_change_history;")

    # 4. Truncate cypress results
    print("Truncating cypress_results...")
    cur.execute("DELETE FROM cypress_results;")

    # 5. Keep only the latest test result per screen in screen_test_results
    print("Optimizing screen_test_results...")
    cur.execute("""
        DELETE FROM screen_test_results
        WHERE id NOT IN (
            SELECT MAX(id) FROM screen_test_results GROUP BY screen_id
        );
    """)

    # 6. Truncate language verification results (very large and auto-generated)
    print("Truncating language_verification_results...")
    cur.execute("DELETE FROM language_verification_results;")

    # 7. Truncate language KPI results
    print("Truncating language_kpi_results...")
    cur.execute("DELETE FROM language_kpi_results;")

    conn.commit()

    print("Executing VACUUM to reclaim space...")
    conn.execute("VACUUM;")
    conn.close()

    size_after = os.path.getsize(DB_PATH)
    print(f"Size after optimization: {size_after / (1024 * 1024):.2f} MB")
    print(f"Total space saved: {(size_before - size_after) / (1024 * 1024):.2f} MB")

if __name__ == "__main__":
    main()
