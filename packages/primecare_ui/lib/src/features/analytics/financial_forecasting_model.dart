// Governance - Category: model | Purpose: Enterprise data transfer object (DTO) schema contract ensuring payload validity.
import 'package:primecare_ui/primecare_ui.dart';

final financialForecastProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/analytics/finance/forecast');
  return response.data as Map<String, dynamic>;
});

class FinancialForecastingModelScreen extends GovernedConsumerWidget {
  const FinancialForecastingModelScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(financialForecastProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Financial Forecasting Model',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('financial_forecasting_model_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(financialForecastProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.settings),
              label: const Text('Adjust Parameters'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load forecast data: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (data) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Quarterly Revenue Projections', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
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
                              Icon(Icons.monetization_on, size: 64, color: theme.colors.success.withOpacity(0.5)),
                              const SizedBox(height: 16),
                              Text('Advanced Financial Line Chart Placeholder', style: theme.typography.h4),
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
                              Text('Key Drivers', style: theme.typography.h3),
                              const Divider(),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: (data['drivers'] as List).length,
                                  itemBuilder: (context, index) {
                                    final driver = data['drivers'][index];
                                    final isPositive = (driver['trend'] as num) > 0;
                                    return ListTile(
                                      title: Text(driver['name'] as String, style: theme.typography.bodyMedium),
                                      trailing: Icon(
                                        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                                        color: isPositive ? theme.colors.success : theme.colors.error,
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
            ],
          ),
        ),
      ),
    );
  }
}
