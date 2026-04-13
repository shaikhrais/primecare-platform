import re

file_path = 'C:/Users/Admin2/Documents/GitHub/primecare-platform/packages/flutter_core/lib/adapter_providers.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

new_lines = []
for line in lines:
    if line.startswith('import '):
        if 'features/developer_samples/demo_dashboard_view_model.dart' in line:
            continue
        if 'import \'package:flutter_riverpod/flutter_riverpod.dart\';' in line and any('import \'package:flutter_riverpod/flutter_riverpod.dart\';' in l for l in new_lines):
            continue
        if 'import \'dynamic_registry_map.dart\';' in line and any('import \'dynamic_registry_map.dart\';' in l for l in new_lines):
            continue
        if 'import \'dashboard_providers.dart\';' in line and any('import \'dashboard_providers.dart\';' in l for l in new_lines):
            continue
    new_lines.append(line)

with open(file_path, 'w', encoding='utf-8') as f:
    f.writelines(new_lines)
