import sqlite3
import os
import re

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    # 1. Get all roles
    cursor.execute("SELECT id, role_code FROM roles")
    roles = [dict(r) for r in cursor.fetchall()]
    
    # Sort roles by descending length of role_code to match longer strings first (e.g. volunteer_coordinator before volunteer)
    roles.sort(key=lambda x: len(x["role_code"]), reverse=True)
    
    # 2. Query screens with NULL role_id or allowed_roles_text
    cursor.execute("SELECT id, screen_code, route_path, actual_file_path, role_id, allowed_roles_text FROM screens")
    screens = [dict(r) for r in cursor.fetchall()]
    
    unassigned_count = 0
    updated_count = 0
    
    print("Screen Role Alignment Analysis:")
    
    for scr in screens:
        curr_role_id = scr["role_id"]
        curr_allowed = scr["allowed_roles_text"]
        scr_id = scr["id"]
        code = scr["screen_code"] or ""
        route = scr["route_path"] or ""
        path = scr["actual_file_path"] or ""
        
        target_role = None
        
        # Heuristics:
        # Check if any role_code matches:
        # 1. in the route path (e.g. /roles/ceo/ or /ceo/)
        # 2. as prefix of screen_code (e.g. ceo_dashboard)
        # 3. in the file path
        
        for r in roles:
            rcode = r["role_code"]
            
            # Form clean tokens or patterns
            # Pattern 1: /role_code/ or /roles/role_code/ in route
            route_pattern = rf"/(roles/)?{rcode}(/|$)"
            # Pattern 2: starts with role_code + _
            code_pattern = rf"^{rcode}_"
            
            if re.search(route_pattern, route) or re.search(code_pattern, code) or f"/{rcode}/" in path or f"_{rcode}_" in path:
                target_role = r
                break
                
        # Specialized mapping fallback
        if not target_role:
            # Check custom matches
            if "physiotherapist" in route or "physio" in code:
                # physio role ID is 2
                target_role = {"id": 2, "role_code": "physio"}
            elif "general_manager" in route or "general_manager" in path:
                # gm role ID is 35
                target_role = {"id": 35, "role_code": "gm"}
            elif "talent_acquisition" in route or "talent_acquisition" in path:
                # hr_hiring role ID is 45
                target_role = {"id": 45, "role_code": "hr_hiring"}
            elif "franchise_owner" in route or "franchise_owner" in path:
                # owner role ID is 29
                target_role = {"id": 29, "role_code": "owner"}
            elif "compliance_manager" in route or "compliance_manager" in path:
                # compliance role ID is 33
                target_role = {"id": 33, "role_code": "compliance"}
            elif "head_of_bus_dev" in route or "head_of_bus_dev" in path:
                # bus_dev role ID is 37
                target_role = {"id": 37, "role_code": "bus_dev"}
            elif "head_of_marketing" in route or "head_of_marketing" in path:
                # marketing role ID is 38
                target_role = {"id": 38, "role_code": "marketing"}
            elif "volunteer_coordinator" in route or "volunteer_coordinator" in path:
                # volunteer_coordinator role ID is 48
                target_role = {"id": 48, "role_code": "volunteer_coordinator"}
            elif "office" in route or "office" in path:
                # admin role ID is 59
                target_role = {"id": 59, "role_code": "admin"}
                
        if target_role:
            new_role_id = target_role["id"]
            new_allowed = target_role["role_code"]
            
            if curr_role_id != new_role_id or curr_allowed != new_allowed:
                cursor.execute("""
                    UPDATE screens
                    SET role_id = ?, allowed_roles_text = ?
                    WHERE id = ?;
                """, (new_role_id, new_allowed, scr_id))
                updated_count += 1
                # print(f"  [UPDATE] {code:<30} -> Role: {new_allowed} (ID: {new_role_id})")
        else:
            if curr_role_id is None:
                unassigned_count += 1
                print(f"  [UNASSIGNED] Code: {code:<30} | Route: {route:<45} | Path: {path}")

    conn.commit()
    conn.close()
    
    print(f"\nSummary:")
    print(f"- Total screens aligned/updated: {updated_count}")
    print(f"- Remaining screens unassigned: {unassigned_count}")

if __name__ == "__main__":
    main()

