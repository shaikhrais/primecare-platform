import re

with open('lib/src/shared/src/generic/dynamic_screen_adapter.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("import '../../primecare_adapters.dart';", "import 'dart:async';\nimport 'package:flutter_riverpod/flutter_riverpod.dart';\nimport '../../primecare_adapters.dart';")

with open('lib/src/shared/src/generic/dynamic_screen_adapter.dart', 'w', encoding='utf-8') as f:
    f.write(content)

print("Added imports to Dynamic Screen Adapter")
