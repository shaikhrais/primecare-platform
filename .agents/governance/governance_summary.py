import yaml
import os

REGISTRY_PATH = '.agents/governance/page_inventory.yaml'

def generate_summary():
    if not os.path.exists(REGISTRY_PATH):
        print(f"Error: Registry not found at {REGISTRY_PATH}")
        return

    with open(REGISTRY_PATH, 'r', encoding='utf-8') as f:
        data = yaml.safe_load(f)

    pages = data.get('pages', [])
    total_screens = len(pages)
    
    role_coverage = {}
    for page in pages:
        roles = page.get('role_allowed', [])
        for role in roles:
            role_coverage[role] = role_coverage.get(role, 0) + 1

    print("PrimeCare Platform Governance Summary")
    print("==========================================")
    print(f"Total Registered Screens: {total_screens}")
    print("\nRole-Based Access Coverage:")
    for role, count in sorted(role_coverage.items(), key=lambda x: x[1], reverse=True):
        print(f"  - {role:25}: {count} screens")
    
    # Check for localization labels
    # Note: Labels might be separate objects in the 'pages' list or a different structure
    # Based on previous check, some items have id: *_labels
    labels_blocks = [p for p in pages if p.get('id', '').endswith('_labels')]
    print(f"\nLocalized Component Blocks: {len(labels_blocks)}")
    for block in labels_blocks:
        label_count = len(block.get('labels', {}))
        print(f"  - {block['id']:25}: {label_count} keys")

    print("\n==========================================")
    print("All screens listed above are governed by the Registry-First architecture.")

if __name__ == "__main__":
    generate_summary()
