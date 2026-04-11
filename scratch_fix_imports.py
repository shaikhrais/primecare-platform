import os
import re

ADAPTERS_DIR = r"./packages/primecare_adapters/lib/src/adapters"

for root, _, files in os.walk(ADAPTERS_DIR):
    for file in files:
        if file.endswith('.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()

            # Replace `import '../XYZ.dart';` where XYZ is a root flutter_core dir or file
            # e.g., config, network, provider_service.dart, api_providers.dart, etc.
            
            # Use regex to replace `import '../(something.dart|some_dir/something.dart)';` 
            # with `import 'package:flutter_core/\1';`
            # For safe matching, we check if it doesn't already start with package:
            
            # All these are inside flutter_core: 
            # - api_providers.dart
            # - config/
            # - network/
            # - registry/
            # - routes/
            # - theme/
            # - provider_service.dart
            # - dashboard_service.dart
            
            content = re.sub(r"import '\.\./(config|network|registry|routes|theme|provider_service\.dart|dashboard_service\.dart|api_providers\.dart)", r"import 'package:flutter_core/\1", content)
            
            # The only thing that should be local in primecare_adapters are the adapters themselves, 
            # but they don't import each other using `../` so we should be safe.
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)

print("Fixed relative flutter_core imports inside primecare_adapters.")
