import os

files = [
    r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\features\features_model.dart',
    r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\features\features_controller.dart',
    r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\features\features_view.dart'
]

for file_path in files:
    if os.path.exists(file_path):
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Replace whole word AdministrativeFormsObject with Object
        new_content = content.replace('AdministrativeFormsObject', 'Object')
        
        if new_content != content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f"Reverted {file_path}")
        else:
            print(f"No changes for {file_path}")
