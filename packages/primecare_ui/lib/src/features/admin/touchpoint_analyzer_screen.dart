import 'package:primecare_ui/primecare_ui.dart';

final touchpointProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/marketing/touchpoints');
  return response.data is Map<String, dynamic> 
      ? response.data as Map<String, dynamic>
      : {};
});

class TouchpointAnalyzerScreen extends GovernedConsumerWidget {
  const TouchpointAnalyzerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final touchpointState = ref.watch(touchpointProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Touchpoint & Conversion Analyzer',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(touchpointProvider),
          ),
        ],
      ),
      body: touchpointState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load touchpoint data: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (data) => SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Marketing & Acquisition Funnel', style: theme.typography.h2),
              const SizedBox(height: 24),
              ResponsiveGrid(
                minItemWidth: 300,
                maxItemWidth: 600,
                spacing: 24.0,
                children: [
                  Card(
                    color: theme.colors.surface,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Conversion Funnel', style: theme.typography.h4),
                          const SizedBox(height: 16),
                          Container(
                            height: 250,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: theme.colors.background,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('Funnel Graph Visualization'),
                          ),
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
                          Text('Active Campaigns', style: theme.typography.h4),
                          const SizedBox(height: 16),
                          if (data['campaigns'] == null || (data['campaigns'] as List).isEmpty)
                            const Text('No active campaigns.')
                          else
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: (data['campaigns'] as List).length,
                              itemBuilder: (context, index) {
                                final campaign = (data['campaigns'] as List)[index];
                                return ListTile(
                                  leading: const Icon(Icons.campaign),
                                  title: Text(campaign['name'] as String? ?? 'Campaign'),
                                  subtitle: Text('Conversion: ${campaign['conversionRate'] ?? 0}%'),
                                  trailing: TextButton(onPressed: () {}, child: const Text('A/B Details')),
                                );
                              },
                            ),
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
