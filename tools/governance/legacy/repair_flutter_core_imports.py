import os
import re

ROOT_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
CORE_LIB = os.path.join(ROOT_DIR, "packages/flutter_core/lib")

# Layer Mapping Logic (replicated from main refactor script)
LAYERS = {
    "00": "B", "01": "I", "02": "M", "03": "D", "04": "V", "05": "U"
}

def get_layer_id(rel_path):
    rel_path = rel_path.replace('\\', '/')
    if rel_path in ["main.dart", "app.dart", "flutter_core.dart"]: return "00"
    if any(x in rel_path for x in ["routes/", "resilience/", "services/", "utils/"]): return "01"
    if any(x in rel_path for x in ["domain/models/", "src/models/", "dtos/"]): return "02"
    if any(x in rel_path for x in ["repositories/", "mappers/", "providers/"]): return "03"
    if any(x in rel_path for x in ["view_models/", "notifiers/"]): return "04"
    return "05" if "presentation/" in rel_path else "01"

def main():
    print("--- Phase 1: Building Suffix-Aware Rename Map ---")
    # We map 'original_basename.dart' -> '0X_L_original_basename.dart'
    # And we map 'path/to/original.dart' -> 'path/to/0X_L_original.dart'
    
    mapping = {} # original_basename -> prefixed_basename
    
    # We walk the CURRENT state of lib (already renamed)
    for root, dirs, files in os.walk(CORE_LIB):
        for file in files:
            if not file.endswith('.dart'): continue
            
            # Check if it has our prefix pattern 0X_L_
            match = re.match(r"^(\d{2}_[A-Z]_)(.*\.dart)$", file)
            if match:
                prefix = match.group(1)
                original_basename = match.group(2)
                mapping[original_basename] = file

    print(f"Captured {len(mapping)} unique renamed basenames.")

    print("--- Phase 2: Repairing Broken Imports ---")
    
    # We match: '.../original.dart' or 'original.dart'
    # We must ensure we don't double-prefix or catch wrong packages.
    
    update_count = 0
    file_count = 0
    
    for root, dirs, files in os.walk(ROOT_DIR):
        if any(x in root for x in [".git", ".dart_tool", "build", "node_modules"]): continue
        
        for file in files:
            if not file.endswith('.dart'): continue
            
            file_path = os.path.join(root, file)
            file_count += 1
            
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            new_content = content
            changed = False
            
            # Use regex to find all strings in quotes for safety
            # Matches '...' or "..."
            matches = re.findall(r"['\"](.*?)['\"]", content)
            
            for import_path in set(matches):
                if not import_path.endswith('.dart'): continue
                
                # Check each shard of the mapping
                basename = os.path.basename(import_path)
                if basename in mapping:
                    new_basename = mapping[basename]
                    
                    # Safety check: Already prefixed in this specific string?
                    if new_basename in import_path:
                        continue
                        
                    # Reconstruct the path
                    dirname = os.path.dirname(import_path)
                    new_import_path = os.path.join(dirname, new_basename).replace('\\', '/')
                    
                    # Execute replacement of the literal string in quotes
                    # We replace the whole path to be safe
                    old_str1 = f"'{import_path}'"
                    new_str1 = f"'{new_import_path}'"
                    if old_str1 in new_content:
                        new_content = new_content.replace(old_str1, new_str1)
                        changed = True
                        
                    old_str2 = f'"{import_path}"'
                    new_str2 = f'"{new_import_path}"'
                    if old_str2 in new_content:
                        new_content = new_content.replace(old_str2, new_str2)
                        changed = True

            if changed:
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(new_content)
                update_count += 1

    print(f"Scanned {file_count} files. Repaired {update_count} files.")
    print("Repair Complete.")

if __name__ == "__main__":
    main()
