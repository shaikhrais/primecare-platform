import os

def fix_imports():
    dirs_to_check = [r'lib\src\components', r'lib\src\features']
    for d in dirs_to_check:
        for root, dirs, files in os.walk(d):
            for file in files:
                if file.endswith('.dart'):
                    fpath = os.path.join(root, file)
                    with open(fpath, 'r', encoding='utf-8') as f:
                        content = f.read()
                    
                    changed = False
                    
                    # If LocaleKeys is used but primecare_ui or primecare_adapters is not imported
                    if 'LocaleKeys' in content and 'primecare_ui.dart' not in content and 'primecare_adapters.dart' not in content:
                        content = "import 'package:primecare_ui/primecare_ui.dart';\n" + content
                        changed = True
                    
                    # If .tr() is used but easy_localization or primecare_ui or primecare_adapters is not imported
                    if '.tr()' in content and 'primecare_ui.dart' not in content and 'primecare_adapters.dart' not in content and 'easy_localization.dart' not in content:
                        content = "import 'package:primecare_ui/primecare_ui.dart';\n" + content
                        changed = True
                        
                    if changed:
                        with open(fpath, 'w', encoding='utf-8') as f:
                            f.write(content)
                        print(f'Fixed missing imports in {fpath}')

if __name__ == '__main__':
    fix_imports()
