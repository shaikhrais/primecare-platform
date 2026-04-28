import re

with open('lib/src/screen_registry.dart', 'r', encoding='utf-8') as f:
    content = f.read()

imports = """import 'package:primecare_ui/src/shared/src/models/core/dashboard_models.dart';
import 'package:primecare_ui/src/shared/src/models/core/ui_blueprint.dart';
import 'package:primecare_ui/src/shared/src/core/primecare_components.dart';
import 'package:primecare_ui/src/shared/src/config/locale_keys.dart';
"""

content = content.replace("import 'registries.dart';", "import 'registries.dart';\n" + imports)

with open('lib/src/screen_registry.dart', 'w', encoding='utf-8') as f:
    f.write(content)

print("Added imports to screen_registry.dart")
