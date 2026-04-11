import os
import re

# Base paths
UI_ROOT = r'C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui'
DASHBOARD_DIR = os.path.join(UI_ROOT, 'lib', 'src', 'screens', 'offices')
PROVIDERS_FILE = r'C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\lib\adapter_providers.dart'

# 1. Get all provider names from flutter_core/adapter_providers.dart to hide them from primecare_adapters
def get_central_providers():
    providers = []
    if not os.path.exists(PROVIDERS_FILE):
        return []
    with open(PROVIDERS_FILE, 'r', encoding='utf-8') as f:
        content = f.read()
        # Match final xxxProvider = ...
        matches = re.findall(r'final\s+(\w+Provider)\s*=', content)
        providers.extend(matches)
    return sorted(list(set(providers)))

CENTRAL_PROVIDERS = get_central_providers()
# Generate a shorter hide clause if possible, or group them. 
# For now, let's just list the ones that actually conflict.
# Common conflicts: any DashboardDataProvider or DashboardAdapterProvider
CONFLICTING_PATTERNS = [p for p in CENTRAL_PROVIDERS if "Dashboard" in p or "Adapter" in p]
HIDE_CLAUSE = f"hide {', '.join(CONFLICTING_PATTERNS)}"

# 2. Refactoring Patterns
PROVIDER_CALL_RE = re.compile(r'ref\.watch\((\w+(?:DataProvider|AdapterProvider))\)')
# Improved DATA_BLOCK_RE to be more flexible with newlines and spacing
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

    # C. Fix provider calls: watch(provider) -> watch(provider('all'))
    def provider_replace(match):
        pname = match.group(1)
        # Check if already has ('all') or similar
        start = match.end()
        if content[start:start+1] == '(':
            return match.group(0) # Already called as function

        # Try to map AdapterProvider to DataProvider if needed
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

    # D. Replace data block with AssemblyLine
    def data_replace(match):
        type_name = match.group('type')
        return f"""data: ({type_name} liveData) {{
                return AssemblyLine(
                  blueprints: liveData.blueprints,
                  isOfflineFallback: liveData.isOfflineFallback,
                );
              }}"""

    content = DATA_BLOCK_RE.sub(data_replace, content)

    # E. Ensure primecare_ui is imported (for AssemblyLine)
    if "import 'package:primecare_ui/primecare_ui.dart';" not in content and "AssemblyLine" in content:
        # Insert after the last import
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
