import os
import re
import json

def extract_tr_keys(dir_path):
    keys = set()
    pattern = re.compile(r"'([^']+)'\.tr\(\)")
    
    for root, _, files in os.walk(dir_path):
        for file in files:
            if file.endswith('.dart'):
                file_path = os.path.join(root, file)
                with open(file_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                    matches = pattern.findall(content)
                    for match in matches:
                        keys.add(match)
    return sorted(list(keys))

def build_nested_dict(keys):
    root = {}
    for key in keys:
        parts = key.split('.')
        current = root
        for i, part in enumerate(parts):
            if i == len(parts) - 1:
                current[part] = f"TBD: {key}"
            else:
                if part not in current:
                    current[part] = {}
                current = current[part]
    return root

if __name__ == "__main__":
    ui_dir = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_ui\lib\src\screens"
    keys = extract_tr_keys(ui_dir)
    print("Found keys:")
    for key in keys:
        print(key)
    
    nested = build_nested_dict(keys)
    with open("i18n_actual_keys.json", "w", encoding="utf-8") as f:
        json.dump(nested, f, indent=2)
    print("\nWrote to i18n_actual_keys.json")
