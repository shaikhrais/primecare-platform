import os
import json

def merge_dicts(base, overlay):
    """
    Merge overlay into base. If a key is dict in both, recurse.
    If it only exists in overlay, add it to base.
    """
    for key, value in overlay.items():
        if isinstance(value, dict) and key in base and isinstance(base[key], dict):
            merge_dicts(base[key], value)
        elif key not in base:
            base[key] = value

if __name__ == "__main__":
    # Load actual extracted keys
    with open("i18n_actual_keys.json", "r", encoding="utf-8") as f:
        actual_keys = json.load(f)
        
    en_json_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\assets\translations\en.json"
    
    # Load current en.json
    with open(en_json_path, "r", encoding="utf-8") as f:
        en_json = json.load(f)
        
    # Find diffs for reporting what was missing
    def find_missing(en_dict, actual_dict, path=""):
        missing = []
        for k, v in actual_dict.items():
            new_path = f"{path}.{k}" if path else k
            if k not in en_dict:
                missing.append(new_path)
            elif isinstance(v, dict):
                if isinstance(en_dict[k], dict):
                    missing.extend(find_missing(en_dict[k], v, new_path))
        return missing

    missing_keys = find_missing(en_json, actual_keys)
    print("Missing keys from en.json:")
    for k in missing_keys:
        print(" - " + k)
        
    # Merge
    merge_dicts(en_json, actual_keys)
    
    # Write back
    with open(en_json_path, "w", encoding="utf-8") as f:
        json.dump(en_json, f, indent=2)
        
    print("\nSuccessfully updated en.json!")
