import os
from pathlib import Path
import re
import subprocess

def fix_dependencies():
    base_dir = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
    pubspec_paths = list(Path(base_dir).rglob("pubspec.yaml"))
    
    # 1. Rename flutter_core -> primecare_core in packages/flutter_core/pubspec.yaml
    core_pubspec = Path(base_dir) / "packages" / "flutter_core" / "pubspec.yaml"
    if core_pubspec.exists():
        with open(core_pubspec, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Replace 'name: flutter_core' with 'name: primecare_core'
        new_content = re.sub(r'^name:\s*flutter_core', 'name: primecare_core', content, flags=re.MULTILINE)
        
        with open(core_pubspec, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated name in {core_pubspec}")

    # 2. Go through all pubspecs and replace dependency mappings
    for ps in pubspec_paths:
        if 'node_modules' in str(ps) or '.dart_tool' in str(ps):
            continue
            
        with open(ps, 'r', encoding='utf-8') as f:
            content = f.read()
            
        # Replace dependency 'flutter_core:' with 'primecare_core:'
        # and if flutter_riverpod is missing, inject it (but actually all apps and core have it)
        new_content = re.sub(r'^\s*flutter_core:\s*$', '  primecare_core:', content, flags=re.MULTILINE)
        
        # Check if flutter_riverpod is missing in dependencies
        if 'dependencies:' in new_content and 'flutter_riverpod:' not in new_content and 'primecare' in str(ps):
            # Only inject if it's an app that needs it (optional, apps usually inherit)
            pass

        if new_content != content:
            with open(ps, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f"Updated dependencies in {ps}")

    # 3. Re-run pub get everywhere
    print("Running dart pub get in apps and packages...")
    dirs_to_get = [
        "packages/flutter_core",
        "packages/primecare_adapters",
        "packages/factory_system/primecare_ui",
        "apps/primecare_client",
        "apps/primecare_clinic",
        "apps/primecare_corporate",
        "apps/primecare_business_development",
        "apps/primecare_franchise",
        "apps/primecare_marketing",
        "apps/primecare_support"
    ]
    for d in dirs_to_get:
        target_dir = Path(base_dir) / d
        if target_dir.exists():
            print(f"dart pub get in {d}")
            subprocess.run(["dart", "pub", "get"], cwd=target_dir, shell=True)
            
    print("Dependencies synchronized successfully.")

if __name__ == "__main__":
    fix_dependencies()
