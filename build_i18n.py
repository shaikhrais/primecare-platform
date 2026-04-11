import os
import json

SRC_BASE = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\assets\translations_src"
DEST_BASE = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\assets\translations"

def set_nested(d, keys, value):
    for key in keys[:-1]:
        d = d.setdefault(key, {})
    
    # If the destination is already a dict (e.g. from a _common.json), and the value is a dict, we merge.
    if isinstance(d.get(keys[-1]), dict) and isinstance(value, dict):
        d[keys[-1]].update(value)
    else:
        d[keys[-1]] = value

def merge_i18n_for_locale(locale):
    src_dir = os.path.join(SRC_BASE, locale)
    if not os.path.exists(src_dir):
        return
        
    master_dict = {}
    
    for root, dirs, files in os.walk(src_dir):
        for file in files:
            if not file.endswith('.json'):
                continue
                
            file_path = os.path.join(root, file)
            rel_path = os.path.relpath(file_path, src_dir)
            
            with open(file_path, 'r', encoding='utf-8') as f:
                data = json.load(f)
                
            # Path parts
            parts = rel_path.split(os.sep)
            # Remove .json from the last part
            parts[-1] = parts[-1].replace('.json', '')
            
            # If the file is "_common", we merge its contents directly into the parent's level
            if parts[-1] == "_common":
                # The parent level is parts[:-1]
                parent_keys = parts[:-1]
                if not parent_keys:
                    # Top-level common file
                    for k, v in data.items():
                        master_dict[k] = v
                else:
                    # We need to set each key in data under the parent_keys
                    for k, v in data.items():
                        set_nested(master_dict, parent_keys + [k], v)
            else:
                set_nested(master_dict, parts, data)
                
    dest_path = os.path.join(DEST_BASE, f"{locale}.json")
    os.makedirs(os.path.dirname(dest_path), exist_ok=True)
    
    with open(dest_path, 'w', encoding='utf-8') as f:
        json.dump(master_dict, f, indent=2)
        
    print(f"Compiled {dest_path}")

def main():
    if not os.path.exists(SRC_BASE):
        print(f"Source directory not found: {SRC_BASE}")
        return
        
    for locale in os.listdir(SRC_BASE):
        if os.path.isdir(os.path.join(SRC_BASE, locale)):
            merge_i18n_for_locale(locale)

if __name__ == "__main__":
    main()
