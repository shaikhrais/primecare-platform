import sqlite3
import re

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()
    
    c.execute("SELECT id, route_path, screen_name FROM screens")
    screens = c.fetchall()
    
    # We want to see how we can extract roles from route paths
    print("Example screens and routes:")
    for s in screens[:50]:
        print(f"ID: {s['id']} | Route: {s['route_path']} | Name: {s['screen_name']}")
        
    print("\nExtracting potential roles from routes:")
    # We can match:
    # 1. /offices/{category}/roles/{role_key}/...
    # 2. /roles/{role_key}/...
    # 3. or other formats. Let's see if we can match any pattern
    roles_matched = set()
    for s in screens:
        route = s['route_path']
        if not route:
            continue
        # Check /offices/{category}/roles/{role_key}/
        m = re.search(r'/offices/[^/]+/roles/([^/]+)', route)
        if m:
            roles_matched.add((m.group(1), 'offices'))
            continue
        
        # Check /roles/{role_key}/
        m2 = re.search(r'/roles/([^/]+)', route)
        if m2:
            roles_matched.add((m2.group(1), 'roles'))
            continue
            
    print(f"Found {len(roles_matched)} roles from regex patterns:")
    for r, source in sorted(roles_matched):
        print(f"Role Key: {r} (source: {source})")
        
    conn.close()

if __name__ == "__main__":
    main()
