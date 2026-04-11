import os
import re

ADAPTERS_DIR = r"./packages/primecare_adapters/lib/src/adapters"
FEATURES_DIR = r"./packages/flutter_core/lib/features"

features_available = set(os.listdir(FEATURES_DIR))

fixed_count = 0

for root, _, files in os.walk(ADAPTERS_DIR):
    for file in files:
        if file.endswith('.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()

            new_content = content
            
            # Find all feature names currently used in imports
            # import 'package:flutter_core/features/XYZ/...
            used_features = re.findall(r"package:flutter_core/features/([^/]+)/", new_content)
            
            for uf in set(used_features):
                if uf not in features_available:
                    # if XYZ not found, maybe XYZ_dashboard?
                    if f"{uf}_dashboard" in features_available:
                        new_content = new_content.replace(f"/features/{uf}/", f"/features/{uf}_dashboard/")
                        fixed_count += 1
            
            if new_content != content:
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(new_content)

print(f"Fixed {fixed_count} mismatched feature dashboard paths.")
