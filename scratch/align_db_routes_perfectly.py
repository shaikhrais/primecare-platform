import sqlite3
import re

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()
    
    # 1. Load roles
    c.execute("SELECT role_code, role_name FROM roles")
    roles_list = c.fetchall()
    role_codes = {r['role_code']: r['role_name'] for r in roles_list}
    
    # 2. Query all screens
    c.execute("SELECT id, route_path, screen_name FROM screens")
    screens = c.fetchall()
    
    print(f"Total screens in database: {len(screens)}")
    
    unmatched = []
    matched = {}
    
    for s in screens:
        route = s['route_path']
        if not route:
            unmatched.append(s)
            continue
            
        role_key = None
        role_category = 'common'
        
        # Pattern 1: /offices/{category}/roles/{role_key}/
        m1 = re.search(r'/offices/([^/]+)/roles/([^/]+)', route)
        if m1:
            role_category = m1.group(1)
            role_key = m1.group(2)
        else:
            # Pattern 2: /roles/{role_key}/
            m2 = re.search(r'/roles/([^/]+)', route)
            if m2:
                role_key = m2.group(1)
            else:
                # Pattern 3: Extract from first folder and naming, e.g. /clinical/cns-dashboard
                # Check if route is /{category}/{role_key}-dashboard or /{category}/{role_key}-analytics
                m3 = re.search(r'^/([^/]+)/([^/-]+)-', route)
                if m3:
                    cat = m3.group(1)
                    key = m3.group(2)
                    # replace hyphens with underscores
                    key = key.replace('-', '_')
                    if key in role_codes:
                        role_category = cat
                        role_key = key
                
                # Check if route starts with /rn/
                if not role_key and route.startswith('/rn/'):
                    role_category = 'clinical'
                    # like /rn/cns-analytics -> cns
                    # or /rn/rn-tasks -> rn
                    for rkey in sorted(role_codes.keys(), key=len, reverse=True):
                        if route.startswith(f'/rn/{rkey}-') or route == f'/rn/{rkey}':
                            role_key = rkey
                            break
                    if not role_key:
                        role_key = 'rn'
                
                # Check other prefixes
                if not role_key:
                    # Let's search the route for any role code
                    # To avoid false positive short codes, sort role keys by length descending
                    for rkey in sorted(role_codes.keys(), key=len, reverse=True):
                        # check if the role key is present in the route path as a segment
                        cleaned_route = route.replace('-', '_')
                        if f'/{rkey}/' in cleaned_route or f'/{rkey}_' in cleaned_route or f'_{rkey}/' in cleaned_route or cleaned_route.endswith(f'/{rkey}') or cleaned_route.endswith(f'_{rkey}') or f'/{rkey}-' in route or f'-{rkey}/' in route or route.endswith(f'-{rkey}'):
                            role_key = rkey
                            # Infer category from first segment
                            role_category = route.split('/')[1] if len(route.split('/')) > 1 else 'common'
                            break
        
        # Standardize known aliases or sub-roles
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
            role_key = 'regional_manager_usa' # Group similar ones or keep as is? Let's check roles table.
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
            
        if role_key and role_key in role_codes:
            matched[s['id']] = (role_key, role_codes[role_key], role_category)
        else:
            unmatched.append(s)
            
    print(f"Matched: {len(matched)}")
    print(f"Unmatched: {len(unmatched)}")
    print("\nSome unmatched:")
    for u in unmatched[:20]:
        print(f"ID: {u['id']} | Route: {u['route_path']} | Name: {u['screen_name']}")
        
    conn.close()

if __name__ == "__main__":
    main()
