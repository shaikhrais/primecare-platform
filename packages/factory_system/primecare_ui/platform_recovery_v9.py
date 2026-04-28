import os
import re

def merge_core_v9():
    model_path = 'lib/src/features/features_model.dart'
    controller_path = 'lib/src/features/features_controller.dart'
    
    new_models = []
    new_controllers = []
    
    # 1. Models
    models_dir = 'lib/src/shared/src/models'
    if os.path.exists(models_dir):
        for root, dirs, files in os.walk(models_dir):
            for file in files:
                if file.endswith('.dart'):
                    with open(os.path.join(root, file), 'r', encoding='utf-8') as f:
                        new_models.append(f'// From {file}\n' + f.read())
                        
    # 2. Warehouses (Controllers)
    warehouse_dir = 'lib/src/warehouse'
    if os.path.exists(warehouse_dir):
        for root, dirs, files in os.walk(warehouse_dir):
            for file in files:
                if file.endswith('.dart'):
                    with open(os.path.join(root, file), 'r', encoding='utf-8') as f:
                        new_controllers.append(f'// From {file}\n' + f.read())

    # Append
    with open(model_path, 'a', encoding='utf-8') as f:
        f.write('\n\n'.join(new_models))
    with open(controller_path, 'a', encoding='utf-8') as f:
        f.write('\n\n'.join(new_controllers))

def fix_everything_v9():
    for path in ['lib/src/features/features_model.dart', 'lib/src/features/features_controller.dart', 'lib/src/features/features_view.dart']:
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Remove imports of the Big 3 themselves
        content = content.replace("import 'package:primecare_ui/src/features/features_model.dart';", "")
        content = content.replace("import 'package:primecare_ui/src/features/features_controller.dart';", "")
        content = content.replace("import 'package:primecare_ui/src/features/features_view.dart';", "")
        
        # De-duplicate classes
        seen = set()
        lines = content.splitlines()
        result = []
        skip = False
        braces = 0
        for line in lines:
            m = re.search(r'class (\w+)', line)
            if m:
                cls = m.group(1)
                if cls in seen:
                    skip = True
                    braces = line.count('{') - line.count('}')
                    result.append(f"// DUPLICATE: {line}")
                    continue
                else:
                    seen.add(cls)
            
            if skip:
                result.append(f"// {line}")
                braces += line.count('{') - line.count('}')
                if braces <= 0 and '}' in line: skip = False
                continue
            
            result.append(line)
        
        content = '\n'.join(result)
        
        with open(path, 'w', encoding='utf-8') as f:
            f.write(content)

merge_core_v9()
fix_everything_v9()
print("V9 Convergence Complete")
