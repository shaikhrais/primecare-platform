import 'package:primecare_ui/primecare_ui.dart';

final staffUtilizationProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/analytics/hr/utilization');
  return response.data as Map<String, dynamic>;
});

class StaffUtilizationHeatmapScreen extends GovernedConsumerWidget {
  const StaffUtilizationHeatmapScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(staffUtilizationProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Staff Utilization Heatmap',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(staffUtilizationProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.schedule),
              label: const Text('Adjust Shifts'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load utilization data: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (data) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Resource Allocation & Burnout Indicators', style: theme.typography.h2),
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
                              Icon(Icons.grid_on, size: 64, color: theme.colors.primary.withOpacity(0.5)),
                              const SizedBox(height: 16),
                              Text('24/7 Heatmap Grid Placeholder', style: theme.typography.h4),
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
                          itemCount: (data['highRiskDepartments'] as List).length,
                          itemBuilder: (context, index) {
                            final dept = data['highRiskDepartments'][index];
                            return ListTile(
                              leading: Icon(Icons.local_fire_department, color: theme.colors.error),
                              title: Text(dept['name'] as String, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                              subtitle: Text('Utilization: ${dept['utilization']}%'),
                              trailing: Chip(
                                label: const Text('High Risk'),
                                backgroundColor: theme.colors.error.withOpacity(0.2),
                              ),
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
