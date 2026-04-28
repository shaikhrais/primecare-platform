import re

with open('lib/src/shared/src/dashboard_service.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("import 'core/dashboard_models.dart';", "import 'models/core/dashboard_models.dart';")
content = content.replace("import 'core/ui_blueprint.dart';", "import 'models/core/ui_blueprint.dart';")
content = content.replace("import '../infrastructure/result.dart';", "import 'result.dart';")
content = content.replace("import '../telemetry_service.dart';", "import 'telemetry_service.dart';")

with open('lib/src/shared/src/dashboard_service.dart', 'w', encoding='utf-8') as f:
    f.write(content)

with open('lib/src/shared/src/legacy_bridge.dart', 'r', encoding='utf-8') as f:
    content2 = f.read()

content2 = content2.replace("import 'core/dashboard_models.dart';", "import 'models/core/dashboard_models.dart';")

with open('lib/src/shared/src/legacy_bridge.dart', 'w', encoding='utf-8') as f:
    f.write(content2)

print("Imports fixed")
