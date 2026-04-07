import os
import glob

def ensure_imports(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    changed = False

    if 'PageTemplate' in content and 'page_template.dart' not in content:
        content = "import 'package:primecare_v4/shared/widgets/page_template.dart';\n" + content
        changed = True

    if 'PrimeCareTheme' in content and 'primecare_theme.dart' not in content:
        content = "import 'package:primecare_v4/shared/theme/primecare_theme.dart';\n" + content
        changed = True

    if changed:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Added imports to {filepath}")

for root, dirs, files in os.walk('lib/offices'):
    for file in files:
        if file.endswith('.dart'):
            ensure_imports(os.path.join(root, file))
