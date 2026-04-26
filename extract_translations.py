import os
import re
import json

def extract_keys(directory):
    keys = set()
    # Matches 'key'.tr(), "key".tr(), 'common.key'.tr(), etc.
    # Handles optional spaces around the dot and parenthesis
    pattern = re.compile(r"(['\"])([\w\.-]+)\1\s*\.\s*tr\s*\(")
    
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(".dart"):
                path = os.path.join(root, file)
                try:
                    with open(path, 'r', encoding='utf-8') as f:
                        content = f.read()
                        matches = pattern.findall(content)
                        for match in matches:
                            keys.add(match[1])
                except Exception as e:
                    print(f"Error reading {path}: {e}")
    return keys

def merge_nested(base, update):
    for k, v in update.items():
        if k in base and isinstance(base[k], dict) and isinstance(v, dict):
            merge_nested(base[k], v)
        else:
            base[k] = v

def set_nested_item(data, key, value):
    parts = key.split('.')
    curr = data
    for part in parts[:-1]:
        curr = curr.setdefault(part, {})
    if parts[-1] not in curr:
        curr[parts[-1]] = value

def process_translations():
    search_dirs = [
        r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib",
        r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\lib",
        r"C:\Users\Admin2\Documents\GitHub\primecare-platform\apps"
    ]

    all_keys = set()
    for d in search_dirs:
        if os.path.exists(d):
            print(f"Scanning {d}...")
            all_keys.update(extract_keys(d))
    
    print(f"Found {len(all_keys)} unique keys.")

    locales = ['en', 'fr', 'es']
    base_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\lib\src\localization"
    
    for locale in locales:
        file_path = os.path.join(base_path, f"{locale}.json")
        existing_data = {}
        if os.path.exists(file_path):
            with open(file_path, 'r', encoding='utf-8') as f:
                try:
                    existing_data = json.load(f)
                except:
                    pass
        
        # Ensure we have common.languages keys as requested
        set_nested_item(existing_data, "common.languages.en", "English")
        set_nested_item(existing_data, "common.languages.fr", "Français")
        set_nested_item(existing_data, "common.languages.es", "Español")

        for key in all_keys:
            # We want to keep existing values, only add missing ones
            # For now, if missing, use the key as value
            set_nested_item(existing_data, key, key)

        # Special handling for Security_notic_long if it's missing or needs updating
        # User said "Security_notic_long text is not changed"
        # I'll check if it's in en.json already.

        with open(file_path, 'w', encoding='utf-8') as f:
            json.dump(existing_data, f, indent=2, ensure_ascii=False)
        print(f"Updated {file_path}")

if __name__ == "__main__":
    process_translations()
