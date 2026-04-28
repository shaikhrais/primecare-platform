import os

def fix_imports(base_dir, extension, barrel_import):
    for root, _, files in os.walk(base_dir):
        for file in files:
            if file.endswith(extension):
                filepath = os.path.join(root, file)
                with open(filepath, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                if barrel_import not in content:
                    with open(filepath, 'w', encoding='utf-8') as f:
                        f.write(f"import '{barrel_import}';\n" + content)
                        
fix_imports(r'lib\src\features', '_model.dart', 'package:primecare_ui/src/features/features_model.dart')
fix_imports(r'lib\src\features', '_controller.dart', 'package:primecare_ui/src/features/features_controller.dart')
fix_imports(r'lib\src\features', '_view.dart', 'package:primecare_ui/src/features/features_view.dart')
fix_imports(r'lib\src\features', '_view.dart', 'package:primecare_ui/src/features/features_controller.dart')
fix_imports(r'lib\src\features', '_view.dart', 'package:primecare_ui/src/features/features_model.dart')

print("Added barrel imports to all files.")
