import 'package:primecare_ui/primecare_ui.dart';

final territorySalesProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/marketing/territories');
  return response.data as Map<String, dynamic>;
});

class TerritorySalesMappingScreen extends GovernedConsumerWidget {
  const TerritorySalesMappingScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(territorySalesProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text('Territory Sales Mapping', style: theme.typography.h3),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(territorySalesProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: theme.colors.error))),
        data: (territories) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map, size: 100, color: Colors.blue[300]),
                        const SizedBox(height: 16),
                        Text('Interactive Map Placeholder', style: theme.typography.h3),
                        Text('Displays heatmaps of leads and conversions by region', style: theme.typography.bodyMedium),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Top Performing Regions', style: theme.typography.h2),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: (territories['regions'] as List).length,
                        itemBuilder: (context, index) {
                          final region = territories['regions'][index];
                          return Card(
                            color: theme.colors.surface,
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: theme.colors.primary,
                                child: Text('${index + 1}', style: const TextStyle(color: Colors.white)),
                              ),
                              title: Text(region['name'] as String, style: theme.typography.h4),
                              subtitle: Text('Manager: ${region['manager']}', style: theme.typography.labelSmall),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('\$${region['revenue']}', style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: Colors.green)),
                                  Text('Quota: ${region['quota_attainment']}%', style: theme.typography.labelSmall),
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
            ],
          ),
        ),
      ),
    );
  }
}
