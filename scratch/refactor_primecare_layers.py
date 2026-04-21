import os
import re

ROOT_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
ADAPTERS_LIB = os.path.join(ROOT_DIR, "packages/primecare_adapters/lib")
ADAPTERS_SRC = os.path.join(ADAPTERS_LIB, "src")
BARREL_FILE = os.path.join(ADAPTERS_LIB, "primecare_adapters.dart")

# Define the architectural mapping
CATEGORIES = {
    "infrastructure": ("01", "I", "INFRASTRUCTURE"),
    "models/core": ("02", "M", "MODELS_FOUNDATION"),
    "models/roles": ("03", "V", "VIEW_MODELS"),
    "adapters": ("04", "A", "UI_ADAPTERS"),
    "registry": ("05", "G", "REGISTRY_GOVERNANCE"),
    "utils": ("05", "G", "REGISTRY_GOVERNANCE"),
}

# Special cases for models in the root of 'models'
SPECIAL_MODELS = ["view_model.dart", "dashboard_view_model.dart"]

def get_layer_info(rel_path):
    rel_path = rel_path.replace('\\', '/')
    
    if "infrastructure" in rel_path:
        return CATEGORIES["infrastructure"]
    if "models/roles" in rel_path:
        return CATEGORIES["models/roles"]
    if any(m in rel_path for m in SPECIAL_MODELS) or "models/core" in rel_path:
        return CATEGORIES["models/core"]
    if "adapters" in rel_path or "generic" in rel_path:
        return CATEGORIES["adapters"]
    if "registry" in rel_path or "utils" in rel_path:
        return CATEGORIES["registry"]
    
    return ("00", "U", "UNKNOWN")

def update_header(file_path, layer_num, layer_name):
    with open(file_path, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    
    new_header = f"// Layer: {layer_num}_{layer_name}\n"
    
    if lines and lines[0].startswith("// Layer:"):
        lines[0] = new_header
    else:
        lines.insert(0, new_header)
        
    with open(file_path, 'w', encoding='utf-8') as f:
        f.writelines(lines)

def main():
    rename_map = {} # old_relative_path -> new_filename
    
    print("Step 1: Mapping and Updating Headers...")
    for root, dirs, files in os.walk(ADAPTERS_SRC):
        for file in files:
            if file.endswith('.dart'):
                full_path = os.path.join(root, file)
                rel_path = os.path.relpath(full_path, ADAPTERS_LIB).replace('\\', '/')
                
                num, letter, name = get_layer_info(rel_path)
                new_file_name = f"{num}_{letter}_{file}"
                
                # Update header in place
                update_header(full_path, num, name)
                
                rename_map[rel_path] = new_file_name
                
    print(f"Mapped {len(rename_map)} files.")

    print("Step 2: Performing Physical Renames...")
    # Sort by length descending to avoid renaming parent dirs before children (not renaming dirs here, but good practice)
    for old_rel, new_name in rename_map.items():
        old_full = os.path.join(ADAPTERS_LIB, old_rel)
        new_full = os.path.join(os.path.dirname(old_full), new_name)
        if os.path.exists(old_full):
            os.rename(old_full, new_full)
            # Update the map to show the full NEW relative path
            new_rel = os.path.join(os.path.dirname(old_rel), new_name).replace('\\', '/')
            # Note: The mapping for replacement needs to be 'old_path_string' -> 'new_path_string'
    
    print("Step 3: Global Import Refactoring...")
    # We need a replacement map for the actual import strings
    import_substitutions = {}
    for old_rel, new_name in rename_map.items():
        old_base = os.path.basename(old_rel)
        # 1. Full package import replacement: package:primecare_adapters/src/models/view_model.dart
        import_substitutions[old_rel] = os.path.join(os.path.dirname(old_rel), new_name).replace('\\', '/')
        # 2. Base name replacement (for relative imports): import 'view_model.dart'
        # This is trickier as it might catch wrong files, but since we are prefixing everything with 01_I_ etc, 
        # it's usually safe if we match 'view_model.dart' specifically.
        import_substitutions[old_base] = new_name

    # Walk the entire repository
    for root, dirs, files in os.walk(ROOT_DIR):
        if "node_modules" in root or ".git" in root or "build" in root or ".dart_tool" in root:
            continue
            
        for file in files:
            if file.endswith('.dart'):
                file_path = os.path.join(root, file)
                changed = False
                with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                    content = f.read()
                
                new_content = content
                
                # Execute replacements
                # Strategy: Match literal strings in quotes
                # import '...old_path...'
                for old, new in import_substitutions.items():
                    # We match 'old' if it's preceded by / or ' or " and followed by ' or "
                    # Case 1: package path
                    if f"/{old}" in new_content:
                        new_content = new_content.replace(f"/{old}", f"/{new}")
                        changed = True
                    # Case 2: relative path
                    if f"'{old}'" in new_content:
                        new_content = new_content.replace(f"'{old}'", f"'{new}'")
                        changed = True
                    if f'"{old}"' in new_content:
                        new_content = new_content.replace(f'"{old}"', f'"{new}"')
                        changed = True

                if changed:
                    with open(file_path, 'w', encoding='utf-8') as f:
                        f.write(new_content)
                    print(f"Updated imports in: {os.path.relpath(file_path, ROOT_DIR)}")

    print("Refactoring Complete!")

if __name__ == "__main__":
    main()
