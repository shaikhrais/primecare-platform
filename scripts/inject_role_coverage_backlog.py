import sqlite3
import os
import sys

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def inject_coverage():
    print("=====================================================")
    print("Executing Role Screen Coverage Expansion Backlog Injection")
    print("=====================================================")
    
    if not os.path.exists(DB_PATH):
        print(f"Error: Relational database not found at {DB_PATH}")
        sys.exit(1)
        
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    # 1. Fetch all roles
    cursor.execute("SELECT id, role_code, role_name FROM roles;")
    roles = cursor.fetchall()
    
    screens_inserted = 0
    tasks_inserted = 0
    
    for r in roles:
        role_id = r['id']
        role_code = r['role_code']
        role_name = r['role_name']
        
        # Query existing screens for this role
        cursor.execute("""
            SELECT id, screen_code, screen_name, expected_file_path, app_id, route_path
            FROM screens
            WHERE role_id = ?;
        """, (role_id,))
        existing_screens = cursor.fetchall()
        screen_count = len(existing_screens)
        
        if screen_count >= 3:
            continue
            
        print(f"\nProcessing low-coverage role: '{role_code}' ({screen_count} screens)...")
        
        # Deduce app_id and category folder
        app_id = 7 # Default Corporate app
        folder = "executive" # Default category
        
        if screen_count > 0:
            sample = existing_screens[0]
            app_id = sample['app_id']
            path_parts = sample['expected_file_path'].replace('\\', '/').split('/')
            if 'screens' in path_parts:
                s_idx = path_parts.index('screens')
                if s_idx + 1 < len(path_parts):
                    folder = path_parts[s_idx + 1]
                    
        # Identify missing types
        has_dashboard = False
        has_queue = False
        has_detail = False
        
        for s in existing_screens:
            code_lower = s['screen_code'].lower()
            if "dashboard" in code_lower or "command_center" in code_lower or "control_center" in code_lower:
                has_dashboard = True
            elif "queue" in code_lower or "list" in code_lower or "view" in code_lower or "search" in code_lower:
                has_queue = True
            elif "detail" in code_lower or "action" in code_lower or "form" in code_lower or "note" in code_lower:
                has_detail = True
                
        # Build queue of missing types
        needed_types = []
        if not has_dashboard:
            needed_types.append("Dashboard")
        if not has_queue:
            needed_types.append("Work Queue")
        if not has_detail:
            needed_types.append("Detail")
            
        # Bound slots to exact ceiling of 3
        slots_left = 3 - screen_count
        needed_types = needed_types[:slots_left]
        
        for nt in needed_types:
            if nt == "Dashboard":
                code_suffix = "dashboard"
                name_suffix = "DashboardScreen"
                route_suffix = "dashboard"
            elif nt == "Work Queue":
                code_suffix = "work_queue"
                name_suffix = "WorkQueueScreen"
                route_suffix = "work-queue"
            else:
                code_suffix = "detail"
                name_suffix = "DetailScreen"
                route_suffix = "detail"
                
            # Compute screen variables
            role_camel = "".join([part.capitalize() for part in role_code.split('_')])
            screen_name = f"{role_camel}{name_suffix}"
            screen_code = f"{role_code}_{code_suffix}"
            route_path = f"/{folder}/{role_code.replace('_', '-')}-{route_suffix}"
            expected_file_path = f"packages/primecare_ui/lib/src/screens/{folder}/{screen_code}_screen.dart"
            
            # 1. Insert screen
            cursor.execute("""
                INSERT OR IGNORE INTO screens 
                (app_id, role_id, screen_code, screen_name, route_path, expected_file_path, screen_type, screen_status, verification_status)
                VALUES (?, ?, ?, ?, ?, ?, ?, 'planned', 'pending');
            """, (
                app_id,
                role_id,
                screen_code,
                screen_name,
                route_path,
                expected_file_path,
                nt.lower().replace(" ", "_")
            ))
            
            if cursor.rowcount > 0:
                new_screen_id = cursor.lastrowid
                screens_inserted += 1
                print(f"  [NEW SCREEN] Created planned screen: {screen_name} [ID: {new_screen_id}]")
                
                # 2. Insert corresponding implementation task
                cursor.execute("""
                    INSERT INTO implementation_tasks
                    (app_id, task_title, task_description, priority, task_type, related_screen_id, assigned_agent, status)
                    VALUES (?, ?, ?, 'high', 'screen_interaction_audit', ?, 'antigravity_agent', 'pending');
                """, (
                    app_id,
                    f"Scaffold and verify screen: {screen_name}",
                    f"Implement high-fidelity widget, verify import, class, route, and physical rendering for {screen_name}",
                    new_screen_id
                ))
                tasks_inserted += 1
                print(f"  [NEW TASK] Enqueued backlog task for {screen_name}")
                
    conn.commit()
    conn.close()
    
    print("\n=====================================================")
    print("Coverage backlog injection successfully executed!")
    print(f"Total screens inserted: {screens_inserted}")
    print(f"Total tasks enqueued  : {tasks_inserted}")
    print("=====================================================")

if __name__ == "__main__":
    inject_coverage()
