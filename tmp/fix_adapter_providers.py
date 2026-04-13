import re

file_path = 'C:/Users/Admin2/Documents/GitHub/primecare-platform/packages/flutter_core/lib/adapter_providers.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

new_lines = []
imports_done = False
for line in lines:
    if line.startswith('import ') and 'domain/models/' in line:
        continue # Remove broken imports
    if line.startswith('import ') and not imports_done:
        new_lines.append(line)
        continue
    
    if not imports_done and not line.startswith('import '):
        if line.strip() != '':
            imports_done = True
            new_lines.append("import 'package:flutter_riverpod/flutter_riverpod.dart';\n")
            new_lines.append("import 'adapters/dynamic_adapter_provider.dart';\n")
            new_lines.append("import 'dashboard_providers.dart';\n")
            new_lines.append("import 'dynamic_registry_map.dart';\n")
            new_lines.append("import 'features/common/domain/models/common_feature_view_model.dart';\n\n")

    if line.startswith('final '):
        match = re.match(r'^final ([a-zA-Z0-9_]+DataProvider)\s*=', line)
        if match:
            provider_name = match.group(1)
            if provider_name == 'commonFeatureDataProvider':
                new_lines.append('''final commonFeatureDataProvider = FutureProvider.family<dynamic, String>((ref, id) async {
  if (dynamicAdapterRegistry.containsKey(id)) {
    return await ref.watch(dynamicAdapterRegistry[id]!.future);
  }
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return CommonFeatureViewModel.fromDashboardMetrics(metrics);
});\n''')
            else:
                new_lines.append(f"final {provider_name} = dynamicScreenViewModelProvider;\n")
        else:
            match_generic = re.match(r'^final ([a-zA-Z0-9_]+Provider)\s*=', line)
            if match_generic:
                provider_name = match_generic.group(1)
                new_lines.append(f"final {provider_name} = dynamicScreenViewModelProvider;\n")
    elif not line.startswith('final ') and not line.startswith('  ') and not line.startswith('}'):
        new_lines.append(line)

with open(file_path, 'w', encoding='utf-8') as f:
    f.writelines(new_lines)

print('Done fixing adapter provider.')
