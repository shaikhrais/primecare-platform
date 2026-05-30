import os
import re
import subprocess

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
SCREENS_DIR = os.path.join(PROJECT_ROOT, "packages", "primecare_ui", "lib", "src", "screens")

def patch_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Pattern: title: Semantics( followed by whitespaces and container: true not already present.
    # We want to match "title: Semantics(" and insert "container: true," right after the parenthesis.
    # But only if "container: true" is not already the first argument in Semantics.
    # Let's check if "title: Semantics(" is in the file.
    if "title: Semantics(" not in content:
        return False

    # Regex: find title: Semantics( and check if the next word is not container: true.
    # We'll use a negative lookahead to prevent double-patching.
    pattern = r"title:\s+Semantics\(\s*(?!container:\s*true)"
    
    if not re.search(pattern, content):
        return False

    patched_content = re.sub(pattern, "title: Semantics(\n            container: true,\n            ", content)
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(patched_content)
        
    return True

def main():
    print("=== STARTING SEMANTICS CONTAINER PATCHING ===")
    patched_count = 0
    for root, dirs, files in os.walk(SCREENS_DIR):
        for file in files:
            if file.endswith("_screen.dart"):
                filepath = os.path.join(root, file)
                if patch_file(filepath):
                    print(f"[+] Patched: {os.path.relpath(filepath, SCREENS_DIR)}")
                    patched_count += 1
                    
    print(f"\nTotal screens patched: {patched_count}")
    
    if patched_count > 0:
        print("\n[*] Formatting screens...")
        subprocess.run(["dart", "format", "packages/primecare_ui/lib/src/screens/"], cwd=PROJECT_ROOT, shell=True)
        print("[+] Formatting complete!")

if __name__ == '__main__':
    main()
