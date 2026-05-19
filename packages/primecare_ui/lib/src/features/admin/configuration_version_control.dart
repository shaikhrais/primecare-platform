import 'package:primecare_ui/primecare_ui.dart';

final configVersionsProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/configs/versions');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class ConfigurationVersionControlScreen extends GovernedConsumerWidget {
  const ConfigurationVersionControlScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(configVersionsProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Configuration Version Control',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(configVersionsProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load configuration history: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (versions) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Global Configuration Changelog', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: versions.length,
                  itemBuilder: (context, index) {
                    final version = versions[index];
                    return Card(
                      color: theme.colors.surface,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        leading: const Icon(Icons.history_edu),
                        title: Text('Version ${version['version']} - ${version['timestamp']}', style: theme.typography.h4),
                        subtitle: Text('Changed by: ${version['author']} | Modules: ${(version['modules'] as List).join(', ')}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            OutlinedButton(
                              onPressed: () {},
                              child: const Text('View Diff'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(backgroundColor: theme.colors.error),
                              child: const Text('Rollback'),
                            ),
                          ],
                        ),
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
