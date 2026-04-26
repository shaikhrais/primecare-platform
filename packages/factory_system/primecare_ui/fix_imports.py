import os

def add_import(filepath, import_statement):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    if import_statement not in content:
        # insert after the first import or at the top
        lines = content.split('\n')
        for i, line in enumerate(lines):
            if line.startswith('import '):
                lines.insert(i, import_statement)
                break
        else:
            lines.insert(0, import_statement)
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write('\n'.join(lines))

def main():
    # Fix clinical_warehouse.dart
    cw_path = r'lib\src\warehouse\offices\clinical_warehouse.dart'
    if os.path.exists(cw_path):
        with open(cw_path, 'r', encoding='utf-8') as f:
            content = f.read()
        content = content.replace('const IntakeDashboardScreen()', 'IntakeDashboardScreen()')
        with open(cw_path, 'w', encoding='utf-8') as f:
            f.write(content)

    # Fix auditor_hud_overlay.dart
    ah_path = r'lib\src\features\auditor_hud\presentation\widgets\05_U_auditor_hud_overlay.dart'
    if os.path.exists(ah_path):
        add_import(ah_path, "import 'package:easy_localization/easy_localization.dart';")

    # Fix HR forms missing LocaleKeys
    hr_dir = r'lib\src\components\forms\hr'
    if os.path.exists(hr_dir):
        for f in os.listdir(hr_dir):
            if f.endswith('.dart'):
                add_import(os.path.join(hr_dir, f), "import 'package:primecare_ui/primecare_ui.dart';")
                add_import(os.path.join(hr_dir, f), "import 'package:primecare_adapters/primecare_adapters.dart';")

if __name__ == '__main__':
    main()
