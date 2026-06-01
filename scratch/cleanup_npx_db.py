import sqlite3
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    # 1. Search first to confirm what will be updated
    cursor.execute("SELECT id, command_run FROM governance_function_runs WHERE command_run LIKE '%npx%';")
    rows = cursor.fetchall()
    
    print(f"Found {len(rows)} matching rows in governance_function_runs.command_run containing 'npx'.")
    
    # 2. Run the update statement to remove 'npx ' (and replace with direct binary invocation or empty string)
    cursor.execute("""
        UPDATE governance_function_runs 
        SET command_run = REPLACE(command_run, 'npx ', '')
        WHERE command_run LIKE '%npx%';
    """)
    updated_count = cursor.rowcount
    conn.commit()
    
    print(f"Successfully cleaned up {updated_count} rows in database. All 'npx ' occurrences removed!")
    
    # 3. Double check if any 'npx' remains
    cursor.execute("SELECT COUNT(*) FROM governance_function_runs WHERE command_run LIKE '%npx%';")
    remaining = cursor.fetchone()[0]
    print(f"Remaining 'npx' occurrences in database: {remaining}")
    
    conn.close()

if __name__ == '__main__':
    main()
