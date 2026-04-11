import os
import re

# 1. Update pubspec.yaml files
pubspecs_to_update = {
    r"./packages/flutter_ui/pubspec.yaml": r"  primecare_adapters:\n    path: ../primecare_adapters\n",
    r"./apps/primecare_corporate/pubspec.yaml": r"  primecare_adapters:\n    path: ../../packages/primecare_adapters\n",
    r"./apps/primecare_clinic/pubspec.yaml": r"  primecare_adapters:\n    path: ../../packages/primecare_adapters\n",
    r"./apps/primecare_client/pubspec.yaml": r"  primecare_adapters:\n    path: ../../packages/primecare_adapters\n",
    r"./apps/primecare_franchise/pubspec.yaml": r"  primecare_adapters:\n    path: ../../packages/primecare_adapters\n",
    r"./apps/primecare_support/pubspec.yaml": r"  primecare_adapters:\n    path: ../../packages/primecare_adapters\n",
    r"./apps/primecare_business_development/pubspec.yaml": r"  primecare_adapters:\n    path: ../../packages/primecare_adapters\n",
    r"./apps/primecare_marketing/pubspec.yaml": r"  primecare_adapters:\n    path: ../../packages/primecare_adapters\n"
}

for pubspec, dependency in pubspecs_to_update.items():
    if os.path.exists(pubspec):
        with open(pubspec, 'r', encoding='utf-8') as f:
            content = f.read()

        # Check if already present
        if "primecare_adapters:" not in content:
            # We want to inject it right after `flutter_core:` ...
            content = content.replace("  flutter_core:\n    path: ../flutter_core\n", f"  flutter_core:\n    path: ../flutter_core\n{dependency}")
            content = content.replace("  flutter_core:\n    path: ../../packages/flutter_core\n", f"  flutter_core:\n    path: ../../packages/flutter_core\n{dependency}")
            
            with open(pubspec, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"Updated {pubspec}")

# 2. Inject `import 'package:primecare_adapters/primecare_adapters.dart';` across UI code files.
# Because the adapters moved out of `flutter_core.dart`, wherever `_adapterProvider` is used, 
# it needs the new package imported.
# We will just greedily check if the file references `AdapterProvider` and if so, add the import if not present.

directories_to_scan = [
    r"./packages/flutter_ui/lib",
    r"./apps/primecare_corporate/lib",
    r"./apps/primecare_clinic/lib",
    r"./apps/primecare_client/lib",
    r"./apps/primecare_franchise/lib",
    r"./apps/primecare_support/lib",
    r"./apps/primecare_business_development/lib",
    r"./apps/primecare_marketing/lib"
]

import_statement = "import 'package:primecare_adapters/primecare_adapters.dart';\n"
flutter_core_import = "import 'package:flutter_core/flutter_core.dart';"

modified_files = 0
for d in directories_to_scan:
    if not os.path.exists(d):
        continue
    for root, _, files in os.walk(d):
        for file in files:
            if file.endswith('.dart'):
                filepath = os.path.join(root, file)
                with open(filepath, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                # Check if it uses an adapter (AdapterProvider or similar)
                if "AdapterProvider" in content or "adapterProvider" in content:
                    if import_statement.strip() not in content:
                        # Insert it below flutter_core/flutter_core.dart
                        if flutter_core_import in content:
                            content = content.replace(flutter_core_import, flutter_core_import + "\n" + import_statement.strip())
                            modified_files += 1
                            with open(filepath, 'w', encoding='utf-8') as f:
                                f.write(content)
                        else:
                            # Or just at the top below other imports
                            lines = content.split('\n')
                            import_idx = 0
                            for i, line in enumerate(lines):
                                if line.startswith('import '):
                                    import_idx = i
                            if import_idx > 0:
                                lines.insert(import_idx + 1, import_statement.strip())
                                modified_files += 1
                                with open(filepath, 'w', encoding='utf-8') as f:
                                    f.write('\n'.join(lines))

print(f"Injected primecare_adapters import into {modified_files} files.")
