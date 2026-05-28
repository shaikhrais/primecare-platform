// Governance - Category: service | Purpose: Core implementation file for the Population Health Analyzer platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final populationHealthProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/analytics/clinical/population-health');
  return response.data as Map<String, dynamic>;
});

class PopulationHealthAnalyzerScreen extends GovernedConsumerWidget {
  const PopulationHealthAnalyzerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(populationHealthProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Population Health Analyzer',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('population_health_analyzer_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(populationHealthProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.group),
              label: const Text('Export Cohort Data'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load population data: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (data) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Demographics & Risk Stratification', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Card(
                        color: theme.colors.surface,
                        child: ListView.builder(
                          itemCount: (data['cohorts'] as List).length,
                          itemBuilder: (context, index) {
                            final cohort = data['cohorts'][index];
                            return ListTile(
                              leading: const Icon(Icons.pie_chart),
                              title: Text(cohort['name'] as String, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                              subtitle: Text('Population Size: ${cohort['size']}'),
                              trailing: Chip(
                                label: Text('Risk: ${cohort['riskLevel']}'),
                                backgroundColor: cohort['riskLevel'] == 'High' ? theme.colors.error.withOpacity(0.2) : theme.colors.primary.withOpacity(0.2),
                              ),
                            );
                          },
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
                              Icon(Icons.map, size: 64, color: theme.colors.primary.withOpacity(0.5)),
                              const SizedBox(height: 16),
                              Text('Geospatial Heatmap Placeholder', style: theme.typography.h4),
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
