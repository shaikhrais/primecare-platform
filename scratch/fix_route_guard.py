import json
import os
import re

# Paths
route_guard_path = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\lib\routes\route_guard.dart"
test_users_path = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\cypress\fixtures\governance\test_users.json"

# Load test users
with open(test_users_path, 'r', encoding='utf-8') as f:
    users = json.load(f)

# Load RouteGuard content
with open(route_guard_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Parse existing permissions using regex
pattern = r"static final Map<String, List<String>> _defaultRolePermissions = \{(.*?)\};"
match = re.search(pattern, content, re.DOTALL)
if not match:
    print("Could not find _defaultRolePermissions block!")
    exit(1)

existing_block = match.group(1)

# Parse existing map elements
# Format: 'role_name': ['path1', 'path2'],
element_pattern = r"'(.*?)'\s*:\s*\[(.*?)\]"
elements = re.findall(element_pattern, existing_block)

permissions_map = {}
for role, paths_str in elements:
    paths = [p.strip().strip("'").strip('"') for p in paths_str.split(',') if p.strip()]
    permissions_map[role] = paths

# Now update with users from test_users.json
for user in users:
    role_code = user['role_code']
    post_login_route = user['post_login_route']
    
    # Extract first segment of post_login_route
    # e.g., /executive/executive-command-center -> /executive
    route_parts = [p for p in post_login_route.split('/') if p]
    if route_parts:
        first_segment = '/' + route_parts[0]
    else:
        first_segment = '/'
        
    # Standardize/normalize role code for route_guard (lowercase, spaces to underscore)
    normalized_role = role_code.lower().replace(' ', '_').replace('/', '_')
    
    if normalized_role not in permissions_map:
        permissions_map[normalized_role] = []
        
    # Ensure the first segment of post_login_route is in the allowed prefixes
    if first_segment not in permissions_map[normalized_role]:
        permissions_map[normalized_role].append(first_segment)
        
    # Also ensure some general defaults
    if '/common' not in permissions_map[normalized_role]:
        permissions_map[normalized_role].append('/common')
        
    # Preserve/add app-specific prefixes if missing
    app_code = user['app_code']
    if app_code == 'clinic':
        for p in ['/offices/clinical', '/clinic', '/dynamic']:
            if p not in permissions_map[normalized_role]:
                permissions_map[normalized_role].append(p)
    elif app_code == 'corporate':
        for p in ['/offices/corporate']:
            if p not in permissions_map[normalized_role]:
                permissions_map[normalized_role].append(p)
    elif app_code == 'franchise':
        for p in ['/offices/franchise']:
            if p not in permissions_map[normalized_role]:
                permissions_map[normalized_role].append(p)
    elif app_code == 'support':
        for p in ['/offices/support', '/dynamic']:
            if p not in permissions_map[normalized_role]:
                permissions_map[normalized_role].append(p)
    elif app_code == 'business_development':
        for p in ['/offices/business_development']:
            if p not in permissions_map[normalized_role]:
                permissions_map[normalized_role].append(p)
    elif app_code == 'marketing':
        for p in ['/offices/marketing']:
            if p not in permissions_map[normalized_role]:
                permissions_map[normalized_role].append(p)
    elif app_code == 'governance':
        for p in ['/offices/governance']:
            if p not in permissions_map[normalized_role]:
                permissions_map[normalized_role].append(p)
    elif app_code == 'client':
        for p in ['/offices/client']:
            if p not in permissions_map[normalized_role]:
                permissions_map[normalized_role].append(p)

# Format the new _defaultRolePermissions block nicely
new_block_lines = ["  static final Map<String, List<String>> _defaultRolePermissions = {"]
for role in sorted(permissions_map.keys()):
    paths_str = ", ".join(f"'{p}'" for p in permissions_map[role])
    new_block_lines.append(f"    '{role}': [{paths_str}],")
new_block_lines.append("  };")

new_block = "\n".join(new_block_lines)

# Replace in content
pattern_full = r"static final Map<String, List<String>> _defaultRolePermissions = \{.*?\};"
updated_content = re.sub(pattern_full, new_block, content, flags=re.DOTALL)

with open(route_guard_path, 'w', encoding='utf-8') as f:
    f.write(updated_content)

print("Successfully updated RouteGuard permissions map!")
