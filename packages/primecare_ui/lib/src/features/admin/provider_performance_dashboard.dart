import 'package:primecare_ui/primecare_ui.dart';

final providerPerformanceProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/providers/performance');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class ProviderPerformanceDashboardScreen extends GovernedConsumerWidget {
  const ProviderPerformanceDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final perfState = ref.watch(providerPerformanceProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Provider Performance Dashboard',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(providerPerformanceProvider),
          ),
        ],
      ),
      body: perfState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load performance metrics: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (providers) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Network Provider Health', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: providers.length,
                  itemBuilder: (context, index) {
                    final provider = providers[index];
                    return Card(
                      color: theme.colors.surface,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: theme.colors.primary.withOpacity(0.1),
                              child: Icon(Icons.medical_services, color: theme.colors.primary),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text((provider['name'] as String?) ?? 'Unknown Provider', style: theme.typography.h4),
                                  Text('ID: ${provider['id'] ?? 'N/A'} | Region: ${provider['region'] ?? 'Global'}', style: theme.typography.bodyMedium.copyWith(color: theme.colors.textSecondary)),
                                ],
                              ),
                            ),
                            _buildStatBadge(theme, 'Patient Sat', provider['satisfactionScore']?.toString() ?? '92%'),
                            const SizedBox(width: 16),
                            _buildStatBadge(theme, 'Response Time', provider['avgResponseTime']?.toString() ?? '1.2h'),
                            const SizedBox(width: 16),
                            _buildStatBadge(theme, 'Completion', provider['completionRate']?.toString() ?? '98%'),
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

  Widget _buildStatBadge(PrimeThemeData theme, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colors.border),
      ),
      child: Column(
        children: [
          Text(label, style: theme.typography.labelSmall.copyWith(color: theme.colors.textSecondary)),
          const SizedBox(height: 4),
          Text(value, style: theme.typography.h4),
        ],
      ),
    );
  }
}
