import 'package:primecare_ui/primecare_ui.dart';

final campaignPerformanceProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/marketing/campaigns/performance');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class CampaignPerformanceDashboardScreen extends GovernedConsumerWidget {
  const CampaignPerformanceDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(campaignPerformanceProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Campaign Performance Dashboard',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(campaignPerformanceProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.campaign),
              label: const Text('Create Campaign'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load campaigns: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (campaigns) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Active Marketing Campaigns', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: campaigns.length,
                  itemBuilder: (context, index) {
                    final campaign = campaigns[index];
                    return Card(
                      color: theme.colors.surface,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(campaign['name'] as String, style: theme.typography.h4),
                                const SizedBox(height: 4),
                                Text('Platform: ${campaign['platform']} | Status: ${campaign['status']}', style: theme.typography.bodyMedium),
                              ],
                            ),
                            Row(
                              children: [
                                _StatColumn('Spend', '\$${campaign['spend']}', theme),
                                const SizedBox(width: 24),
                                _StatColumn('Clicks', '${campaign['clicks']}', theme),
                                const SizedBox(width: 24),
                                _StatColumn('Conversions', '${campaign['conversions']}', theme),
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

  Widget _StatColumn(String label, String value, PrimeThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label, style: theme.typography.labelSmall),
        Text(value, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
