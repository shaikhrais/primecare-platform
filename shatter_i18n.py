import json
import os
import shutil

EN_JSON_PATH = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\assets\translations\en.json"
SRC_DIR = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\assets\translations_src\en"

def flatten_dict_and_write(base_path, key_path, current_dict):
    """
    Recursively breaks down the dict.
    If the dict contains ONLY string values (or no further nested dicts that make sense as files),
    we write it as a .json file.
    Otherwise, we create a directory and continue.
    """
    # Check if there are any nested dicts
    has_nested_dicts = any(isinstance(v, dict) for v in current_dict.values())
    
    if not has_nested_dicts:
        # It's a leaf node containing only strings. Write it out as a json file.
        file_path = f"{base_path}.json"
        
        # Ensure parent directory exists
        os.makedirs(os.path.dirname(file_path), exist_ok=True)
        
        with open(file_path, 'w', encoding='utf-8') as f:
            json.dump(current_dict, f, indent=2)
        return

    # If it has nested dicts, we probably want to make it a folder and go deeper
    for key, value in current_dict.items():
        new_base_path = os.path.join(base_path, key)
        if isinstance(value, dict):
            # Create a folder for the current level (implicit in file path generation later)
            flatten_dict_and_write(new_base_path, key_path + [key], value)
        else:
            # It's a mix of a string and dicts at this level! 
            # We must write the string into a specific file alongside the folders, e.g., "_common.json"
            common_file = os.path.join(base_path, "_common.json")
            os.makedirs(os.path.dirname(common_file), exist_ok=True)
            
            # Read existing if exists
            common_data = {}
            if os.path.exists(common_file):
                with open(common_file, 'r', encoding='utf-8') as f:
                    common_data = json.load(f)
                    
            common_data[key] = value
            with open(common_file, 'w', encoding='utf-8') as f:
                json.dump(common_data, f, indent=2)


def main():
    if os.path.exists(SRC_DIR):
        shutil.rmtree(SRC_DIR)
        
    os.makedirs(SRC_DIR, exist_ok=True)

    with open(EN_JSON_PATH, 'r', encoding='utf-8') as f:
        data = json.load(f)

    for key, value in data.items():
        if isinstance(value, dict):
            flatten_dict_and_write(os.path.join(SRC_DIR, key), [key], value)
        else:
            # Top-level strings
            common_file = os.path.join(SRC_DIR, "_common.json")
            common_data = {}
            if os.path.exists(common_file):
                with open(common_file, 'r', encoding='utf-8') as f:
                    common_data = json.load(f)
            common_data[key] = value
            with open(common_file, 'w', encoding='utf-8') as f:
                json.dump(common_data, f, indent=2)

    print(f"Shattered {EN_JSON_PATH} into {SRC_DIR}")

if __name__ == "__main__":
    main()
