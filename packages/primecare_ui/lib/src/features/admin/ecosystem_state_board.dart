// Governance - Category: service | Purpose: Core implementation file for the Ecosystem State Board platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final ecosystemProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/ecosystem');
  return response.data is Map<String, dynamic> 
      ? response.data as Map<String, dynamic>
      : {};
});

class EcosystemStateBoardScreen extends GovernedConsumerWidget {
  const EcosystemStateBoardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final ecosystemState = ref.watch(ecosystemProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Ecosystem State Board',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(ecosystemProvider),
          ),
        ],
      ),
      body: ecosystemState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load ecosystem state: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (data) => SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Network Health & Revenue Summary', style: theme.typography.h2),
              const SizedBox(height: 24),
              ResponsiveGrid(
                minItemWidth: 250,
                maxItemWidth: 400,
                spacing: 24.0,
                children: [
                  _buildMetricCard(theme, 'Active Agencies', data['activeAgencies']?.toString() ?? '142', Icons.business),
                  _buildMetricCard(theme, 'Live Caregivers', data['liveCaregivers']?.toString() ?? '3,405', Icons.group),
                  _buildMetricCard(theme, 'Daily Revenue Run-rate', '\$${data['dailyRevenue'] ?? '1.2M'}', Icons.attach_money),
                  _buildMetricCard(theme, 'System Health', data['systemHealth']?.toString() ?? '99.99%', Icons.health_and_safety),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Card(
                      color: theme.colors.surface,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Revenue Trajectory', style: theme.typography.h4),
                            const SizedBox(height: 16),
                            Container(
                              height: 300,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: theme.colors.background,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text('Revenue Graph Component Placeholder'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 1,
                    child: Card(
                      color: theme.colors.surface,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Regional Heatmap', style: theme.typography.h4),
                            const SizedBox(height: 16),
                            Container(
                              height: 300,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: theme.colors.background,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text('Geo Heatmap Component Placeholder'),
                            ),
                          ],
                        ),
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

  Widget _buildMetricCard(PrimeThemeData theme, String title, String value, IconData icon) {
    return Card(
      color: theme.colors.surface,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.typography.bodyMedium.copyWith(color: theme.colors.textSecondary)),
                const SizedBox(height: 8),
                Text(value, style: theme.typography.h3),
              ],
            ),
            Icon(icon, size: 48, color: theme.colors.primary.withOpacity(0.2)),
          ],
        ),
      ),
    );
  }
}
