import os
import re
import yaml

yaml_path = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\page_inventory.yaml'
registry_dir = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_governance\lib\core\governance\registries'

all_ids = set()

# 1. Get IDs from YAML
if os.path.exists(yaml_path):
    with open(yaml_path, 'r') as f:
        data = yaml.safe_load(f)
        for item in data.get('pages', []):
            all_ids.add(item['id'])

# 2. Get IDs from Dart Registries
for filename in os.listdir(registry_dir):
    if filename.endswith('.dart'):
        with open(os.path.join(registry_dir, filename), 'r', encoding='utf-8') as f:
            content = f.read()
            matches = re.findall(r"'SCREEN_([A-Z0-9_]+)':", content)
            for m in matches:
                all_ids.add(f"SCREEN_{m}")

print(f"Total Unique Screen IDs: {len(all_ids)}")
# print(sorted(list(all_ids)))
