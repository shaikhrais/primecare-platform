import os
import re
import yaml

yaml_path = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\page_inventory.yaml'
registry_dir = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_governance\lib\core\governance\registries'

registry_ids = set()
for filename in os.listdir(registry_dir):
    if filename.endswith('.dart'):
        with open(os.path.join(registry_dir, filename), 'r', encoding='utf-8') as f:
            content = f.read()
            matches = re.findall(r"'SCREEN_([A-Z0-9_]+)':", content)
            for m in matches:
                registry_ids.add(f"SCREEN_{m}")

print(f"Total in Registry: {len(registry_ids)}")

missing = []
with open(yaml_path, 'r') as f:
    data = yaml.safe_load(f)
    for item in data.get('pages', []):
        id_ = item['id']
        norm = id_.replace('SCREEN___', 'SCREEN_').replace('WORKFLOWS_AND_FORMS_', 'WF_').replace('__', '_')
        
        # Strip trailing underscores for comparison if inconsistent
        if norm not in registry_ids and norm.rstrip('_') not in registry_ids:
            missing.append(id_)

print(f"Missing from Registry: {len(missing)}")
if missing:
    print("Example missing IDs:")
    for m in missing[:5]:
        print(f"  - {m}")
    print(f"Example registry IDs:")
    for r in sorted(list(registry_ids))[:5]:
        print(f"  - {r}")
