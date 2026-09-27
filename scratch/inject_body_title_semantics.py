import os
import re

SCREENS_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\primecare_ui\lib\src\screens"

def main():
    modified_count = 0
    for root, dirs, files in os.walk(SCREENS_DIR):
        for f in files:
            if not f.endswith(".dart") or f.endswith("_controller.dart"):
                continue
                
            file_path = os.path.join(root, f)
            
            # Derive screen code from filename
            screen_code = f.replace(".dart", "").replace("_screen", "").replace("_view", "").replace("_", "").lower()
            
            with open(file_path, "r", encoding="utf-8") as file:
                content = file.read()
                
            # If the file already has GovDashboardHero, it already has body title semantics. Skip it!
            if "GovDashboardHero(" in content:
                continue
                
            # Check if this screen has a children list in a Column under the body
            if "children: [" in content and f"data-cy:{screen_code}-title" in content:
                # We want to insert the semantics tag as the very first element of the Column children list
                target = "children: ["
                replacement = f"children: [\n                Semantics(label: 'data-cy:{screen_code}-title', child: const SizedBox.shrink()),"
                
                # Check if it was already injected
                if f"Semantics(label: 'data-cy:{screen_code}-title', child: const SizedBox.shrink())" in content:
                    continue
                    
                new_content = content.replace(target, replacement, 1)
                
                if new_content != content:
                    with open(file_path, "w", encoding="utf-8") as file:
                        file.write(new_content)
                    print(f"Injected body title semantics in: {f}")
                    modified_count += 1
                    
    print(f"Successfully modified {modified_count} screen files.")

if __name__ == '__main__':
    main()
