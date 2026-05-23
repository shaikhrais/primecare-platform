// Governance - Category: view | Purpose: UI Screen component rendering the Predictive Analytics Dashboard workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

final predictiveAnalyticsProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/analytics/predictive/forecast');
  return response.data as Map<String, dynamic>;
});

class PredictiveAnalyticsDashboardScreen extends GovernedConsumerWidget {
  const PredictiveAnalyticsDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(predictiveAnalyticsProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Predictive Analytics Dashboard',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(predictiveAnalyticsProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.auto_graph),
              label: const Text('Run New Model'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load predictive models: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (data) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Patient Volume & Risk Forecasts', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.colors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: theme.colors.border),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.query_stats, size: 64, color: theme.colors.primary.withOpacity(0.5)),
                              const SizedBox(height: 16),
                              Text('Advanced Prediction Model Chart Placeholder', style: theme.typography.h4),
                              const SizedBox(height: 8),
                              Text('Model Accuracy: ${(data['accuracy'] * 100).toStringAsFixed(1)}%', style: theme.typography.bodyMedium),
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
                        child: ListView.builder(
                          itemCount: (data['riskFactors'] as List).length,
                          itemBuilder: (context, index) {
                            final factor = data['riskFactors'][index];
                            return ListTile(
                              leading: Icon(Icons.warning, color: theme.colors.warning),
                              title: Text(factor['name'] as String, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                              subtitle: Text('Impact Score: ${factor['impact']}'),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
