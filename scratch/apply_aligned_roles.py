import sqlite3
import re

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def main():
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    c.execute("SELECT id, route_path, screen_name FROM screens")
    screens = c.fetchall()
    
    matched = 0
    unmatched = 0
    role_map = {}
    
    # Standard role codes from roles table
    c.execute("SELECT role_code, role_name FROM roles")
    db_roles = {r[0]: r[1] for r in c.fetchall()}
    
    for s in screens:
        route = s[1]
        if not route:
            unmatched += 1
            continue
            
        role_key = None
        category = 'common'
        
        # 1. offices pattern: /offices/{category}/roles/{role_key}/
        m = re.search(r'/offices/([^/]+)/roles/([^/]+)', route)
        if m:
            category = m.group(1)
            role_key = m.group(2)
        else:
            # 2. roles pattern: /roles/{role_key}/
            m2 = re.search(r'/roles/([^/]+)', route)
            if m2:
                role_key = m2.group(1)
            else:
                # 3. First level folders: /clinical/cns-dashboard -> cns
                # Or check first folder + ending
                parts = route.strip('/').split('/')
                if len(parts) > 1:
                    first = parts[0]
                    second = parts[1]
                    # Check if second contains a role code
                    for rkey in db_roles.keys():
                        if second.startswith(f"{rkey}-") or second.endswith(f"-{rkey}") or second == rkey:
                            role_key = rkey
                            category = first
                            break
                elif len(parts) == 1:
                    # e.g. /clinical-dashboard
                    pass
                    
        # Apply standard mappings
        if role_key == 'client':
            role_key = 'patient'
        elif role_key == 'intake_coordinator':
            role_key = 'intake'
        elif role_key == 'franchise_sales_manager':
            role_key = 'franchise_sales'
        elif role_key == 'head_of_bus_dev':
            role_key = 'bus_dev'
        elif role_key == 'head_of_marketing':
            role_key = 'marketing'
        elif role_key == 'local_marketing_manager':
            role_key = 'local_marketing'
        elif role_key == 'regional_manager_ontario':
            role_key = 'regional_manager_usa'
        elif role_key == 'scheduler_coordinator':
            role_key = 'scheduler'
        elif role_key == 'compliance_manager':
            role_key = 'compliance'
        elif role_key == 'hr_manager':
            role_key = 'hr_hiring'
        elif role_key == 'regional_manager':
            role_key = 'regional_manager_usa'
        elif role_key == 'physiotherapist':
            role_key = 'physio'
        elif role_key == 'marketing_manager':
            role_key = 'marketing'
            
        if role_key:
            matched += 1
            if role_key not in role_map:
                role_map[role_key] = []
            role_map[role_key].append(s)
        else:
            unmatched += 1
            
    print(f"Matched: {matched}")
    print(f"Unmatched: {unmatched}")
    print(f"Roles detected: {len(role_map)}")
    for r, scr in sorted(role_map.items(), key=lambda x: len(x[1]), reverse=True):
        print(f"Role: {r} | Screens: {len(scr)}")
        
    conn.close()

if __name__ == "__main__":
    main()
