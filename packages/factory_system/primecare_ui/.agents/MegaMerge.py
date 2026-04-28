import os
import re

COMPONENTS_DIR = r'lib\src\components'
TARGET_FILE = r'lib\src\features\features_view.dart'

def merge_components():
    if not os.path.exists(COMPONENTS_DIR):
        print("Components dir not found.")
        return
    
    collected_code = []
    
    for root, dirs, files in os.walk(COMPONENTS_DIR):
        for file in files:
            if file.endswith('.dart'):
                file_path = os.path.join(root, file)
                with open(file_path, 'r', encoding='utf-8') as f:
                    lines = f.readlines()
                
                # Find the last import
                last_import_idx = -1
                for i, line in enumerate(lines):
                    if line.strip().startswith('import '):
                        last_import_idx = i
                
                # Extract code after imports
                code_lines = lines[last_import_idx + 1:]
                code = "".join(code_lines).strip()
                
                if code:
                    header = f"\n\n// --- Merged from {file_path} ---\n"
                    collected_code.append(header + code)
                    print(f"Collected {file_path}")

    if collected_code:
        with open(TARGET_FILE, 'a', encoding='utf-8') as f:
            f.write("\n\n// === MERGED COMPONENTS START ===\n")
            f.write("\n".join(collected_code))
            f.write("\n\n// === MERGED COMPONENTS END ===\n")
        print(f"Merged {len(collected_code)} components into {TARGET_FILE}")
    else:
        print("No code collected.")

if __name__ == '__main__':
    merge_components()
