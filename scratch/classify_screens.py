import sqlite3
import json

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()
    
    # Let's inspect the roles table and their sidebar_config_json
    c.execute("SELECT role_code, role_name, sidebar_config_json, allowed_menu_json FROM roles")
    roles = c.fetchall()
    
    print(f"Total roles in database: {len(roles)}")
    
    # Build a map of route_path -> role_code based on roles table
    route_to_role = {}
    for r in roles:
        role_code = r['role_code']
        # Try to parse sidebar_config_json
        sidebar_json = r['sidebar_config_json']
        if sidebar_json:
            try:
                sidebar_data = json.loads(sidebar_json)
                items = sidebar_data.get('items', [])
                for item in items:
                    route = item.get('route')
                    if route:
                        route_to_role[route] = (role_code, r['role_name'])
            except Exception as e:
                print(f"Error parsing sidebar_config_json for {role_code}: {e}")
                
    print(f"Mapped {len(route_to_role)} unique routes to roles from sidebar_config_json.")
    
    # Now let's query all screens and see how many are matched
    c.execute("SELECT id, route_path, screen_name FROM screens")
    screens = c.fetchall()
    
    matched_count = 0
    unmatched_screens = []
    for s in screens:
        route = s['route_path']
        if route in route_to_role:
            matched_count += 1
        else:
            unmatched_screens.append(s)
            
    print(f"Matched {matched_count} / {len(screens)} screens to roles using sidebar_config_json.")
    print(f"Unmatched screens count: {len(unmatched_screens)}")
    print("\nSome unmatched screens:")
    for s in unmatched_screens[:20]:
        print(f"ID: {s['id']} | Route: {s['route_path']} | Name: {s['screen_name']}")
        
    conn.close()

if __name__ == "__main__":
    main()
