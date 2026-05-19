import 'package:primecare_ui/primecare_ui.dart';

final patientRetentionProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/analytics/patients/retention');
  return response.data as Map<String, dynamic>;
});

class PatientRetentionAnalyticsScreen extends GovernedConsumerWidget {
  const PatientRetentionAnalyticsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(patientRetentionProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Patient Retention Analytics',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(patientRetentionProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load retention analytics: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (data) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Churn Prediction & Lifetime Value (LTV)', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Card(
                        color: theme.colors.surface,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Overall Retention Rate', style: theme.typography.h3),
                              const SizedBox(height: 16),
                              Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      height: 150,
                                      child: CircularProgressIndicator(
                                        value: (data['retentionRate'] as num) / 100.0,
                                        strokeWidth: 12,
                                        backgroundColor: theme.colors.border,
                                        valueColor: AlwaysStoppedAnimation<Color>(theme.colors.primary),
                                      ),
                                    ),
                                    Text('${data['retentionRate']}%', style: theme.typography.h1),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32),
                              Text('Avg LTV: \$${data['averageLTV']}', style: theme.typography.h4),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
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
                              Icon(Icons.timeline, size: 64, color: theme.colors.primary.withOpacity(0.5)),
                              const SizedBox(height: 16),
                              Text('Cohort Analysis Matrix Placeholder', style: theme.typography.h4),
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
