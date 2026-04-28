import re

with open('lib/primecare_ui.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("hide AuditOverrideData, ChartType, LayoutType;", "hide AuditOverrideData, ChartType, LayoutType, ResilientNotifierMixin;")
content = content.replace("export 'package:primecare_ui/src/features/features_model.dart';", "export 'package:primecare_ui/src/features/features_model.dart' hide FranchiseOwnerViewModel;")
content = content.replace("export 'package:primecare_ui/src/shared/src/core/primecare_components.dart';", "export 'package:primecare_ui/src/shared/src/core/primecare_components.dart' hide ComponentWarehouse;")

with open('lib/primecare_ui.dart', 'w', encoding='utf-8') as f:
    f.write(content)

with open('lib/src/shared/primecare_adapters.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("hide GovernanceRegistry;", "hide GovernanceRegistry, ProviderTTL;")

with open('lib/src/shared/primecare_adapters.dart', 'w', encoding='utf-8') as f:
    f.write(content)
