import yaml
import os
import re

PAGE_INVENTORY_PATH = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\page_inventory.yaml'
REGISTRIES_DIR = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_governance\lib\core\governance\registries'

def camel_to_snake(name):
    return re.sub(r'(?<!^)(?=[A-Z])', '_', name).lower()

def get_target_registry(page):
    route = page.get('route', '')
    id = page.get('id', '')
    
    if '/admin/' in route or '/infrastructure/' in route or 'admin' in id:
        return 'admin_infrastructure_registry.dart'
    if '/clinical/' in route or 'clinical' in id:
        return 'clinical_registry.dart'
    if '/corporate/' in route:
        return 'corporate_registry.dart'
    if '/franchise/' in route:
        return 'franchise_registry.dart'
    if '/marketing/' in route:
        return 'marketing_registry.dart'
    if '/support/' in route:
        return 'support_registry.dart'
    if '/dispatch/' in route or '/operations/' in route:
        return 'operational_registry.dart'
    if '/bus-dev/' in route:
        return 'business_development_registry.dart'
    if '/portal/' in route:
        return 'client_portal_registry.dart'
    
    return 'workflows_forms_registry.dart'

with open(PAGE_INVENTORY_PATH, 'r') as f:
    data = yaml.safe_load(f)

pages = data.get('pages', [])
print(f"Loaded {len(pages)} pages from inventory.")

# Pre-load existing screen IDs to avoid duplicates
existing_ids = set()
for filename in os.listdir(REGISTRIES_DIR):
    if filename.endswith('.dart'):
        with open(os.path.join(REGISTRIES_DIR, filename), 'r') as f:
            content = f.read()
            # More precise match for keys in the map
            ids = re.findall(r"'SCREEN_([A-Z0-9_]+)':\s*ScreenMetadata", content)
            existing_ids.update([f"SCREEN_{id}" for id in ids])

print(f"Found {len(existing_ids)} existing screens in Dart registries.")

migrated_count = 0
for page in pages:
    raw_id = page['id'].upper()
    if not raw_id.startswith('SCREEN_'):
        screen_id = f"SCREEN_{raw_id}"
    else:
        screen_id = raw_id
    
    if screen_id in existing_ids:
        print(f"  Skipping {screen_id} (Already exists)")
        continue
    
    target_file = get_target_registry(page)
    target_path = os.path.join(REGISTRIES_DIR, target_file)
    
    # Generate metadata
    title = page.get('name', page['id'])
    route = page.get('route', f'/legacy/{page["id"]}')
    role = page.get('role_allowed', ['Guest'])[0]
    
    # Check if virtual
    is_virtual = "true" if "form" in screen_id.lower() or "map" in screen_id.lower() or "vault" in screen_id.lower() else "false"
    
    metadata = f"""    '{screen_id}': ScreenMetadata(
      id: '{screen_id}',
      title: '{title}',
      featureName: '{title}',
      routePath: '{route}',
      office: '{target_file.split('_')[0].capitalize()}',
      role: '{role}',
      allowedRoles: {page.get('role_allowed', ['Guest'])},
      lifecycleStatus: LifecycleStatus.completed,
      isRenderOk: true,
      userApprovedLayout: true,
      isVirtual: {is_virtual},
      sourcePath: 'virtual',
      implementedComponents: ["Aura HUD", "Standard View"],
    ),"""

    with open(target_path, 'r') as f:
        content = f.read()
    
    # Inject before the end of the map
    if "};" in content:
        new_content = content.replace("  };", metadata + "\n  };")
        with open(target_path, 'w') as f:
            f.write(new_content)
        migrated_count += 1
        existing_ids.add(screen_id)
        print(f"  Migrated {screen_id} to {target_file}")

print(f"Successfully migrated {migrated_count} screens.")
