import re
import os
import glob

with open('analyze_errors2.txt', 'r', encoding='utf-16') as f:
    content = f.read()

# Find all missing URIs
missing_uris = set()
for m in re.finditer(r"Target of URI doesn't exist: '([^']+)'", content):
    missing_uris.add(m.group(1))

print(f"Found {len(missing_uris)} missing uris.")

warehouse_files = glob.glob('packages/factory_system/primecare_ui/lib/src/warehouse/offices/*.dart')

for file in warehouse_files:
    with open(file, 'r', encoding='utf-8') as f:
        lines = f.readlines()
        
    new_lines = []
    changed = False
    for line in lines:
        if 'import' in line:
            # check if the import targets a missing URI
            missing = False
            for uri in missing_uris:
                if uri in line:
                    missing = True
                    break
            if missing:
                new_lines.append('// ' + line)
                changed = True
            else:
                new_lines.append(line)
        else:
            new_lines.append(line)
            
    if changed:
        with open(file, 'w', encoding='utf-8') as f:
            f.writelines(new_lines)

print("Done fixing imports")
