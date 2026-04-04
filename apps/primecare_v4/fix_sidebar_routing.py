import os
import re

base_dir = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_v4\lib"

# 1. Create generic_feature_screen.dart
screen_code = """
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dynamic_page_providers.dart';
import 'glass_surface.dart';

class GenericFeatureScreen extends ConsumerWidget {
  final String featureId;
  const GenericFeatureScreen({super.key, required this.featureId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(dynamicPageProvider(featureId));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              featureId.replaceAll('_', ' ').toUpperCase(),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF006565)),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GlassSurface(
                padding: const EdgeInsets.all(24),
                child: asyncData.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, st) => Center(child: Text('Error loading $featureId: $e')),
                  data: (items) {
                    if (items.isEmpty) {
                      return const Center(child: Text('No records found.', style: TextStyle(color: Colors.blueGrey)));
                    }
                    return ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(color: Colors.teal.withValues(alpha: 0.1), shape: BoxShape.circle),
                              child: const Icon(Icons.api, color: Colors.teal, size: 20),
                            ),
                            const SizedBox(width: 16),
                            Expanded(child: Text(item['title'] ?? 'Record', style: const TextStyle(fontWeight: FontWeight.w600))),
                            Text(item['status'] ?? 'Active', style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.w600)),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
"""

with open(os.path.join(base_dir, "components", "generic_feature_screen.dart"), "w", encoding='utf-8') as f:
    f.write(screen_code)

# 2. Modify sidebar_layout.dart
sidebar_path = os.path.join(base_dir, "office", "layouts", "sidebar_layout.dart")
with open(sidebar_path, "r", encoding='utf-8') as f:
    sidebar_content = f.read()

# Replace the Toast message block
toast_block = """
                  if (targetRoute.isNotEmpty) {
                    context.go(targetRoute);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item.label} route initializing...'))
                    );
                  }
"""
new_block = """
                  if (targetRoute.isNotEmpty) {
                    context.go(targetRoute);
                  } else {
                    final formattedId = item.label.toLowerCase().replaceAll(' ', '_');
                    context.go('/provider/feature/$formattedId');
                  }
"""
sidebar_content = sidebar_content.replace(toast_block.strip(), new_block.strip())

with open(sidebar_path, "w", encoding='utf-8') as f:
    f.write(sidebar_content)

# 3. Modify app_router.dart
router_path = os.path.join(base_dir, "routes", "app_router.dart")
with open(router_path, "r", encoding='utf-8') as f:
    router_content = f.read()

# Add import
import_stmt = "import '../components/generic_feature_screen.dart';"
if "generic_feature_screen.dart" not in router_content:
    router_content = router_content.replace("import 'app_routes.dart';", "import 'app_routes.dart';\n" + import_stmt)

# Add route specifically inside the ShellRoute that wraps ProviderLayout
# The block is:
#       ShellRoute(
#         builder: (context, state, child) => MasterLayout(shellType: AppShellType.provider, child: child),
#         routes: [
# Let's insert the Generic feature route right after routes: [
generic_route = """        GoRoute(
          path: '/provider/feature/:id',
          builder: (context, state) => GenericFeatureScreen(featureId: state.pathParameters['id'] ?? 'feature'),
        ),
"""
target_pattern = r"(MasterLayout\(shellType: AppShellType\.provider, child: child\),\s*routes: \[\s*)"
router_content = re.sub(target_pattern, r"\1" + generic_route, router_content)

with open(router_path, "w", encoding='utf-8') as f:
    f.write(router_content)

# 4. We also need to map these fallback endpoint queries to the api_config.dart so the apiClient doesn't throw endpoint not registered!
# The user might click "Clients" -> "clients"
# Wait! In `dynamic_page_providers.dart` I did:
#   final path = ApiConfig.endpoints[endpointKey];
#   if (path == null) throw Exception('Endpoint $endpointKey not found in registry');
# If `endpointKey` is "clients", it will crash there. Let's fix dynamic_page_providers.dart so it has a fallback path for unregistered endpoints!

dyn_prov_path = os.path.join(base_dir, "providers", "dynamic_page_providers.dart")
with open(dyn_prov_path, "r", encoding='utf-8') as f:
    dyn_prov_content = f.read()

dyn_prov_content = dyn_prov_content.replace(
    "final path = ApiConfig.endpoints[endpointKey];\n  if (path == null) throw Exception('Endpoint $endpointKey not found in registry');",
    "final path = ApiConfig.endpoints[endpointKey] ?? '/v1/primecare/office/$endpointKey';"
)

with open(dyn_prov_path, "w", encoding='utf-8') as f:
    f.write(dyn_prov_content)

print("Applied fix for toasts to screen routing.")
