import 'package:primecare_ui/primecare_ui.dart';

final apiKeysProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/api-keys');
  return response.data is List 
      ? List<Map<String, dynamic>>.from(response.data as Iterable) 
      : [];
});

class ApiKeyManagerScreen extends GovernedConsumerWidget {
  const ApiKeyManagerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final dataState = ref.watch(apiKeysProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          'API Key Manager',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: theme.colors.primary),
            onPressed: () {
              // Action to generate new key
            },
            tooltip: 'Generate New Key',
          ),
        ],
      ),
      body: dataState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load API keys: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (apiKeys) => SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'API Key Administration',
                style: theme.typography.h2.copyWith(color: theme.colors.onBackground),
              ),
              const SizedBox(height: 8),
              Text(
                'Generate, rotate, and revoke API keys for external services integration.',
                style: theme.typography.bodyLarge.copyWith(color: theme.colors.textSecondary),
              ),
              const SizedBox(height: 24),
              ResponsiveGrid(
                minItemWidth: 400,
                maxItemWidth: 800,
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
                          Text('Active API Keys', style: theme.typography.h4),
                          const SizedBox(height: 16),
                          if (apiKeys.isEmpty)
                            const Text('No API keys generated yet.')
                          else
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: apiKeys.length,
                              itemBuilder: (context, index) {
                                final keyItem = apiKeys[index];
                                return ListTile(
                                  leading: Icon(Icons.vpn_key, color: theme.colors.primary),
                                  title: Text((keyItem['name'] as String?) ?? 'Unnamed Key', style: theme.typography.bodyLarge),
                                  subtitle: Text('Prefix: ${keyItem['prefix'] ?? '***'} • Created: ${keyItem['createdAt'] ?? 'N/A'}', style: theme.typography.bodyMedium),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.autorenew),
                                        tooltip: 'Rotate Key',
                                        onPressed: () {},
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: theme.colors.error),
                                        tooltip: 'Revoke Key',
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
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
                          Text('API Usage & Access Logs', style: theme.typography.h4),
                          const SizedBox(height: 16),
                          Container(
                            height: 250,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: theme.colors.background,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('Usage Graph Component Placeholder'),
                          ),
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
