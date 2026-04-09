import os
import re

app_routes_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\lib\routes\app_routes.dart"
groups_dir = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\lib\routes\groups"
flutter_core_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\lib\flutter_core.dart"

with open(app_routes_path, 'r', encoding='utf-8') as f:
    text = f.read()

# Match: static const String xyz = '/some/route';
route_pattern = re.compile(r"static\s+const\s+String\s+(\w+)\s*=\s*'([^']+)';")

routes = []
for match in route_pattern.finditer(text):
    routes.append((match.group(1), match.group(2)))

groups = {
    'AdminRoutes': [],
    'BusinessDevelopmentRoutes': [],
    'ClientRoutes': [],
    'ClinicalRoutes': [],
    'CorporateRoutes': [],
    'FranchiseRoutes': [],
    'MarketingRoutes': [],
    'SupportRoutes': [],
    'CommonRoutes': []
}

mapping = {}

for var_name, route_str in routes:
    if '/offices/admin/' in route_str:
        group = 'AdminRoutes'
    elif '/offices/business_development/' in route_str:
        group = 'BusinessDevelopmentRoutes'
    elif '/offices/client/' in route_str:
        group = 'ClientRoutes'
    elif '/offices/clinical/' in route_str:
        group = 'ClinicalRoutes'
    elif '/offices/corporate/' in route_str:
        group = 'CorporateRoutes'
    elif '/offices/franchise/' in route_str:
        group = 'FranchiseRoutes'
    elif '/offices/marketing/' in route_str:
        group = 'MarketingRoutes'
    elif '/offices/support/' in route_str:
        group = 'SupportRoutes'
    else:
        group = 'CommonRoutes'
        
    groups[group].append((var_name, route_str))
    mapping[var_name] = group

os.makedirs(groups_dir, exist_ok=True)

group_files = []

for group_class, route_list in groups.items():
    file_name = re.sub(r'(?<!^)(?=[A-Z])', '_', group_class).lower() + ".dart"
    group_files.append(file_name)
    file_path = os.path.join(groups_dir, file_name)
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(f"class {group_class} {{\n")
        f.write(f"  const {group_class}._();\n\n")
        for v, r in route_list:
            f.write(f"  static const String {v} = '{r}';\n")
        f.write("}\n")
        

# Update flutter_core.dart exports
with open(flutter_core_path, 'r', encoding='utf-8') as f:
    fc_content = f.read()

new_exports = "\n".join([f"export 'routes/groups/{gf}';" for gf in group_files])
fc_content = fc_content.replace("export 'routes/app_routes.dart';", new_exports)

with open(flutter_core_path, 'w', encoding='utf-8') as f:
    f.write(fc_content)

# Replace in all dart files
repo_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
count_replacements = 0

for root, _, files in os.walk(repo_path):
    if "archive" in root or ".git" in root or ".dart_tool" in root or "build" in root:
        continue
    for fn in files:
        if fn.endswith('.dart'):
            fp = os.path.join(root, fn)
            with open(fp, 'r', encoding='utf-8') as f:
                content = f.read()
            original_content = content
            
            def replacer(match):
                var = match.group(1)
                group = mapping.get(var, 'AppRoutes')
                return f"{group}.{var}"
                
            new_content = re.sub(r'AppRoutes\.(\w+)', replacer, content)
            
            if new_content != original_content:
                count_replacements += 1
                with open(fp, 'w', encoding='utf-8') as f:
                    f.write(new_content)

# Delete original file
os.remove(app_routes_path)

print(f"Replaced strings in {count_replacements} files.")
