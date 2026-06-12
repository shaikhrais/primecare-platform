import json
import re

with open(r'c:\Users\Admin2\Documents\GitHub\primecare-platform\cypress\fixtures\governance\test_users.json', 'r') as f:
    users = json.load(f)

user_roles = sorted(list(set(u['role_code'] for u in users)))

with open(r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\lib\routes\route_guard.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Parse the _defaultRolePermissions keys
perm_keys = re.findall(r"'(.*?)'\s*:\s*\[", content)

print("Roles in test_users.json:", len(user_roles))
print("Roles in route_guard.dart:", len(perm_keys))
print("\nMissing from route_guard.dart:")
for role in user_roles:
    # Check if this role code matches any key in route_guard (directly or as prefix/substring)
    normalized = role.lower().replace('_', '').replace(' ', '')
    matched = False
    for pk in perm_keys:
        normalized_pk = pk.lower().replace('_', '').replace(' ', '')
        if normalized == normalized_pk or normalized in normalized_pk or normalized_pk in normalized:
            matched = True
            break
    if not matched:
        print(f"- {role}")
