import os
import sqlite3

DB_PATH = os.path.join(".agents", "governance", "governance.db")

def main():
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return
        
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    # Let's see what tables exist
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
    tables = [row['name'] for row in cursor.fetchall()]
    print(f"Tables: {', '.join(tables)}")
    
    # 1. Total screens count
    if 'screens' in tables:
        cursor.execute("SELECT COUNT(*) as cnt FROM screens;")
        total_screens = cursor.fetchone()['cnt']
        print(f"Total Screens in Registry: {total_screens}")
        
        # Let's inspect screens columns
        cursor.execute("PRAGMA table_info(screens);")
        columns = [row['name'] for row in cursor.fetchall()]
        print(f"  Screens columns: {', '.join(columns)}")
        
        if 'implementation_status' in columns:
            cursor.execute("SELECT COUNT(*) as cnt FROM screens WHERE implementation_status = 'active';")
            active_screens = cursor.fetchone()['cnt']
            print(f"  Active Screens: {active_screens}")
            
    # 2. Total apps
    if 'apps' in tables:
        cursor.execute("SELECT COUNT(*) as cnt FROM apps;")
        total_apps = cursor.fetchone()['cnt']
        print(f"Total Apps in Registry: {total_apps}")
        
    # 3. Workflows
    if 'workflow_runtime_checks' in tables:
        cursor.execute("SELECT COUNT(*) as cnt FROM workflow_runtime_checks;")
        total_workflows = cursor.fetchone()['cnt']
        
        cursor.execute("PRAGMA table_info(workflow_runtime_checks);")
        columns = [row['name'] for row in cursor.fetchall()]
        print(f"  Workflow columns: {', '.join(columns)}")
        
        if 'workflow_status' in columns:
            cursor.execute("SELECT COUNT(*) as cnt FROM workflow_runtime_checks WHERE workflow_status = 'completed';")
            completed_workflows = cursor.fetchone()['cnt']
            print(f"Total Workflows: {total_workflows} (Completed: {completed_workflows})")
        else:
            print(f"Total Workflows: {total_workflows}")
            
    # 4. Test Runs
    if 'test_runs' in tables:
        cursor.execute("PRAGMA table_info(test_runs);")
        columns = [row['name'] for row in cursor.fetchall()]
        print(f"  test_runs columns: {', '.join(columns)}")
        
        cursor.execute("SELECT COUNT(*) as cnt FROM test_runs;")
        runs_cnt = cursor.fetchone()['cnt']
        print(f"Total Test Runs: {runs_cnt}")
        
    conn.close()

if __name__ == '__main__':
    main()
