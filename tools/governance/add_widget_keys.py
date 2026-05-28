import os
import re

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

def find_dart_files(root_dir):
    dart_files = []
    for root, dirs, files in os.walk(root_dir):
        if "node_modules" in root or ".dart_tool" in root or "build" in root or ".git" in root:
            continue
        for file in files:
            if file.endswith(".dart"):
                dart_files.append(os.path.join(root, file))
    return dart_files

def main():
    print("==============================================================")
    print("PRIMECARE GOVERNANCE: AUTOMATED FLUTTER WIDGET KEYS INJECTOR")
    print("==============================================================")

    apps_dir = os.path.join(PROJECT_ROOT, "apps")
    packages_dir = os.path.join(PROJECT_ROOT, "packages", "primecare_ui")
    
    dart_files = find_dart_files(apps_dir) + find_dart_files(packages_dir)
    print(f"Loaded {len(dart_files)} Dart files to scan for keys.")

    injected_count = 0

    # Target interactive classes commonly used in forms
    targets = [
        ("TextField", "input"),
        ("ElevatedButton", "button"),
        ("TextButton", "button"),
        ("OutlinedButton", "button"),
        ("IconButton", "button")
    ]

    for file_path in dart_files:
        basename = os.path.basename(file_path).replace(".dart", "")
        if "app_router" in basename or "main" in basename or "binding" in basename:
            continue

        try:
            with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
                content = f.read()

            original_content = content
            modified = False

            for target_class, suffix in targets:
                # Find occurrences of target_class( that do NOT have a 'key:' parameter
                # e.g. target_class( followed by arguments, but without key: Key(
                # To be extremely safe, we look for 'target_class(' and check if it already has key: or Key(
                # We use a regex finder and loop through matches to inject keys safely.
                pattern = re.compile(rf"{target_class}\((?!\s*key\s*:\s*(?:Key|value))")
                
                matches = list(pattern.finditer(content))
                if not matches:
                    continue

                # Reconstruct content by injecting keys
                new_content = ""
                last_idx = 0
                for i, match in enumerate(matches):
                    start, end = match.span()
                    new_content += content[last_idx:end]
                    
                    # Generate a unique stable key name based on file name, target class, and index
                    key_name = f"{basename}_{target_class.lower()}_{suffix}_{i+1}"
                    new_content += f"key: const Key('{key_name}'), "
                    
                    last_idx = end
                    modified = True
                    injected_count += 1

                new_content += content[last_idx:]
                content = new_content

            if modified:
                with open(file_path, "w", encoding="utf-8") as f:
                    f.write(content)
                rel_path = os.path.relpath(file_path, PROJECT_ROOT).replace("\\", "/")
                print(f"  Injected stable keys into: {rel_path}")

        except Exception as e:
            print(f"  Error processing {file_path}: {e}")

    print(f"\n==============================================================")
    print(f"[SUCCESS] Widget Keys Enforcer execution complete!")
    print(f"Total keys injected: {injected_count}")
    print("==============================================================")

if __name__ == '__main__':
    main()
