import os
import re
import yaml

registry_dir = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_governance\lib\core\governance\registries'
yaml_path = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\page_inventory.yaml'

# 1. Get ALL Registry IDs
registry_ids = set()
for filename in os.listdir(registry_dir):
    if filename.endswith('.dart'):
        with open(os.path.join(registry_dir, filename), 'r', encoding='utf-8') as f:
            content = f.read()
            matches = re.findall(r"'SCREEN_([A-Z0-9_]+)':", content)
            for m in matches:
                registry_ids.add(f"SCREEN_{m}")

# 2. Check YAML IDs
with open(yaml_path, 'r') as f:
    data = yaml.safe_load(f)
    pages = data.get('pages', [])

missing = []
for p in pages:
    id_ = p['id']
    # Normalize ID for comparison
    # YAML ID can be "system_dashboard" or "SCREEN___..."
    norm = id_.upper()
    if not norm.startswith("SCREEN_"):
        norm = f"SCREEN_{norm}"
    
    # Handle the migration normalization
    norm = norm.replace('SCREEN___', 'SCREEN_').replace('WORKFLOWS_AND_FORMS_', 'WF_').replace('__', '_')
    
    if norm not in registry_ids and norm.rstrip('_') not in registry_ids:
        missing.append(p)

print(f"Unique Registry IDs: {len(registry_ids)}")
print(f"Missing from Registry: {len(missing)}")
for m in missing:
    print(f"  - {m['id']}")
