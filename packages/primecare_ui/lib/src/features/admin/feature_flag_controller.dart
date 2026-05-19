import 'package:primecare_ui/primecare_ui.dart';

final featureFlagsProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/feature-flags');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class FeatureFlagControllerScreen extends GovernedConsumerWidget {
  const FeatureFlagControllerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(featureFlagsProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Feature Flag Controller',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(featureFlagsProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load feature flags: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (flags) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Global Application Configuration Flags', style: theme.typography.h2),
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
                        title: Text((flag['name'] as String?) ?? 'Unknown Flag', style: theme.typography.h4),
                        subtitle: Text((flag['description'] as String?) ?? 'No description provided.', style: theme.typography.bodyMedium.copyWith(color: theme.colors.textSecondary)),
                        value: (flag['enabled'] as bool?) ?? false,
                        onChanged: (value) {
                          // TODO: implement API mutation for flag toggling
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
      ),
    );
  }
}
