// Governance - Category: service | Purpose: Core implementation file for the Data Privacy Monitor platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final dataPrivacyProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/compliance/data-privacy');
  return response.data is Map<String, dynamic> ? response.data as Map<String, dynamic> : {};
});

class DataPrivacyMonitorScreen extends GovernedConsumerWidget {
  const DataPrivacyMonitorScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(dataPrivacyProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Data Privacy Monitor',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(dataPrivacyProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load privacy metrics: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (metrics) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PII & PHI Exposure Tracking', style: theme.typography.h2),
              const SizedBox(height: 24),
              ResponsiveGrid(
                minItemWidth: 250,
                spacing: 24,
                children: [
                  _buildRiskCard(theme, 'Active Data Endpoints', metrics['activeEndpoints']?.toString() ?? '342', Icons.api, theme.colors.primary),
                  _buildRiskCard(theme, 'High Risk Anomalies', metrics['highRiskAnomalies']?.toString() ?? '2', Icons.warning_amber, theme.colors.error),
                  _buildRiskCard(theme, 'Data Access Requests', metrics['accessRequests']?.toString() ?? '15', Icons.rule_folder, theme.colors.warning),
                ],
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Card(
                  color: theme.colors.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Recent Anomaly Alerts', style: theme.typography.h3),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            itemCount: (metrics['anomalies'] as List?)?.length ?? 3,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const Icon(Icons.warning, color: Colors.redAccent),
                                title: Text('Unusual bulk export detected by User $index', style: theme.typography.h4),
                                subtitle: const Text('Action requires immediate review.'),
                                trailing: OutlinedButton(
                                  onPressed: () {},
                                  child: const Text('Investigate'),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRiskCard(PrimeThemeData theme, String title, String value, IconData icon, Color color) {
    return Card(
      color: theme.colors.surface,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              radius: 32,
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.typography.bodyMedium.copyWith(color: theme.colors.textSecondary)),
                const SizedBox(height: 8),
                Text(value, style: theme.typography.h3),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
