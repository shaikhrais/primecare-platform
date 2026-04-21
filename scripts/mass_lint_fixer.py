import os
import re

def fix_lints(directory):
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.dart'):
                path = os.path.join(root, file)
                with open(path, 'r', encoding='utf-8') as f:
                    content = f.read()

                # 1. Fix extra trailing brace
                # Count open and close braces
                opens = content.count('{')
                closes = content.count('}')
                if closes > opens and content.strip().endswith('}'):
                    content = content.rstrip()
                    while content.endswith('}') and closes > opens:
                        content = content[:-1].rstrip()
                        closes -= 1
                    content += '\n'

                # 2. Fix untyped map entries in itemsFromMetrics
                content = content.replace('.map((e) {', '.map((MapEntry<String, dynamic> e) {')
                
                # 3. Handle dynamic calls in itemsFromMetrics
                if 'e.value.toString()' in content:
                    content = content.replace('e.value.toString()', 'e.value?.toString() ?? "0"')

                # 4. Remove unnecessary imports if standardized core is present
                if "import 'package:primecare_core/00_B_flutter_core.dart';" in content:
                    content = content.replace("import 'package:primecare_adapters/primecare_adapters.dart';\n", "")
                    content = content.replace("import 'package:flutter_riverpod/flutter_riverpod.dart';\n", "")
                
                # 5. Fix theme.spacing access if it's a common error (e.g. theme.spacing.lg)
                # (Leave this for now unless we see it's a consistent error)

                with open(path, 'w', encoding='utf-8') as f:
                    f.write(content)

if __name__ == "__main__":
    fix_lints('packages/flutter_core/lib/features')
