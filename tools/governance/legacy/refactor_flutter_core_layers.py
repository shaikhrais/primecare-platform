import os
import re
import time

ROOT_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
CORE_LIB = os.path.join(ROOT_DIR, "packages/flutter_core/lib")
PACKAGE_NAME = "primecare_core" # As per pubspec.yaml

# Layer Definitions
LAYERS = {
    "00": ("B", "ENTRY_POINT"),
    "01": ("I", "INFRASTRUCTURE"),
    "02": ("M", "MODELS_FOUNDATION"),
    "03": ("D", "DATA_DOMAIN_LOGIC"),
    "04": ("V", "VIEW_MODELS"),
    "05": ("U", "UI_PRESENTATION"),
}

def get_layer_info(rel_path):
    """
    Assigns a layer based on the file's relative path within lib/
    """
    rel_path = rel_path.replace('\\', '/')
    
    # Layer 00: Entry / Barrel
    if rel_path == "main.dart" or rel_path == "app.dart" or rel_path == "flutter_core.dart":
        return "00"
        
    # Layer 01: Infrastructure
    if "routes/" in rel_path or "resilience/" in rel_path or "services/" in rel_path or "utils/" in rel_path:
        return "01"
        
    # Layer 02: Models
    if "domain/models/" in rel_path or "src/models/" in rel_path or "dtos/" in rel_path:
        return "02"
        
    # Layer 03: Data / Logical Binding
    if "repositories/" in rel_path or "mappers/" in rel_path or "providers/" in rel_path:
        return "03"
        
    # Layer 04: ViewModels
    if "view_models/" in rel_path or "notifiers/" in rel_path:
        return "04"
        
    # Layer 05: UI
    if "widgets/" in rel_path or "screens/" in rel_path or "presentation/" in rel_path:
        return "05"
        
    # Default to UI if unknown presentation element, otherwise Infrastructure
    if "presentation/" in rel_path:
        return "05"
    return "01"

def update_header(file_path, layer_id):
    num = layer_id
    letter, name = LAYERS[layer_id]
    
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            lines = f.readlines()
        
        new_header = f"// Layer: {num}_{name}\n"
        
        if lines and lines[0].startswith("// Layer:"):
            lines[0] = new_header
        else:
            lines.insert(0, new_header)
            
        with open(file_path, 'w', encoding='utf-8') as f:
            f.writelines(lines)
    except Exception as e:
        print(f"Error updating header for {file_path}: {e}")

def main():
    start_time = time.time()
    
    # 1. Map all files and update headers
    print("--- Step 1: Mapping Files and Injecting Headers ---")
    rename_map = {} # old_rel_path -> new_filename
    path_sync_map = {} # old_import_path -> new_import_path
    
    for root, dirs, files in os.walk(CORE_LIB):
        # Skip generated files
        for file in files:
            if not file.endswith('.dart'):
                continue
            if file.endswith('.g.dart') or file.endswith('.freezed.dart'):
                continue
            if "primecare_core.dart" in file: # Barrel file usually stays or gets 00
                continue

            full_path = os.path.join(root, file)
            rel_path = os.path.relpath(full_path, CORE_LIB).replace('\\', '/')
            
            layer_id = get_layer_info(rel_path)
            letter, _ = LAYERS[layer_id]
            
            # Already prefixed?
            if re.match(r"^\d{2}_[A-Z]_", file):
                continue
                
            new_name = f"{layer_id}_{letter}_{file}"
            rename_map[rel_path] = new_name
            
            # Update header
            update_header(full_path, layer_id)
            
            # Prepare path sync
            old_import = rel_path
            new_import = os.path.join(os.path.dirname(rel_path), new_name).replace('\\', '/')
            path_sync_map[old_import] = new_import

    print(f"Mapped {len(rename_map)} files.")

    # 2. Global Import Sync (Memory Efficient)
    print("--- Step 2: Global Import Synchronization ---")
    
    # Build a consolidated regex for all imports
    # We look for: 'package:primecare_core/...old_rel...' or '...old_rel...'
    # To optimize, we focus on the package imports first as they are unique.
    
    # We will use simple string replacement for package imports as they are structured.
    # For relative imports, we match the basename.
    
    import_replacements = {}
    for old, new in path_sync_map.items():
        # Package import: package:primecare_core/old -> package:primecare_core/new
        import_replacements[f"{PACKAGE_NAME}/{old}"] = f"{PACKAGE_NAME}/{new}"
        # Relative import: 'basename' -> 'new_basename'
        # Note: This is risky at scale if basenames overlap. 
        # But in PrimeCare, filenames are mostly unique per feature.
        import_replacements[os.path.basename(old)] = os.path.basename(new)

    # Sort replacements by length descending to prevent partial matching collisions
    sorted_replacements = sorted(import_replacements.items(), key=lambda x: len(x[0]), reverse=True)

    file_count = 0
    update_count = 0
    for root, dirs, files in os.walk(ROOT_DIR):
        if any(x in root for x in [".git", ".dart_tool", "build", "node_modules"]):
            continue
            
        for file in files:
            if not file.endswith('.dart'):
                continue
            
            file_path = os.path.join(root, file)
            file_count += 1
            
            try:
                with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                    content = f.read()
                
                new_content = content
                changed = False
                
                # Apply replacements
                for old, new in sorted_replacements:
                    if old in new_content:
                        # Use word boundaries or quote matching for saftey
                        # For package imports, literal match is safe.
                        # For relative imports, check if in quotes.
                        if "/" in old: # Package import
                            new_content = new_content.replace(old, new)
                            changed = True
                        else: # Basename
                            # Only replace if surrounded by quotes
                            new_content = new_content.replace(f"'{old}'", f"'{new}'")
                            new_content = new_content.replace(f'"{old}"', f'"{new}"')
                            changed = True
                
                if changed:
                    with open(file_path, 'w', encoding='utf-8') as f:
                        f.write(new_content)
                    update_count += 1
            except Exception as e:
                print(f"Error processing {file}: {e}")

    print(f"Scanned {file_count} files, updated imports in {update_count} files.")

    # 3. Physical Renames
    print("--- Step 3: Physical Renaming ---")
    rename_count = 0
    for old_rel, new_name in rename_map.items():
        old_full = os.path.join(CORE_LIB, old_rel)
        new_full = os.path.join(os.path.dirname(old_full), new_name)
        
        try:
            if os.path.exists(old_full):
                os.rename(old_full, new_full)
                rename_count += 1
        except Exception as e:
            print(f"Rename failed: {old_rel} -> {new_name}: {e}")

    print(f"Renamed {rename_count} files.")
    print(f"Done in {time.time() - start_time:.2f} seconds.")

if __name__ == "__main__":
    main()
