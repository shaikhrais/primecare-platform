import os

def fix_imports():
    forms_dir = r'lib\src\components\forms'
    for root, dirs, files in os.walk(forms_dir):
        for file in files:
            if file.endswith('.dart'):
                fpath = os.path.join(root, file)
                with open(fpath, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                # If LocaleKeys is used but primecare_ui or primecare_adapters is not imported
                if 'LocaleKeys' in content and 'primecare_ui.dart' not in content and 'primecare_adapters.dart' not in content:
                    content = "import 'package:primecare_ui/primecare_ui.dart';\n" + content
                    with open(fpath, 'w', encoding='utf-8') as f:
                        f.write(content)
                    print(f'Fixed {fpath}')

if __name__ == '__main__':
    fix_imports()
