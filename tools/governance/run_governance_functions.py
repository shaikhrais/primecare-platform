import os
import sqlite3
import subprocess
from datetime import datetime
from pathlib import Path

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.abspath(os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db"))

def now():
    return datetime.utcnow().isoformat()

def main():
    print("==============================================================")
    print("PRIMECARE GOVERNANCE: DECLARATIVE FUNCTION SWEEP ENGINE")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    try:
        functions = cur.execute("""
            SELECT *
            FROM v_governance_function_queue
            ORDER BY run_order ASC, function_id ASC
        """).fetchall()
    except sqlite3.OperationalError as e:
        print(f"Operational Error reading queue view: {e}")
        conn.close()
        return

    if not functions:
        print("No governance functions pending.")
        conn.close()
        return

    print(f"Loaded {len(functions)} pending governance functions from queue view...")

    for fn in functions:
        print(f"\n[Run] Executing: {fn['function_name']} ({fn['function_code']})...")

        cur.execute("""
            INSERT INTO governance_function_runs
            (function_id, run_status, command_run, started_at)
            VALUES (?, 'started', ?, ?)
        """, (fn["function_id"], fn["run_command"], now()))

        run_id = cur.lastrowid
        conn.commit()

        # Run command relative to project root
        result = subprocess.run(
            fn["run_command"],
            cwd=PROJECT_ROOT,
            shell=True,
            capture_output=True,
            text=True,
            errors='ignore'
        )

        status = "passed" if result.returncode == 0 else "failed"

        stdout_clean = result.stdout[-10000:] if result.stdout else ""
        stderr_clean = result.stderr[-10000:] if result.stderr else ""

        cur.execute("""
            UPDATE governance_function_runs
            SET run_status = ?,
                output_log = ?,
                error_log = ?,
                completed_at = ?
            WHERE id = ?
        """, (
            status,
            stdout_clean,
            stderr_clean,
            now(),
            run_id
        ))

        cur.execute("""
            UPDATE governance_functions
            SET last_run_status = ?,
                last_run_at = ?,
                last_error = ?
            WHERE id = ?
        """, (
            status,
            now(),
            stderr_clean[-2000:] if status == "failed" else None,
            fn["function_id"]
        ))

        conn.commit()

        if status == "failed":
            print(f"FAILED: {fn['function_code']} (Exit code: {result.returncode})")
            if result.stderr:
                print("--- Error Output ---")
                print(result.stderr)
            break

        print(f"PASSED: {fn['function_code']}")

    conn.close()
    print("\nOrchestration sweep cycle complete.")

if __name__ == "__main__":
    main()
