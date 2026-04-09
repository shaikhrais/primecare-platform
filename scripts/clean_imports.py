import os
import re

APPS_DIR = 'apps'
print('Cleaning imports...')

for app_folder in os.listdir(APPS_DIR):
    routes_dir = os.path.join(APPS_DIR, app_folder, 'lib', 'routes', 'groups')
    if not os.path.exists(routes_dir): continue
    
    for route_file in os.listdir(routes_dir):
        if not route_file.endswith('_routes.dart'): continue
        route_fpath = os.path.join(routes_dir, route_file)
        
        with open(route_fpath, 'r', encoding='utf-8') as f:
            content = f.read()

        original_content = content
        
        # Remove imports that match '../../offices/...'
        # It can span multiple lines because `as some_alias;` might be on the next line.
        # \s*as\s+[a-zA-Z0-9_]+; matching alias. Let's just match till `;`
        content = re.sub(r"import\s+'\.\./\.\./.*?offices/[^;]+;", "", content, flags=re.DOTALL)
        content = re.sub(r"import\s+'\.\./.*?offices/[^;]+;", "", content, flags=re.DOTALL)

        if content != original_content:
            with open(route_fpath, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"Cleaned {route_fpath}")

print('Done cleaning.')
