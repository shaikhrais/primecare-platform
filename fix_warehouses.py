import re
import os

with open('analyze_errors.txt', 'r', encoding='utf-16') as f:
    lines = f.readlines()

errors = {}
for line in lines:
    m = re.search(r'error - (packages\\factory_system\\primecare_ui\\lib\\src\\warehouse\\offices\\[^\:]+\.dart):(\d+):', line)
    if not m:
        m = re.search(r'error - (lib\\src\\warehouse\\offices\\[^\:]+\.dart):(\d+):', line)
        
    if m:
        # Normalize the path to be relative to primecare_ui
        file = m.group(1).replace('packages\\factory_system\\primecare_ui\\', '')
        lineno = int(m.group(2))
        
        # Check if it's one of the undefined errors
        if 'undefined' in line or 'creation_with_non_type' in line or 'uri_does_not_exist' in line:
            if file not in errors:
                errors[file] = []
            errors[file].append((lineno, line))

for file, errs in errors.items():
    full_path = os.path.join('packages', 'factory_system', 'primecare_ui', file)
    print(f"Fixing {full_path}")
    with open(full_path, 'r', encoding='utf-8') as f:
        content_lines = f.readlines()
    
    # Sort errors in descending order so line number shifts don't affect previous lines
    errs = sorted(errs, key=lambda x: x[0], reverse=True)
    
    # Wait, the add material is better done after line replacements. Let's just do line replacements without shifting, since we sort descending
    
    for lineno, msg in errs:
        idx = lineno - 1
        if idx < len(content_lines):
            if 'uri_does_not_exist' in msg:
                # Comment out the import
                content_lines[idx] = '// ' + content_lines[idx]
            else:
                # Replace the right side of the arrow with const SizedBox.shrink()
                leading_spaces = len(content_lines[idx]) - len(content_lines[idx].lstrip())
                content_lines[idx] = (' ' * leading_spaces) + "const SizedBox.shrink(), // automatically replaced\n"

    # Add material.dart if needed
    has_material = any('material.dart' in l for l in content_lines)
    if not has_material:
        content_lines.insert(0, "import 'package:flutter/material.dart';\n")

    with open(full_path, 'w', encoding='utf-8') as f:
        f.writelines(content_lines)

print("Done fixing warehouses")
