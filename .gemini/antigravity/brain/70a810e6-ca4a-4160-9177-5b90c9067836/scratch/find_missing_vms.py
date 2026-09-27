
import os
import re

core_path = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core'
adapter_providers_path = os.path.join(core_path, 'lib', 'adapter_providers.dart')

if not os.path.exists(adapter_providers_path):
    print(f"File not found: {adapter_providers_path}")
    exit(1)

with open(adapter_providers_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Find all imports like: import 'features/xxx/domain/models/xxx_view_model.dart';
imports = re.findall(r"import 'features/(.*?)/domain/models/(.*?)\.dart';", content)

missing_files = []
for feature_dir, filename in imports:
    full_path = os.path.join(core_path, 'lib', 'features', feature_dir, 'domain', 'models', f'{filename}.dart')
    if not os.path.exists(full_path):
        missing_files.append((feature_dir, filename, full_path))

print(f"Found {len(missing_files)} missing ViewModel files.")
for f_dir, fname, path in missing_files:
    print(f"MISSING: {path}")
