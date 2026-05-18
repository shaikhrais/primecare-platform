import 'package:primecare_ui/primecare_ui.dart';

final premiumFeature69Provider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/premium/invoice');
  return response.data is Map ? Map<String, dynamic>.from(response.data) : {};
});

class PremiumFeature69 extends GovernedConsumerWidget {
  const PremiumFeature69({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final dataState = ref.watch(premiumFeature69Provider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          'Premium Feature 69 - Invoice',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
      ),
      body: dataState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error', style: TextStyle(color: theme.colors.error))),
        data: (data) => SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Invoice Dashboard',
                style: theme.typography.h2.copyWith(color: theme.colors.onBackground),
              ),
              const SizedBox(height: 24),
              ResponsiveGrid(
                minItemWidth: 320,
                maxItemWidth: 450,
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
                          Text('API Integration', style: theme.typography.h4),
                          const SizedBox(height: 8),
                          Text(data.isEmpty ? 'No data returned from API.' : data.toString()),
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
                          Text('Governance Status', style: theme.typography.h4),
                          const SizedBox(height: 8),
                          const Text('Data flows through ApiClient with persistent caching enabled.'),
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
