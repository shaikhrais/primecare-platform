import os
import re

def fix_adapter_files(start_dir):
    for root, dirs, files in os.walk(start_dir):
        for file in files:
            if not file.endswith('_adapter.dart'):
                continue
            filepath = os.path.join(root, file)
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()

            original_content = content

            # Fix `as dynamic?) ?? []` to `as List<dynamic>?) ?? []` specifically when there is a dict lookup before it.
            # actually we can just match `as dynamic?) ?? []`
            content = re.sub(r"as dynamic\?\)\s*\?\?\s*\[\]", r"as List<dynamic>?) ?? []", content)
            
            # Fix `as num?) ?? 0`
            if "as num?) ?? 0" in content:
                content = content.replace("as num?) ?? 0", "as num?)?.toInt() ?? 0")

            # Let's fix occurrences of `data['` ONLY if it is exactly `data['` without preceding dot
            # Using regex: (?<!\.)\bdata\['
            content = re.sub(r"(?<!\.)\bdata(\[\'[a-zA-Z0-9_]+\'\])", r"(data as Map<String, dynamic>)\1", content)
            
            # Deduplicate `(data as Map<String, dynamic>)`
            while "(data as Map<String, dynamic>) as Map<String, dynamic>" in content:
                content = content.replace("(data as Map<String, dynamic>) as Map<String, dynamic>", "data as Map<String, dynamic>")
            
            if content != original_content:
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(content)
                print(f"Fixed {file}")

import sys
if __name__ == '__main__':
    fix_adapter_files('packages/factory_system/primecare_ui/lib/src')
