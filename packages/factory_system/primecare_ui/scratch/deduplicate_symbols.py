import os
import re
from collections import Counter

FILES = ['features_view.dart', 'features_controller.dart', 'features_model.dart']
BASE_PATH = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\features'

def get_symbols(content):
    # Regex to find top-level symbols
    return re.findall(r'\b(?:class|abstract|mixin|enum|extension|final|const|var|typedef|void|Future|Stream|dynamic)\b\s+([A-Za-z0-9_]+)', content)

def deduplicate():
    print("Scanning for duplicates...")
    symbol_to_files = {}
    
    for filename in FILES:
        path = os.path.join(BASE_PATH, filename)
        if not os.path.exists(path): continue
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        symbols = get_symbols(content)
        for s in symbols:
            if s not in symbol_to_files: symbol_to_files[s] = []
            if filename not in symbol_to_files[s]:
                symbol_to_files[s].append(filename)

    duplicates = {s: files for s, files in symbol_to_files.items() if len(files) > 1}
    print(f"Found {len(duplicates)} ambiguous symbols.")

    for s, files in duplicates.items():
        print(f"  {s} in {files}")
        
        # Decide which one to keep
        # Priority: Model > Controller > View
        keep_file = None
        if 'features_model.dart' in files: keep_file = 'features_model.dart'
        elif 'features_controller.dart' in files: keep_file = 'features_controller.dart'
        else: keep_file = files[0]
        
        # Remove from other files
        for f in files:
            if f == keep_file: continue
            
            path = os.path.join(BASE_PATH, f)
            with open(path, 'r', encoding='utf-8') as file:
                content = file.read()
            
            # This is the hard part: removing the WHOLE declaration
            # For now, let's just comment it out or use a simple regex if it's a one-liner like a provider
            # Pattern: (comments) (keyword) s = ... ;
            # Or: class s { ... }
            
            print(f"    Removing {s} from {f}...")
            
            # Remove class declaration
            content = re.sub(r'(?://.*?\n)*\s*class\s+' + s + r'\b[\s\S]*?\n}', f'// DELETED DUPLICATE: {s}', content)
            # Remove provider declaration
            content = re.sub(r'(?://.*?\n)*\s*(?:final|const|var)\s+' + s + r'\b[\s\S]*?;', f'// DELETED DUPLICATE: {s}', content)
            
            with open(path, 'w', encoding='utf-8') as file:
                file.write(content)

    print("Done.")

if __name__ == "__main__":
    deduplicate()
