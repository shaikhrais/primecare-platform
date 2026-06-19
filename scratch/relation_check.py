import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    # Let's inspect screen_functions for CnsDashboardScreen, CourseArchitectDashboardScreen, etc.
    screens = ['cns_dashboard', 'course_architect_dashboard', 'social_worker_dashboard', 'training_hub_dashboard', 'hr_director_dashboard']
    
    for s_code in screens:
        cursor.execute("SELECT id, screen_name FROM screens WHERE screen_code = ?;", (s_code,))
        row = cursor.fetchone()
        if not row:
            print(f"Screen {s_code} not found in DB.")
            continue
            
        screen_id = row['id']
        print(f"\nScreen: {row['screen_name']} (id={screen_id})")
        
        cursor.execute("SELECT id, function_code, function_name FROM screen_functions WHERE screen_id = ?;", (screen_id,))
        funcs = cursor.fetchall()
        for f in funcs:
            print(f"  Func: {f['function_code']} | Name: {f['function_name']} (id={f['id']})")
            
    conn.close()

if __name__ == '__main__':
    main()
