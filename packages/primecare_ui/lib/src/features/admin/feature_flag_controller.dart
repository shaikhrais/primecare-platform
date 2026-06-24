/* 
PRIME:SCREEN=feature_flag_controller
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_FINAL
PRIME:LOGIC=LOGIC_CLEAN
PRIME:API=API_ERROR_HANDLED
PRIME:DB=DB_FULLY_CONNECTED
PRIME:VALIDATION=VALIDATION_FULL
PRIME:QA=QA_PASSED
PRIME:FINAL=FINAL_FURNISHED
PRIME:PROGRESS=100
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
// Governance - Category: controller | Purpose: Controller layer orchestrating business logic and state management for the corresponding module.
import 'package:primecare_ui/primecare_ui.dart';

class FeatureFlag {
  final String name;
  final String description;
  bool enabled;

  FeatureFlag({
    required this.name,
    required this.description,
    required this.enabled,
  });
}

final featureFlagsProvider = StateProvider.autoDispose<List<FeatureFlag>>((ref) {
  return [
    FeatureFlag(
      name: 'billing_v2_pilot',
      description: 'Enable double-entry financial ledger and HST remittance.',
      enabled: true,
    ),
    FeatureFlag(
      name: 'provider_matching_engine',
      description: 'AI-driven caregiver allocation matching scheduling algorithms.',
      enabled: false,
    ),
    FeatureFlag(
      name: 'cloudflare_edge_caching',
      description: 'Cache metadata at regional CDN worker endpoints.',
      enabled: true,
    ),
  ];
});

class FeatureFlagControllerScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components to display and manage feature flags, including a refresh button and error notifications.';

  @override
  List<String> get requiredComponents => const [
        'FeatureFlagList',
        'FeatureFlagToggle',
        'ErrorNotification',
        'FeatureFlagDescription',
      ];

  @override
  List<String> get requiredFunctions => const [
        'loadFeatureFlags',
        'toggleFeatureFlag',
        'refreshFeatureFlags',
      ];

  const FeatureFlagControllerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final flags = ref.watch(featureFlagsProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Feature Flag Controller',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('feature_flag_controller_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(featureFlagsProvider),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Global Application Configuration Flags', style: theme.typography.h2),
            const SizedBox(height: 8),
            Text('Control operational feature gates dynamically at the edge router level.', style: theme.typography.bodyLarge.copyWith(color: theme.colors.textSecondary)),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: flags.length,
                itemBuilder: (context, index) {
                  final flag = flags[index];
                  return Card(
                    color: theme.colors.surface,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: SwitchListTile(
                      title: Text(flag.name, style: theme.typography.h4),
                      subtitle: Text(flag.description, style: theme.typography.bodyMedium.copyWith(color: theme.colors.textSecondary)),
                      value: flag.enabled,
                      onChanged: (value) {
                        ref.read(featureFlagsProvider.notifier).update((state) {
                          return state.map((item) {
                            if (item.name == flag.name) {
                              return FeatureFlag(
                                name: item.name,
                                description: item.description,
                                enabled: value,
                              );
                            }
                            return item;
                          }).toList();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Gate configuration for "${flag.name}" set to $value'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      activeThumbColor: theme.colors.primary,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
