import os
import re

# Base paths
UI_ROOT = r'C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui'
DASHBOARD_DIR = os.path.join(UI_ROOT, 'lib', 'src', 'screens', 'offices')
PROVIDERS_FILE = r'C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\lib\adapter_providers.dart'

# 1. Get all provider names
def get_central_providers():
    providers = []
    if not os.path.exists(PROVIDERS_FILE):
        return []
    with open(PROVIDERS_FILE, 'r', encoding='utf-8') as f:
        content = f.read()
        matches = re.findall(r'final\s+(\w+Provider)\s*=', content)
        providers.extend(matches)
    return sorted(list(set(providers)))

CENTRAL_PROVIDERS = get_central_providers()
CONFLICTING_PATTERNS = [p for p in CENTRAL_PROVIDERS if "Dashboard" in p or "Adapter" in p]
HIDE_CLAUSE = f"hide {', '.join(CONFLICTING_PATTERNS)}"

def camel_to_pascal(camel_str):
    return camel_str[0].upper() + camel_str[1:]

# 2. Refactoring Patterns
# Regex to match multi-line dashboardMetricsProvider calls
LEGACY_PROVIDERS_RE = re.compile(r"ref\.watch\(\s*dashboardMetricsProvider\('(\w+)'\),?\s*\)", re.DOTALL)
# Improved DATA_BLOCK_RE
DATA_BLOCK_RE = re.compile(r'data:\s*\((?P<type>\w+)\s+liveData\)\s*\{.*?\}(?=\s*,\s*)', re.DOTALL)

def refactor_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    original_content = content

    # A. Remove sections imports
    content = re.sub(r"import\s+'package:primecare_ui/src/screens/offices/.*?/sections/.*?\.dart';\s*", "", content)
    
    # B. Fix ambiguous imports
    if "import 'package:primecare_adapters/primecare_adapters.dart';" in content:
        content = content.replace(
            "import 'package:primecare_adapters/primecare_adapters.dart';",
            f"import 'package:primecare_adapters/primecare_adapters.dart' {HIDE_CLAUSE};"
        )

    # C. Replace legacy dashboardMetricsProvider('role') -> roleDataProvider('all')
    def legacy_provider_replace(match):
        role_name = match.group(1)
        # Handle cases where the role name string is plural or slightly different if needed
        # But generally it's camelCase role name + Dashboard
        target_pname = role_name + 'DataProvider'
        if target_pname in CENTRAL_PROVIDERS:
            return f"ref.watch({target_pname}('all'))"
        
        # Try without 'Dashboard' suffix if it's already there?
        # e.g. mapping 'franchiseSalesManagerDashboard' to 'franchiseSalesManagerDashboardDataProvider'
        return f"ref.watch({target_pname}('all'))" # Force it if we are sure

    content = LEGACY_PROVIDERS_RE.sub(legacy_provider_replace, content)

    # D. Fix existing provider calls (already handled mostly, but multi-line might have missed)
    content = re.sub(r"ref\.watch\((\w+DataProvider)\)(?!\()", r"ref.watch(\1('all'))", content)

    # E. Replace data block with AssemblyLine and fix ViewModel type
    def data_replace(match):
        type_name = match.group('type')
        # If type is DashboardMetrics, try to change it to something that works
        if type_name == "DashboardMetrics":
            # Attempt to infer from the file name
            basename = os.path.basename(filepath)
            role_part = basename.replace('_dashboard.dart', '').replace('_screen.dart', '')
            # snake_to_pascal
            pascal_role = "".join(x.capitalize() for x in role_part.split('_'))
            # Special cases or generic mapping
            type_name = f"{pascal_role}DashboardViewModel"
        
        return f"""data: ({type_name} liveData) {{
                return AssemblyLine(
                  blueprints: liveData.blueprints,
                  isOfflineFallback: liveData.isOfflineFallback,
                );
              }}"""

    content = DATA_BLOCK_RE.sub(data_replace, content)

    # F. Cleanup unused methods
    if "AssemblyLine(" in content:
        content = re.sub(r"IconData _inferIcon\(String title\).*?\{.*?\}\s*", "", content, flags=re.DOTALL)
        content = re.sub(r"Color _inferColor\(String status\).*?\{.*?\}\s*", "", content, flags=re.DOTALL)

    # G. Ensure imports
    if "AssemblyLine" in content and "import 'package:primecare_ui/primecare_ui.dart';" not in content:
        imports = re.findall(r'^import\s+.*?;', content, re.MULTILINE)
        if imports:
            last_import = imports[-1]
            content = content.replace(last_import, last_import + "\nimport 'package:primecare_ui/primecare_ui.dart';")

    if content != original_content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        return True
    return False

# 3. Walk and refactor
modified_count = 0
for root, dirs, files in os.walk(DASHBOARD_DIR):
    for name in files:
        if name.endswith('.dart'):
            fullpath = os.path.join(root, name)
            if refactor_file(fullpath):
                print(f"Refactored: {fullpath}")
                modified_count += 1

print(f"Total files refactored: {modified_count}")
