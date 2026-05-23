// Governance - Category: config | Purpose: UI Screen component rendering the Tenant Configuration Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

final tenantConfigurationProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/tenants');
  return response.data is Map
      ? Map<String, dynamic>.from(response.data as Map) 
      : {'tenants': <dynamic>[]};
});

class TenantConfigurationScreen extends GovernedConsumerWidget {
  const TenantConfigurationScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final dataState = ref.watch(tenantConfigurationProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          'Tenant Configuration',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
      ),
      body: dataState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load tenants: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (data) {
          final tenants = data['tenants'] as List? ?? [];
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Global Tenant Management',
                  style: theme.typography.h2.copyWith(color: theme.colors.onBackground),
                ),
                const SizedBox(height: 8),
                Text(
                  'Manage sub-organizations, branding, and billing states.',
                  style: theme.typography.bodyLarge.copyWith(color: theme.colors.textSecondary),
                ),
                const SizedBox(height: 24),
                ResponsiveGrid(
                  minItemWidth: 350,
                  maxItemWidth: 500,
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
                            Text('Active Tenants', style: theme.typography.h4),
                            const SizedBox(height: 16),
                            if (tenants.isEmpty)
                              const Text('No tenants configured.')
                            else
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: tenants.length,
                                itemBuilder: (context, index) {
                                  final tenant = tenants[index];
                                  return ListTile(
                                    leading: const Icon(Icons.business),
                                    title: Text(tenant['name'] as String? ?? 'Unknown', style: theme.typography.bodyLarge),
                                    subtitle: Text('Status: ${tenant['status'] ?? 'Unknown'}', style: theme.typography.bodyMedium),
                                    trailing: const Icon(Icons.chevron_right),
                                  );
                                },
                              ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.add),
                              label: const Text('Add Tenant'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colors.primary,
                                foregroundColor: theme.colors.onPrimary,
                              ),
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
                            Text('Billing Status', style: theme.typography.h4),
                            const SizedBox(height: 16),
                            const ListTile(
                              leading: Icon(Icons.payment, color: Colors.green),
                              title: Text('All accounts in good standing'),
                            ),
                            const SizedBox(height: 16),
                            OutlinedButton(
                              onPressed: () {},
                              child: const Text('View Financial Hub'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
