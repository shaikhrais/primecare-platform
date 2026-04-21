import os
import re

ROOT_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
CORE_LIB = os.path.join(ROOT_DIR, "packages/flutter_core/lib")

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
    print("--- Final Sweep: Renaming Outliers ---")
    
    count = 0
    for root, dirs, files in os.walk(CORE_LIB):
        for file in files:
            if not file.endswith('.dart'): continue
            if re.match(r"^\d{2}_[A-Z]_", file): continue
            if ".g.dart" in file or ".freezed.dart" in file: continue
            if file == "primecare_core.dart": continue # already handled as 00_B? Wait.
            
            full_path = os.path.join(root, file)
            rel_path = os.path.relpath(full_path, CORE_LIB).replace('\\', '/')
            
            layer_id = get_layer_id(rel_path)
            letter = LAYERS[layer_id]
            new_name = f"{layer_id}_{letter}_{file}"
            
            new_full = os.path.join(root, new_name)
            
            try:
                os.rename(full_path, new_full)
                print(f"Renamed: {file} -> {new_name}")
                count += 1
            except Exception as e:
                print(f"Failed to rename {file}: {e}")

    print(f"Successfully renamed {count} missed files.")

if __name__ == "__main__":
    main()
