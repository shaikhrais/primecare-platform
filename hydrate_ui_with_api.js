const fs = require('fs');
const path = require('path');

const UI_DIR = path.join(__dirname, 'packages', 'primecare_ui', 'lib', 'src', 'features', 'generated_screens');
const REGISTRY_FILE = path.join(__dirname, 'packages', 'primecare_ui', 'lib', 'src', 'registry', 'screen_registry.dart');
const MODELS_FILE = path.join(__dirname, 'models.json'); // We generated this earlier

// Ensure directory exists
if (!fs.existsSync(UI_DIR)) {
  fs.mkdirSync(UI_DIR, { recursive: true });
}

let models = [];
if (fs.existsSync(MODELS_FILE)) {
  models = JSON.parse(fs.readFileSync(MODELS_FILE, 'utf8'));
}

let registryContent = fs.readFileSync(REGISTRY_FILE, 'utf8');

// Strip old premium_feature imports
registryContent = registryContent.replace(/import '\.\.\/screens\/premium\/premium_feature_\d+\/premium_feature_\d+_view\.dart';\n/g, '');
// Strip old generated_screens imports
registryContent = registryContent.replace(/import '\.\.\/features\/generated_screens\/premium_feature_\d+\.dart';\r?\n/g, '');

let importsToAdd = [];
let registryEntriesToUpdate = [];

for (let i = 1; i <= 251; i++) {
  const modelName = models[i - 1] || 'Model' + i;
  const endpointPath = '/v1/premium/' + modelName.toLowerCase();
  
  const fileContent = `import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';

final premiumFeature${i}Provider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('${endpointPath}');
  return response.data is Map ? Map<String, dynamic>.from(response.data) : {};
});

class PremiumFeature${i} extends GovernedConsumerWidget {
  const PremiumFeature${i}({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final dataState = ref.watch(premiumFeature${i}Provider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          'Premium Feature ${i} - ${modelName}',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
      ),
      body: dataState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error', style: TextStyle(color: theme.colors.error))),
        data: (data) => SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${modelName} Dashboard',
                style: theme.typography.h2.copyWith(color: theme.colors.onBackground),
              ),
              const SizedBox(height: 24),
              ResponsiveGrid(
                minItemWidth: 320,
                maxItemWidth: 450,
                spacing: 16.0,
                children: [
                  Card(
                    color: theme.colors.surface,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('API Integration', style: theme.typography.h4),
                          const SizedBox(height: 8),
                          Text(data.isEmpty ? 'No data returned from API.' : data.toString()),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: theme.colors.surface,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Governance Status', style: theme.typography.h4),
                          const SizedBox(height: 8),
                          const Text('Data flows through ApiClient with persistent caching enabled.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
`;

  fs.writeFileSync(path.join(UI_DIR, 'premium_feature_' + i + '.dart'), fileContent);
  importsToAdd.push("import '../features/generated_screens/premium_feature_" + i + ".dart';");
}

// Ensure the imports are at the top of the screen registry
const importString = importsToAdd.join('\\n') + '\\n';

// Replace existing SCREEN_PREMIUM_FEATURE_ mappings
for (let i = 1; i <= 251; i++) {
  const regex = new RegExp("'SCREEN_PREMIUM_FEATURE_" + i + "':.*?,", "g");
  registryContent = registryContent.replace(regex, "'SCREEN_PREMIUM_FEATURE_" + i + "': const PremiumFeature" + i + "(),");
}

registryContent = importString + registryContent;

fs.writeFileSync(REGISTRY_FILE, registryContent);

console.log('Successfully hydrated 251 screens with ApiClient and updated screen_registry.dart');
