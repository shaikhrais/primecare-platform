import os
import re
import json

base_dir = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_v4\lib"
offices_dir = os.path.join(base_dir, "offices")
config_path = os.path.join(base_dir, "core", "config", "api_config.dart")

# Find all dummy updated office dashboard screens
target_files = []
for root, _, files in os.walk(offices_dir):
    for f in files:
        if f.endswith(".dart") and not ("_sidebar" in f or "_topbar" in f or "_layout" in f):
            filepath = os.path.join(root, f)
            with open(filepath, 'r', encoding='utf-8') as f_obj:
                content = f_obj.read()
                if "_buildLedgerRow(Icons.file_copy" in content:
                    target_files.append((filepath, content))

if not target_files:
    print("No dummy mock pages found to fix.")
    exit()

print(f"Discovered {len(target_files)} pages with dummy local data in primecare_v4.")

endpoints = {}

# We'll create a single provider file that generates API clients for these dynamic endpoints.
# Actually, since it's cleaner, we will inject a local asynchronous fetch mechanism into the file, or generate a unified dynamic provider.
dynamic_providers_code = """
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/api_client.dart';
import '../../core/config/api_config.dart';

// Dynamically generated providers for UI endpoints
final dynamicPageProvider = FutureProvider.family<List<dynamic>, String>((ref, endpointKey) async {
  final path = ApiConfig.endpoints[endpointKey];
  if (path == null) throw Exception('Endpoint $endpointKey not found in registry');
  
  // Extract identifier. e.g. /v1/office/dashboard/deals -> deals
  final parts = path.split('/').where((p) => p.isNotEmpty).toList();
  final dataKey = parts.last.replaceAll('-', '_');

  final json = await apiClient.get(path);
  if (json is Map && json.containsKey(dataKey)) {
    return json[dataKey] as List<dynamic>;
  }
  return [];
});
"""

os.makedirs(os.path.join(base_dir, "providers"), exist_ok=True)
with open(os.path.join(base_dir, "providers", "dynamic_page_providers.dart"), "w", encoding='utf-8') as f:
    f.write(dynamic_providers_code)

for filepath, content in target_files:
    # Derive unique endpoint key
    # e.g. class ClinicalAdmissionsView
    match = re.search(r'class\s+([A-Za-z0-9_]+)\s+extends', content)
    if not match: continue
    class_name = match.group(1)
    
    # Generate an endpoint path like '/v1/primecare/office/clinical_admissions'
    snake_case = re.sub(r'([A-Z])', r'_\1', class_name).lower().strip('_').replace('_view', '').replace('_dashboard', '')
    endpoint_path = f"/v1/primecare/office/{snake_case}"
    endpoint_key = f"office{class_name}"
    
    endpoints[endpoint_key] = endpoint_path
    
    # Now rewrite the UI file to use dynamicPageProvider instead of dummy static ledger rows.
    # We replace: _buildLedgerRow(Icons.file_copy...
    # Up to the end of the container.
    
    # We need to add the import to dynamic_page_providers.dart
    imports_block = "import '../../providers/dynamic_page_providers.dart';\n"
    new_content = content
    if "dynamic_page_providers.dart" not in new_content:
        new_content = re.sub(r"(import 'package:flutter/material.dart';)", r"\1\n" + imports_block, new_content)
    
    # Replace the glass surface content with a dynamic consumer
    dummy_block_regex = re.compile(
        r"GlassSurface\(\s*padding: const EdgeInsets\.all\(24\),\s*child: Column\(\s*.*?_buildLedgerRow.*?\]\s*,\s*\)\s*,\s*\)", 
        re.DOTALL
    )
    
    dynamic_ui_block = f"""GlassSurface(
                                padding: const EdgeInsets.all(24),
                                child: Consumer(
                                  builder: (context, ref, child) {{
                                    final dataAsync = ref.watch(dynamicPageProvider('{endpoint_key}'));
                                    return dataAsync.when(
                                      loading: () => const Center(child: CircularProgressIndicator()),
                                      error: (e, st) => Text('Error: $e'),
                                      data: (items) {{
                                        if (items.isEmpty) return const Text('No records found.', style: TextStyle(color: Colors.blueGrey));
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: items.map((item) {{
                                            return Column(
                                              children: [
                                                _buildLedgerRow(Icons.api, item['title'] ?? 'Record', item['status'] ?? 'Active', Colors.teal),
                                                const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                                              ],
                                            );
                                          }}).toList(),
                                        );
                                      }},
                                    );
                                  }},
                                ),
                              )"""
    new_content = dummy_block_regex.sub(dynamic_ui_block, new_content)
    
    with open(filepath, 'w', encoding='utf-8') as f_obj:
        f_obj.write(new_content)

print(f"Rewrote {len(target_files)} frontend UI files to use remote API endpoints instead of static mock arrays.")

# Now patch api_config.dart
with open(config_path, 'r', encoding='utf-8') as f:
    config_content = f.read()

# Insert the new endpoints into the map
map_entry_str = ""
for k, v in endpoints.items():
    map_entry_str += f"    '{k}': '{v}',\n"

# find the endpoints map and insert right after {
config_content = re.sub(r'(static const Map<String, String> endpoints = \{)', r'\1\n' + map_entry_str, config_content)

with open(config_path, 'w', encoding='utf-8') as f:
    f.write(config_content)
print("api_config.dart updated successfully.")

