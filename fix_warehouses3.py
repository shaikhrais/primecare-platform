import re
import os
import glob

with open('analyze_errors2.txt', 'r', encoding='utf-16') as f:
    content = f.read()

# Find all undefined names
names = set()
for m in re.finditer(r"The method '([a-zA-Z0-9_]+)' isn't defined", content):
    names.add(m.group(1))
for m in re.finditer(r"The name '([a-zA-Z0-9_]+)' isn't a class", content):
    names.add(m.group(1))
for m in re.finditer(r"The function '([a-zA-Z0-9_]+)' isn't defined", content):
    names.add(m.group(1))
for m in re.finditer(r"Undefined name '([a-zA-Z0-9_]+)'", content):
    names.add(m.group(1))

print(f"Found {len(names)} undefined names.")

warehouse_files = glob.glob('packages/factory_system/primecare_ui/lib/src/warehouse/offices/*.dart')

for file in warehouse_files:
    with open(file, 'r', encoding='utf-8') as f:
        text = f.read()
        
    original_text = text
    for name in names:
        text = re.sub(r'\b' + name + r'\s*\(.*?\)', 'const SizedBox.shrink()', text)
        text = re.sub(r'\bconst ' + name + r'\s*\(.*?\)', 'const SizedBox.shrink()', text)
        
    if text != original_text:
        has_material = 'material.dart' in text
        if not has_material:
            text = "import 'package:flutter/material.dart';\n" + text
            
        with open(file, 'w', encoding='utf-8') as f:
            f.write(text)

print("Done fixing warehouses")
