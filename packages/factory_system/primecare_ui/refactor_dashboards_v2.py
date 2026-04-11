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

def snake_to_pascal(snake_str):
    return "".join(x.capitalize() for x in snake_str.split('_'))

def camel_to_pascal(camel_str):
    return camel_str[0].upper() + camel_str[1:]

# 2. Refactoring Patterns
PROVIDER_CALL_RE = re.compile(r'ref\.watch\((\w+(?:DataProvider|AdapterProvider))\)')
LEGACY_PROVIDERS_RE = re.compile(r"ref\.watch\(\s*dashboardMetricsProvider\('(\w+)'\)\s*\)")
DATA_BLOCK_RE = re.compile(r'data:\s*\((?P<type>\w+)\s+liveData\)\s*\{.*?\}(?=\s*,\s*)', re.DOTALL)

def refactor_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    original_content = content

    # A. Remove sections imports
    content = re.sub(r"import\s+'package:primecare_ui/src/screens/offices/.*?/sections/.*?\.dart';\s*", "", content)
    
    # B. Fix primecare_adapters import to avoid ambiguity
    if "import 'package:primecare_adapters/primecare_adapters.dart';" in content:
        content = content.replace(
            "import 'package:primecare_adapters/primecare_adapters.dart';",
            f"import 'package:primecare_adapters/primecare_adapters.dart' {HIDE_CLAUSE};"
        )

    # C. Replace legacy dashboardMetricsProvider('role') -> roleDataProvider('all')
    def legacy_provider_replace(match):
        role_name = match.group(1)
        # Assuming role_name matches the prefix of our data provider
        # e.g. 'franchiseSalesManagerDashboard' -> 'franchiseSalesManagerDashboardDataProvider'
        target_pname = role_name + 'DataProvider'
        if target_pname in CENTRAL_PROVIDERS:
            return f"ref.watch({target_pname}('all'))"
        # Fallback if pattern doesn't quite match
        return match.group(0)

    content = LEGACY_PROVIDERS_RE.sub(legacy_provider_replace, content)

    # D. Fix provider calls: watch(provider) -> watch(provider('all'))
    def provider_replace(match):
        pname = match.group(1)
        start = match.end()
        # Skip if already called with arguments
        if content[start:start+1] == '(':
            return match.group(0)

        target_pname = pname
        if pname.endswith('AdapterProvider'):
            base = pname.replace('AdapterProvider', '')
            dname = base + 'DataProvider'
            if dname in CENTRAL_PROVIDERS:
                target_pname = dname
        
        if target_pname in CENTRAL_PROVIDERS:
            return f"ref.watch({target_pname}('all'))"
        return match.group(0)

    content = PROVIDER_CALL_RE.sub(provider_replace, content)

    # E. Replace data block with AssemblyLine
    # And fix the type if it was DashboardMetrics
    def data_replace(match):
        type_name = match.group('type')
        # If the type is DashboardMetrics, we need to infer the correct ViewModel type
        # For now, let's keep it and see if the provider change fixed the inference.
        # Actually, let's try to infer from the file name or provider.
        return f"""data: ({type_name} liveData) {{
                return AssemblyLine(
                  blueprints: liveData.blueprints,
                  isOfflineFallback: liveData.isOfflineFallback,
                );
              }}"""

    content = DATA_BLOCK_RE.sub(data_replace, content)
    
    # If type was DashboardMetrics, try a broad replace to a more generic or specific one if we can.
    # But since it's used in and(data: (Type liveData) ...), Dart might be able to infer it if we leave it a bit loose or if it's correct.
    # Let's check for "DashboardMetrics liveData" and try to replace with something that has blueprints.
    # Actually, all our ViewModels now have blueprints.
    
    # F. Final cleanup: Remove unused _inferIcon and _inferColor if we used AssemblyLine
    if "AssemblyLine(" in content:
        content = re.sub(r"IconData _inferIcon\(String title\).*?\{.*?\}\s*(?=Color|$)", "", content, flags=re.DOTALL)
        content = re.sub(r"Color _inferColor\(String status\).*?\{.*?\}\s*(?=} |$)", "", content, flags=re.DOTALL)

    # G. Ensure primecare_ui is imported (for AssemblyLine)
    if "import 'package:primecare_ui/primecare_ui.dart';" not in content and "AssemblyLine" in content:
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
