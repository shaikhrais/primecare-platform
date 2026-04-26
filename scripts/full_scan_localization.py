import os
import re
import json

# Configuration
BASE_DIR = r'c:\Users\Admin2\Documents\GitHub\primecare-platform'
FEATURES_DIR = os.path.join(BASE_DIR, 'packages', 'factory_system', 'primecare_ui', 'lib', 'src', 'features')
YAML_PATH = os.path.join(BASE_DIR, '.agents', 'governance', 'page_inventory.yaml')
GEN_TRANS_PATH = os.path.join(BASE_DIR, 'apps', 'primecare_corporate', 'assets', 'translations', 'gen_translations.py')

def snake_case(s):
    s = re.sub(r'[^a-zA-Z0-9]', '_', s)
    s = re.sub(r'_+', '_', s)
    return s.lower().strip('_')

collected_mappings = {
    "nav_items": {},
    "nav_sections": {},
    "dashboards": {}
}

def scan_yaml():
    if not os.path.exists(YAML_PATH): return
    with open(YAML_PATH, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Simple regex for YAML since I don't want to rely on PyYAML
    labels = re.findall(r'label:\s*"([^"]+)"', content)
    for label in labels:
        if not label.startswith('navigation.'):
            key = snake_case(label)
            collected_mappings["nav_items"][key] = label
            content = content.replace(f'label: "{label}"', f'label: "navigation.items.{key}"')
            
    sections = re.findall(r'section:\s*"([^"]+)"', content)
    for section in sections:
        if not section.startswith('navigation.'):
            key = snake_case(section)
            collected_mappings["nav_sections"][key] = section
            content = content.replace(f'section: "{section}"', f'section: "navigation.sections.{key}"')
            
    with open(YAML_PATH, 'w', encoding='utf-8') as f:
        f.write(content)
    print("Updated page_inventory.yaml")

def scan_intents():
    for root, dirs, files in os.walk(FEATURES_DIR):
        for file in files:
            if file.endswith('intent.dart'):
                path = os.path.join(root, file)
                with open(path, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                # Get dashboard name from class or filename
                dash_match = re.search(r'class\s+(\w+)DashboardIntent', content)
                if dash_match:
                    dash_key = snake_case(dash_match.group(1))
                    
                    # title: '...'
                    title_match = re.search(r"get title => '([^']+)';", content)
                    if title_match:
                        title = title_match.group(1)
                        if not title.startswith('dashboards.'):
                            collected_mappings["dashboards"][dash_key] = {"title": title, "labels": []}
                            content = content.replace(f"get title => '{title}';", f"get title => 'dashboards.{dash_key}.title';")
                    
                    # componentLabels: [...]
                    labels_block = re.search(r"get componentLabels => \[([\s\S]*?)\];", content)
                    if labels_block:
                        labels = re.findall(r"'([^']+)'", labels_block.group(1))
                        new_labels = []
                        for i, label in enumerate(labels):
                            label_key = snake_case(label)
                            if dash_key not in collected_mappings["dashboards"]:
                                collected_mappings["dashboards"][dash_key] = {"title": dash_key.replace('_', ' ').title(), "labels": []}
                            
                            collected_mappings["dashboards"][dash_key]["labels"].append((label_key, label))
                            content = content.replace(f"'{label}'", f"'dashboards.{dash_key}.labels.{label_key}'")
                
                with open(path, 'w', encoding='utf-8') as f:
                    f.write(content)
                print(f"Updated {file}")

def update_gen_translations():
    # This is a bit complex, but I'll try to inject the new mappings into the existing gen_translations.py
    # For now, I'll just print them so I can manually update or append.
    print("\n--- NEW NAV ITEMS ---")
    for k, v in collected_mappings["nav_items"].items():
        print(f'        ("{k}", "{v}"),')
        
    print("\n--- NEW SECTIONS ---")
    for k, v in collected_mappings["nav_sections"].items():
        print(f'        "{v}": "{k}",')
        
    print("\n--- NEW DASHBOARD STRINGS ---")
    # I'll create a format that can be easily added to en_data["dashboards"]
    for d_key, data in collected_mappings["dashboards"].items():
        print(f'"{d_key}": {{ "title": "{data["title"]}", "subtitle": "Access metrics.", "labels": {{ ' + ", ".join([f'"{k}": "{v}"' for k, v in data["labels"]]) + ' } } },')

if __name__ == "__main__":
    scan_yaml()
    scan_intents()
    update_gen_translations()
