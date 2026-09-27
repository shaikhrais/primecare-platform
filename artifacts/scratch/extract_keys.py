
import re
import os

def generate_translations():
    inventory_path = '.agents/governance/page_inventory.yaml'
    with open(inventory_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    en_items = {}
    en_sections = {}
    
    # Split by blocks starting with - id:
    blocks = re.split(r'\n\s*-\s+id:', content)[1:]
    
    for block in blocks:
        id_match = re.search(r'^ "([^"]+)"', block)
        if not id_match:
             id_match = re.search(r'^ ([^\s\n]+)', block)
             
        label_match = re.search(r'label:\s*"([^"]+)"', block)
        section_match = re.search(r'section:\s*"([^"]+)"', block)
        
        if id_match and label_match:
            pid = id_match.group(1).strip('"')
            label = label_match.group(1)
            en_items[pid] = label
            
            section = section_match.group(1) if section_match else "Main"
            section_key = section.lower().replace(' ', '_')
            en_sections[section_key] = section

    # Also check the registry for any keys not in the inventory
    registry_path = 'packages/flutter_core/lib/config/01_I_navigation_registry.dart'
    if os.path.exists(registry_path):
        with open(registry_path, 'r', encoding='utf-8') as f:
            reg_content = f.read()
        registry_keys = re.findall(r"'(navigation\.(items|sections)\.([^']+))'", reg_content)
        for full_key, ktype, kid in registry_keys:
            if ktype == 'items' and kid not in en_items:
                en_items[kid] = kid.replace('_', ' ').title()
            elif ktype == 'sections' and kid not in en_sections:
                en_sections[kid] = kid.replace('_', ' ').title()

    if 'master_directory' not in en_sections:
        en_sections['master_directory'] = 'Master Directory'

    return en_items, en_sections

if __name__ == "__main__":
    items, sections = generate_translations()
    
    print("EN ITEMS:")
    for k, v in items.items():
        print(f'"{k}": "{v}",')
    
    print("\nEN SECTIONS:")
    for k, v in sections.items():
        print(f'"{k}": "{v}",')
