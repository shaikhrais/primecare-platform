import os
import sqlite3

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def check():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()
    
    print("--- GOVERNANCE FUNCTIONS IN DB ---")
    funcs = cur.execute("SELECT id, function_code, function_name, run_command, run_order, last_run_status, last_run_at FROM governance_functions ORDER BY run_order").fetchall()
    for f in funcs:
        print(f"ID: {f['id']} | Code: {f['function_code']} | Status: {f['last_run_status']} | Last Run: {f['last_run_at']}")
        
    print("\n--- PENDING IN QUEUE VIEW (v_governance_function_queue) ---")
    try:
        pending = cur.execute("SELECT * FROM v_governance_function_queue").fetchall()
        print(f"Total pending: {len(pending)}")
        for p in pending:
            print(f"  Code: {p['function_code']} | Command: {p['run_command']}")
    except sqlite3.OperationalError as e:
        print(f"Error reading queue view: {e}")
        
    conn.close()

if __name__ == "__main__":
    check()
