import os
import re
import json

# --- Configuration ---
PROJECT_ROOT = "C:/Users/Admin2/Documents/GitHub/primecare-platform"
INTENTS_PATH = os.path.join(PROJECT_ROOT, ".agents/ui_intents.json")
FEATURES_DIR = os.path.join(PROJECT_ROOT, "packages/flutter_core/lib/features")
UI_PACKAGE_DIR = os.path.join(PROJECT_ROOT, "packages/factory_system/primecare_ui/lib/src")

def to_snake_case(name):
    name = re.sub(r'(?<!^)(?=[A-Z])', '_', name).lower()
    return name

def scan_physical_files():
    physical_files = {}
    # Scan both feature specific (flutter_core) and generic UI (primecare_ui)
    search_dirs = [
        (FEATURES_DIR, "packages/flutter_core"),
        (UI_PACKAGE_DIR, "packages/factory_system/primecare_ui")
    ]
    
    for base_dir, rel_to in search_dirs:
        for root, dirs, files in os.walk(base_dir):
            for file in files:
                if file.endswith('.dart'):
                    abs_path = os.path.join(root, file)
                    rel_path = os.path.relpath(abs_path, os.path.join(PROJECT_ROOT, rel_to))
                    
                    content = ""
                    with open(abs_path, 'r', encoding='utf-8', errors='ignore') as f:
                        content = f.read()
                    
                    is_placeholder = "Placeholder" in content and "PrimeCareResponsiveKpiGrid" not in content
                    if "extends Placeholder" in content or "return const Placeholder()" in content:
                        is_placeholder = True
                    
                    physical_files[rel_path] = {
                        "abs_path": abs_path,
                        "is_placeholder": is_placeholder,
                        "filename": file,
                        "content": content
                    }
    return physical_files

def run_pdm_scan():
    physical = scan_physical_files()
    
    with open(INTENTS_PATH, 'r') as f:
        intents = json.load(f)
    
    results = []

    for intent in intents:
        intent_id = intent['intentId']
        if any(x in intent_id for x in ['Adapter', 'Dto', 'Mapper', 'ViewModel', 'Command', 'Event']):
            continue
            
        enum_name = intent['enumName']
        snake_name = to_snake_case(enum_name)
        
        # Stem extraction (be very careful with underscores)
        stem = snake_name.replace("_dashboard", "").replace("_screen", "").replace("_provider", "").replace("_page", "")
        if stem.endswith('_'): stem = stem[:-1]
        
        found_rel = None
        status = "UNALLOCATED"
        
        # 1. Broad Stem Match (Any file containing the core domain keyword)
        for rel_path, info in physical.items():
            fname = info['filename'].lower()
            if stem in fname or stem in rel_path.lower():
                # For specific intents, we want better alignment
                if 'provider' in intent_id.lower() and not ('provider' in fname or 'notifier' in fname or 'state' in fname):
                    continue
                found_rel = rel_path
                break
        
        # 2. Content-Based Match (Final fallback)
        if not found_rel:
            for rel_path, info in physical.items():
                if f"final {intent_id}" in info['content'] or f"class {intent['implementationClass']}" in info['content']:
                    found_rel = rel_path
                    break

        if found_rel:
            status = "EMPTY_BLOCK" if physical[found_rel]['is_placeholder'] else "OCCUPIED"
            
        results.append({
            "intentId": intent_id,
            "enumName": enum_name,
            "status": status,
            "rel_path": found_rel or "N/A",
            "is_dashboard": "Dashboard" in enum_name
        })

    return results

if __name__ == "__main__":
    results = run_pdm_scan()
    with open("pdm_snapshot.json", "w") as f:
        json.dump(results, f, indent=2)
    
    occupied = len([r for r in results if r['status'] == 'OCCUPIED'])
    empty = len([r for r in results if r['status'] == 'EMPTY_BLOCK'])
    unallocated = len([r for r in results if r['status'] == 'UNALLOCATED'])
    
    print(f"PDM Scan Complete (Bidirectional).")
    print(f"Total Intents Analyzed: {len(results)}")
    print(f"Occupied (Implemented): {occupied}")
    print(f"Empty (Placeholders):  {empty}")
    print(f"Unallocated (Missing): {unallocated}")
