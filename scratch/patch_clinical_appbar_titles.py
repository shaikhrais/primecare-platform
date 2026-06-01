import os
import re
import subprocess

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
CLINICAL_DIR = os.path.join(PROJECT_ROOT, "packages", "primecare_ui", "lib", "src", "screens", "clinical")

def patch_file(filepath):
    filename = os.path.basename(filepath)
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Pattern to match the AppBar title Text widget
    pattern = r"title:\s+Text\(\s*key:\s*const\s+Key\('([a-zA-Z0-9_-]+)-title'\),\s*state\.title,\s*style:\s+theme\.typography\.h3\.copyWith\(color:\s+theme\.colors\.onSurface\),\s*\),"
    
    match = re.search(pattern, content)
    if not match:
        return False

    key_name = match.group(1)
    
    replacement = (
        f"title: Semantics(\n            label: 'data-cy:{key_name}-title',\n            child: Text(\n              key: const Key('{key_name}-title'),\n              state.title,\n              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),\n            ),\n          ),"
    )

    patched_content = re.sub(pattern, replacement, content)
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(patched_content)
        
    print(f"[+] Successfully patched: {filename} (key: {key_name}-title)")
    return True

def main():
    print("=== STARTING CLINICAL APPBAR SEMANTICS PATCHING ===")
    
    patched_count = 0
    for root, dirs, files in os.walk(CLINICAL_DIR):
        for file in files:
            if file.endswith("_screen.dart"):
                filepath = os.path.join(root, file)
                if patch_file(filepath):
                    patched_count += 1
                    
    print(f"\nTotal clinical files patched: {patched_count}")
    
    if patched_count > 0:
        print("\n[*] Formatting screens...")
        subprocess.run(["dart", "format", "packages/primecare_ui/lib/src/screens/clinical/"], cwd=PROJECT_ROOT, shell=True)
        print("[+] Formatting complete!")

if __name__ == '__main__':
    main()
