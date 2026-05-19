import 'package:primecare_ui/primecare_ui.dart';

final systemRegistryProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/registry');
  return response.data is Map<String, dynamic> 
      ? response.data as Map<String, dynamic>
      : {};
});

class SystemRegistryDashboard extends GovernedConsumerWidget {
  const SystemRegistryDashboard({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final dataState = ref.watch(systemRegistryProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          'System Registry & Health',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () {
              ref.invalidate(systemRegistryProvider);
            },
          ),
        ],
      ),
      body: dataState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load system registry: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (registryData) => SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'System Registry Dashboard',
                style: theme.typography.h2.copyWith(color: theme.colors.onBackground),
              ),
              const SizedBox(height: 8),
              Text(
                'Live view of all registered screens and middleware states.',
                style: theme.typography.bodyLarge.copyWith(color: theme.colors.textSecondary),
              ),
              const SizedBox(height: 24),
              ResponsiveGrid(
                minItemWidth: 400,
                maxItemWidth: 600,
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
                          Text('Service Health Indicator', style: theme.typography.h4),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: Icon(Icons.check_circle, color: theme.colors.success),
                            title: Text('API Gateway', style: theme.typography.bodyLarge),
                            subtitle: Text('Online - 99.9% Uptime', style: theme.typography.bodyMedium),
                          ),
                          ListTile(
                            leading: Icon(Icons.check_circle, color: theme.colors.success),
                            title: Text('Auth Service', style: theme.typography.bodyLarge),
                            subtitle: Text('Online', style: theme.typography.bodyMedium),
                          ),
                          ListTile(
                            leading: Icon(Icons.warning, color: theme.colors.warning),
                            title: Text('Data Sync Middleware', style: theme.typography.bodyLarge),
                            subtitle: Text('Degraded - Sync delayed', style: theme.typography.bodyMedium),
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
                          Text('Registry Tree', style: theme.typography.h4),
                          const SizedBox(height: 16),
                          if (registryData.isEmpty)
                            const Text('Registry data is currently unavailable.')
                          else
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: (registryData['screens'] as List?)?.length ?? 0,
                              itemBuilder: (context, index) {
                                final screen = (registryData['screens'] as List)[index];
                                return ListTile(
                                  leading: Icon(Icons.monitor, color: theme.colors.primary),
                                  title: Text(screen['name'] as String? ?? 'Unknown Screen', style: theme.typography.bodyLarge),
                                  subtitle: Text(screen['route'] as String? ?? 'No Route', style: theme.typography.bodyMedium),
                                  trailing: Chip(
                                    label: Text(screen['status'] as String? ?? 'Active', style: TextStyle(fontSize: 10, color: theme.colors.onPrimary)),
                                    backgroundColor: theme.colors.primary,
                                  ),
                                );
                              },
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
