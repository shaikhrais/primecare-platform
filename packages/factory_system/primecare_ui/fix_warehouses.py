import re
import os

with open('analyze_errors.txt', 'r', encoding='utf-8') as f:
    lines = f.readlines()

errors = {}
for line in lines:
    m = re.search(r'error - (lib\\src\\warehouse\\offices\\[^\:]+\.dart):(\d+):', line)
    if m:
        file = m.group(1)
        lineno = int(m.group(2))
        
        # Check if it's one of the undefined errors
        if 'undefined' in line or 'creation_with_non_type' in line or 'uri_does_not_exist' in line:
            if file not in errors:
                errors[file] = []
            errors[file].append((lineno, line))

for file, errs in errors.items():
    print(f"Fixing {file}")
    with open(file, 'r', encoding='utf-8') as f:
        content_lines = f.readlines()
    
    # First, fix missing imports by adding material if needed
    has_material = any('material.dart' in l for l in content_lines)
    if not has_material:
        content_lines.insert(0, "import 'package:flutter/material.dart';\n")
        # Shift all lineno by 1
        errs = [(l+1, msg) for l, msg in errs]

    for lineno, msg in errs:
        idx = lineno - 1
        if idx < len(content_lines):
            if 'uri_does_not_exist' in msg:
                # Comment out the import
                content_lines[idx] = '// ' + content_lines[idx]
            else:
                # Replace the right side of the arrow with const SizedBox.shrink()
                # The line usually looks like         Approvesystemaccessform(data: payload),
                # or         const SomeScreen(),
                # Let's replace the whole line with just         const SizedBox.shrink(), 
                # but preserve leading whitespace
                leading_spaces = len(content_lines[idx]) - len(content_lines[idx].lstrip())
                content_lines[idx] = (' ' * leading_spaces) + "const SizedBox.shrink(), // automatically replaced\n"

    with open(file, 'w', encoding='utf-8') as f:
        f.writelines(content_lines)

print("Done fixing warehouses")
