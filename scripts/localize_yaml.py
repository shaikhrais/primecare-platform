import yaml
import re

def snake_case(s):
    s = re.sub(r'[^a-zA-Z0-9]', '_', s)
    s = re.sub(r'_+', '_', s)
    return s.lower().strip('_')

def process_yaml():
    file_path = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\page_inventory.yaml'
    with open(file_path, 'r') as f:
        data = yaml.safe_load(f)

    if not data or 'pages' not in data:
        print("Invalid YAML")
        return

    translations = []

    for page in data['pages']:
        if 'label' in page and not page['label'].startswith('navigation.'):
            original_label = page['label']
            key = snake_case(original_label)
            page['label'] = f"navigation.items.{key}"
            translations.append(("item", key, original_label))
        
        if 'section' in page and not page['section'].startswith('navigation.'):
            original_section = page['section']
            key = snake_case(original_section)
            page['label_section'] = f"navigation.sections.{key}" # We should probably just change 'section' but let's see what the generator expects
            # Wait, let's check what the NavigationRegistry uses. 
            # In NavigationRegistry: section: 'navigation.sections.main'
            # So I should change 'section' in YAML if the generator uses it.
            page['section'] = f"navigation.sections.{key}"
            translations.append(("section", key, original_section))

    with open(file_path, 'w') as f:
        yaml.dump(data, f, default_flow_style=False, sort_keys=False)

    print("Updated page_inventory.yaml")
    for t in translations:
        print(f"Added mapping: {t[0]}.{t[1]} -> {t[2]}")

if __name__ == "__main__":
    process_yaml()
