import re
with open('lib/main.dart', 'r', encoding='utf-8') as f:
  c = f.read()

c = c.replace("import 'package:flutter_core/theme/01_I_app_theme.dart';\nimport 'package:primecare_ui/primecare_ui.dart';", "import 'package:primecare_ui/primecare_ui.dart';")

c = re.sub(r'const (DataCell\(Text\(\'[A-Z0-9-]+\'\)\)),', r'\1,', c)
c = re.sub(r'const (DataCell\(Text\(\'[A-Za-z -]+\'\)\)),', r'\1,', c)
c = re.sub(r'const (DataCell\(Text\(\'apps/[A-Za-z_/-]+\'\)\)),', r'\1,', c)

# Also fix any `const` arrays holding `_buildBadge` or `AppTheme`.
# We can just remove `const` from `const [` if it contains `DataRow` or something, but it might be easier to remove `const` from specific lines.
# Actually let's just remove `const` before `TextStyle` if it contains AppTheme
c = c.replace('const TextStyle', 'TextStyle')
c = c.replace('const DataRow', 'DataRow')
c = c.replace('const DataCell', 'DataCell')

# For any `const` lists that contain _buildBadge, we must remove `const` from `const [`
c = c.replace('rows: const [', 'rows: [')

with open('lib/main.dart', 'w', encoding='utf-8') as f:
  f.write(c)
