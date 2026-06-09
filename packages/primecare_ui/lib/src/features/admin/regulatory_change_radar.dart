// Governance - Category: service | Purpose: Core implementation file for the Regulatory Change Radar platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final regulatoryChangesProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/compliance/regulatory-radar');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class RegulatoryChangeRadarScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components to display regulatory changes, handle data loading and errors, and allow user interaction for data refresh and detail viewing.';

  @override
  List<String> get requiredComponents => const [
        'LoadingIndicator',
        'ErrorMessage',
        'RegulatoryChangeList',
        'InteractiveTimeline',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchRegulatoryData',
        'handleError',
        'refreshData',
        'viewRegulatoryChangeDetails',
      ];

  const RegulatoryChangeRadarScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(regulatoryChangesProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Regulatory Change Radar',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('regulatory_change_radar_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(regulatoryChangesProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load regulatory data: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (changes) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Upcoming Legislative Impacts', style: theme.typography.h2),
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
                              Icon(Icons.radar, size: 64, color: theme.colors.primary.withOpacity(0.5)),
                              const SizedBox(height: 16),
                              Text('Interactive Timeline Component Placeholder', style: theme.typography.h4),
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
                          itemCount: changes.length,
                          itemBuilder: (context, index) {
                            final change = changes[index];
                            return ListTile(
                              leading: const Icon(Icons.article),
                              title: Text(change['title'] as String? ?? 'Unknown Regulation', style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                              subtitle: Text('Effective: ${change['effectiveDate']}'),
                              onTap: () {},
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
