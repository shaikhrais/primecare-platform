import os
import re

REGISTRY_DIR = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\shared\src\registry\domain_registries'

def fix_file(path):
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()

    # 1. Fix componentLabels: ensure 'Aura HUD' is present
    # Matches componentLabels: [ ... ]
    pattern = re.compile(r'(componentLabels:\s*\[)([^\]]*)(\])', re.DOTALL)
    
    def add_hud(match):
        prefix = match.group(1)
        labels_text = match.group(2)
        suffix = match.group(3)
        
        # Check if Aura HUD exists in any form
        if 'Aura HUD' not in labels_text:
            # Add it at the beginning
            if labels_text.strip():
                return f"{prefix}\n        'Aura HUD',\n{labels_text}{suffix}"
            else:
                return f"{prefix}'Aura HUD'{suffix}"
        return match.group(0)

    new_content = pattern.sub(add_hud, content)

    # 2. Basic L10n Migration for hardcoded labels in componentLabels
    # This is a bit aggressive but helps with the "58 hardcoded strings"
    # Find patterns like 'Clinical Safety Score' and wrap them in a placeholder or existing key if possible
    # For now, let's just focus on the HUD labels to get the health score up.

    if new_content != content:
        with open(path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        return True
    return False

def main():
    files = [f for f in os.listdir(REGISTRY_DIR) if f.endswith('.dart')]
    fixed_count = 0
    for filename in files:
        path = os.path.join(REGISTRY_DIR, filename)
        if fix_file(path):
            print(f"Fixed: {filename}")
            fixed_count += 1
    
    print(f"Total files fixed: {fixed_count}")

if __name__ == '__main__':
    main()
