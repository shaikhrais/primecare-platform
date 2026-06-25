import re
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
REGISTRY_PATH = os.path.join(PROJECT_ROOT, "packages", "flutter_core", "lib", "registry", "platform_screen_registry.dart")

def main():
    if not os.path.exists(REGISTRY_PATH):
        print(f"Registry not found at {REGISTRY_PATH}")
        return
        
    content = open(REGISTRY_PATH, encoding='utf-8').read()
    
    # Let's find all blocks:
    # 'COO_DASHBOARD': ScreenMetadata(...)
    # and parse them.
    matches = re.finditer(r"'(\w+)'\s*:\s*ScreenMetadata\(", content)
    
    dashboards = []
    for match in matches:
        screen_id = match.group(1)
        start_idx = match.end()
        # Find matching parenthesis
        depth = 1
        i = start_idx
        while i < len(content) and depth > 0:
            if content[i] == '(':
                depth += 1
            elif content[i] == ')':
                depth -= 1
            i += 1
        body = content[start_idx:i-1]
        
        route_match = re.search(r"routePath:\s*['\"]([^'\"]+)['\"]", body)
        route_path = route_match.group(1) if route_match else ""
        
        roles_match = re.search(r"allowedRoles:\s*\[(.*?)\]", body)
        allowed_roles = []
        if roles_match:
            roles_str = roles_match.group(1)
            allowed_roles = [r.strip("'\" ") for r in roles_str.split(',') if r.strip()]
            
        if "DASHBOARD" in screen_id:
            dashboards.append({
                "id": screen_id,
                "routePath": route_path,
                "allowedRoles": allowed_roles
            })
            
    print(f"Parsed {len(dashboards)} dashboards from registry:")
    for db in dashboards:
        print(db)

if __name__ == '__main__':
    main()
