// Governance - Category: service | Purpose: Core implementation file for the Operational Efficiency Metrics platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final operationalEfficiencyProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/analytics/operations/efficiency');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class OperationalEfficiencyMetricsScreen extends GovernedConsumerWidget {
  const OperationalEfficiencyMetricsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(operationalEfficiencyProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Operational Efficiency Metrics',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('operational_efficiency_metrics_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(operationalEfficiencyProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.compare_arrows),
              label: const Text('Compare Periods'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load metrics: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (metrics) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Core Operational KPIs', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: metrics.length,
                  itemBuilder: (context, index) {
                    final metric = metrics[index];
                    final isPositive = (metric['trend'] as num) > 0;
                    return Card(
                      color: theme.colors.surface,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(metric['name'] as String, style: theme.typography.bodyMedium),
                            const SizedBox(height: 8),
                            Text(metric['value'].toString(), style: theme.typography.h2),
                            const Spacer(),
                            Row(
                              children: [
                                Icon(
                                  isPositive ? Icons.trending_up : Icons.trending_down,
                                  color: isPositive ? theme.colors.success : theme.colors.error,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${metric['trend']}% vs Last Month',
                                  style: theme.typography.labelSmall.copyWith(
                                    color: isPositive ? theme.colors.success : theme.colors.error,
                                  ),
                                ),
                              ],
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
