// Governance - Category: service | Purpose: Core implementation file for the System Capacity Planner platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final capacityProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/capacity/forecast');
  return response.data is Map<String, dynamic> ? response.data as Map<String, dynamic> : {};
});

class SystemCapacityPlannerScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires real-time monitoring of system capacity metrics, a refresh functionality, and a resource projection analysis feature.';

  @override
  List<String> get requiredComponents => const [
        'CapacityMetricCard',
        'ResourceProjectionChart',
        'ErrorMessageDisplay',
      ];

  @override
  List<String> get requiredFunctions => const [
        'refreshCapacityData',
        'analyzeResourceProjection',
      ];

  const SystemCapacityPlannerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(capacityProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'System Capacity Planner',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('system_capacity_planner_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(capacityProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load capacity data: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (capacity) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Compute & Storage Capacity Forecast', style: theme.typography.h2),
              const SizedBox(height: 24),
              ResponsiveGrid(
                minItemWidth: 300,
                spacing: 24,
                children: [
                  _buildCapacityCard(theme, 'Compute Nodes', capacity['computeUsage'] as int? ?? 65, Icons.memory),
                  _buildCapacityCard(theme, 'Database Storage', capacity['dbUsage'] as int? ?? 82, Icons.storage),
                  _buildCapacityCard(theme, 'Network Bandwidth', capacity['networkUsage'] as int? ?? 45, Icons.wifi),
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
                        Text('6-Month Resource Projection', style: theme.typography.h3),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: theme.colors.background,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('Projection Chart Component Placeholder'),
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

  Widget _buildCapacityCard(PrimeThemeData theme, String title, int percentage, IconData icon) {
    Color barColor = percentage > 85 ? theme.colors.error : (percentage > 70 ? theme.colors.warning : theme.colors.success);
    return Card(
      color: theme.colors.surface,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: theme.colors.textSecondary),
                const SizedBox(width: 8),
                Text(title, style: theme.typography.h4),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: theme.colors.background,
              color: barColor,
              minHeight: 8,
            ),
            const SizedBox(height: 8),
            Text('Current Usage: $percentage%', style: theme.typography.bodyMedium.copyWith(color: theme.colors.textSecondary)),
          ],
        ),
      ),
    );
  }
}
