import re
import os

with open(r'lib\src\features\features_model.dart', 'r', encoding='utf-8') as f:
    content = f.read()

classes = re.findall(r'\bclass\s+([A-Z][a-zA-Z0-9]+)\b', content)
suffixes = ['Dto', 'ViewModel', 'State', 'Controller', 'Mapper', 'Data', 'Form', 'Screen', 'View']

prefixes = set()
for c in classes:
    for s in suffixes:
        if c.endswith(s) and len(c) > len(s):
            prefix = c[:-len(s)]
            # If prefix still ends in a capital, it's likely a composite prefix or we haven't found the real split
            # e.g. CommonForms ApproveRealEstateForm (if suffix is Form)
            # Actually, let's just collect these prefixes.
            prefixes.add(prefix)

# Filter prefixes to find the "root" ones
# Root prefixes are usually the first one or two words
root_prefixes = set()
for p in prefixes:
    parts = re.findall('[A-Z][a-z0-9]*', p)
    if len(parts) >= 1:
        root_prefixes.add(parts[0])
        if len(parts) >= 2:
            root_prefixes.add(parts[0] + parts[1])

print("Found Root Prefixes:")
for rp in sorted(root_prefixes):
    print(rp)
