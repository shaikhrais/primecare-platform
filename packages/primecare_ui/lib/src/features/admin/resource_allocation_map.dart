import 'package:primecare_ui/primecare_ui.dart';

final resourceAllocationProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/resources/allocation');
  return response.data is Map<String, dynamic> ? response.data as Map<String, dynamic> : {};
});

class ResourceAllocationMapScreen extends GovernedConsumerWidget {
  const ResourceAllocationMapScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(resourceAllocationProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Resource Allocation Map',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(resourceAllocationProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load allocations: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (allocations) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Global Resource Distribution', style: theme.typography.h2),
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
                              Icon(Icons.map, size: 64, color: theme.colors.primary.withOpacity(0.5)),
                              const SizedBox(height: 16),
                              Text('Geospatial Mapping Component Placeholder', style: theme.typography.h4),
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
                        child: ListView(
                          padding: const EdgeInsets.all(16),
                          children: [
                            Text('Regions Overview', style: theme.typography.h4),
                            const Divider(),
                            _buildRegionRow(theme, 'North America', 'High', 85),
                            _buildRegionRow(theme, 'Europe', 'Medium', 60),
                            _buildRegionRow(theme, 'Asia Pacific', 'High', 92),
                            _buildRegionRow(theme, 'Latin America', 'Low', 35),
                          ],
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

  Widget _buildRegionRow(PrimeThemeData theme, String region, String utilization, int score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(region, style: theme.typography.bodyLarge),
              Text('Utilization: $utilization', style: theme.typography.labelSmall.copyWith(color: theme.colors.textSecondary)),
            ],
          ),
          CircularProgressIndicator(
            value: score / 100,
            backgroundColor: theme.colors.background,
            color: score > 80 ? theme.colors.error : (score > 50 ? theme.colors.warning : theme.colors.success),
          ),
        ],
      ),
    );
  }
}
