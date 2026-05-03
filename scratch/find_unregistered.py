import os
import re

registry_dir = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_governance\lib\core\governance\registries'
ui_package_path = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\features'

registered_paths = set()
for filename in os.listdir(registry_dir):
    if filename.endswith('.dart'):
        with open(os.path.join(registry_dir, filename), 'r', encoding='utf-8') as f:
            content = f.read()
            matches = re.findall(r"sourcePath:\s*'([^']+)'", content)
            for m in matches:
                registered_paths.add(m)

unregistered = []
for root, dirs, files in os.walk(ui_package_path):
    for file in files:
        if file.endswith('_screen.dart'):
            if file not in registered_paths:
                unregistered.append(os.path.join(root, file))

print(f"Total Registered Paths: {len(registered_paths)}")
print(f"Unregistered Screen Files: {len(unregistered)}")
for u in unregistered:
    print(f"  - {os.path.basename(u)}")
