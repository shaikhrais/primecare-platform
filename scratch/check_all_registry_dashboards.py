import sqlite3
import re

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def main():
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    
    c.execute("SELECT id, route_path, screen_name FROM screens")
    screens = c.fetchall()
    
    roles_detected = {}
    unmatched_routes = []
    
    for s in screens:
        route = s[1]
        if not route:
            continue
            
        # Try to extract role from route path
        m = re.search(r'/roles/([^/]+)', route)
        if m:
            role_key = m.group(1)
            # Remove any trailing segments if any, but re.search(r'/roles/([^/]+)', route) gets the next segment
            # E.g. /offices/clinical/roles/rmt/dashboard -> rmt
            # E.g. /offices/clinical/roles/rmt/appointments -> rmt
            category = 'common'
            m_cat = re.search(r'/offices/([^/]+)/roles/', route)
            if m_cat:
                category = m_cat.group(1)
            else:
                m_cat2 = re.search(r'^/([^/]+)/roles/', route)
                if m_cat2:
                    category = m_cat2.group(1)
            
            if role_key not in roles_detected:
                roles_detected[role_key] = {
                    'category': category,
                    'screens': []
                }
            roles_detected[role_key]['screens'].append(s)
        else:
            unmatched_routes.append(s)
            
    print(f"Total screens: {len(screens)}")
    print(f"Total screens matching '/roles/': {sum(len(info['screens']) for info in roles_detected.values())}")
    print(f"Total distinct roles detected: {len(roles_detected)}")
    print(f"Total unmatched screens: {len(unmatched_routes)}")
    
    print("\nRoles detected from paths:")
    for role_key, info in sorted(roles_detected.items()):
        print(f"Role: {role_key} | Category: {info['category']} | Screens count: {len(info['screens'])}")
        
    print("\nSome unmatched routes:")
    for s in unmatched_routes[:20]:
        print(f"ID: {s[0]} | Route: {s[1]} | Name: {s[2]}")
        
    conn.close()

if __name__ == "__main__":
    main()
