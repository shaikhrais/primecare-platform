import os
import re

count = 0
for root, dirs, files in os.walk('packages/flutter_core/lib/features'):
    for file in files:
        if file.endswith('_adapter.dart'):
            path = os.path.join(root, file)
            with open(path, 'r', encoding='utf-8') as f:
                content = f.read()

            original = content
            
            # Very precise patch to only touch property assignments safely inside object instantiations 
            # e.g., name: node?['name'] ?? 'Jane Doe' -> name: (node?['name'] as String?) ?? 'Jane Doe'
            content = re.sub(
                r":\s*(node\?\['\w+'\])\s*\?\?\s*('[^']*')",
                r": (\1 as String?) ?? \2",
                content
            )

            # Fix boolean assignments: status: node?['status'] ?? false
            content = re.sub(
                r":\s*(node\?\['\w+'\])\s*\?\?\s*(true|false)",
                r": (\1 as bool?) ?? \2",
                content
            )

            if original != content:
                with open(path, 'w', encoding='utf-8') as f:
                    f.write(content)
                count += 1
print(f"Patched {count} precision form adapters")
