import os
import re

base_dir = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_v4\lib"
target_files = []

for root, _, files in os.walk(base_dir):
    for f in files:
        if f.endswith(".dart"):
            filepath = os.path.join(root, f)
            with open(filepath, 'r', encoding='utf-8') as f_obj:
                content = f_obj.read()
                
                # Check if it has the broken import
                if "import '../../providers/dynamic_page_providers.dart';" in content:
                    new_content = content.replace("import '../../providers/dynamic_page_providers.dart';", "import 'package:primecare_v4/providers/dynamic_page_providers.dart';")
                    target_files.append((filepath, new_content))

for filepath, new_content in target_files:
    with open(filepath, 'w', encoding='utf-8') as f_obj:
        f_obj.write(new_content)

print(f"Fixed imports in {len(target_files)} files.")

# Fix dynamic_page_providers.dart
dyn_prov_path = os.path.join(base_dir, "providers", "dynamic_page_providers.dart")
fixed_provider_code = """
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/api_client.dart';
import '../core/config/api_config.dart';

final apiClient = ApiClient();

final dynamicPageProvider = FutureProvider.family<List<dynamic>, String>((ref, endpointKey) async {
  final path = ApiConfig.endpoints[endpointKey];
  if (path == null) throw Exception('Endpoint $endpointKey not found in registry');
  
  final parts = path.split('/').where((p) => p.isNotEmpty).toList();
  final dataKey = parts.last.replaceAll('-', '_');

  final response = await apiClient.get(path);
  final json = response.data;
  if (json is Map && json.containsKey(dataKey)) {
    return json[dataKey] as List<dynamic>;
  }
  return [];
});
"""

with open(dyn_prov_path, "w", encoding='utf-8') as f:
    f.write(fixed_provider_code)

print("Fixed dynamic_page_providers.dart")
