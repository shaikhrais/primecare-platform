import os
import re

SCREENS_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\primecare_ui\lib\src\screens"

def main():
    modified_count = 0
    pattern = re.compile(r"Semantics\(label:\s*'data-cy:([^']+)-title',\s*child:\s*const\s*SizedBox\.shrink\(\)\)")
    
    for root, dirs, files in os.walk(SCREENS_DIR):
        for f in files:
            if not f.endswith(".dart") or f.endswith("_controller.dart"):
                continue
                
            file_path = os.path.join(root, f)
            
            with open(file_path, "r", encoding="utf-8") as file:
                content = file.read()
                
            if "SizedBox.shrink()" not in content:
                continue
                
            # Perform regex search and replacement
            new_content, count = pattern.subn(r"Semantics(label: 'data-cy:\1-title', child: const SizedBox(width: 8, height: 8))", content)
            
            if count > 0:
                with open(file_path, "w", encoding="utf-8") as file:
                    file.write(new_content)
                print(f"[{count} match(es)] Fixed zero-size title semantics in: {f}")
                modified_count += 1
                
    print(f"\nSuccessfully refactored {modified_count} screen files to prevent E2E tree-shaking.")

if __name__ == '__main__':
    main()
