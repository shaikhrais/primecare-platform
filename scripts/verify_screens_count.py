import os
import re

docs_dir = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\docs\system_wiki"
registry_path = r"C:\Users\Admin2\.gemini\antigravity\brain\70a810e6-ca4a-4160-9177-5b90c9067836\master_screen_registry.md"

registry_screens = set()
with open(registry_path, "r", encoding="utf-8") as f:
    for line in f:
        match = re.search(r"\|\s*`([a-z0-9_]+)`\s*\|", line.lower())
        if match:
            registry_screens.add(match.group(1))
        # Sometimes there's no backticks
        else:
            match2 = re.search(r"\|\s*([a-z]{3}_[0-9]{3}[a-z0-9_]*)\s*\|", line.lower())
            if match2:
                registry_screens.add(match2.group(1))

fs_screens = set()
for root, dirs, files in os.walk(docs_dir):
    rel_path = os.path.relpath(root, docs_dir)
    parts = rel_path.split(os.sep)
    if len(parts) == 5 and parts[1] == 'roles' and parts[3] == 'screens':
        fs_screens.add(parts[4].lower())

print(f"Unique screens in Registry: {len(registry_screens)}")
print(f"Unique screens in File System: {len(fs_screens)}")

missing_in_registry = fs_screens - registry_screens
missing_in_fs = registry_screens - fs_screens

print(f"Screens in FS but missing in Registry ({len(missing_in_registry)}): {list(missing_in_registry)[:10]}")
print(f"Screens in Registry but missing in FS ({len(missing_in_fs)}): {list(missing_in_fs)[:10]}")
