// Governance - Category: service | Purpose: Core implementation file for the Residency Program Tracker platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final residencyProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/education/residency/residents');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class ResidencyProgramTrackerScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components to display and manage resident data, including a list view, detailed milestone tracking, and alerts for residents falling behind.';

  @override
  List<String> get requiredComponents => const [
        'ResidentList',
        'ResidentCard',
        'CompletionPercentageIndicator',
        'MilestoneTracker',
        'AlertsDashboard',
        'SearchFilter',
        'ProgressTrendChart',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchResidentData',
        'expandResidentCard',
        'monitorCompletionPercentage',
        'filterResidents',
        'viewProgressHistory',
      ];

  const ResidencyProgramTrackerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(residencyProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text('Residency Program Tracker', style: theme.typography.h3),
        actions: [
          IconButton(key: const Key('residency_program_tracker_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(residencyProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: theme.colors.error))),
        data: (residents) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Resident Cohort Overview', style: theme.typography.h2),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: residents.length,
                  itemBuilder: (context, index) {
                    final resident = residents[index];
                    return Card(
                      color: theme.colors.surface,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ExpansionTile(
                        leading: CircleAvatar(
                          backgroundColor: theme.colors.primary,
                          child: Text(resident['initials'] as String, style: const TextStyle(color: Colors.white)),
                        ),
                        title: Text(resident['name'] as String, style: theme.typography.h4),
                        subtitle: Text('PGY-${resident['pgy_level']} | ${resident['specialty']}', style: theme.typography.bodyMedium),
                        trailing: CircularProgressIndicator(
                          value: (resident['completion_percentage'] as num).toDouble() / 100,
                          backgroundColor: Colors.grey[300],
                          color: theme.colors.primary,
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                _MilestoneRow('Clinical Rotations', resident['milestones']['clinical'] as bool, theme),
                                const SizedBox(height: 8),
                                _MilestoneRow('Research/Pubs', resident['milestones']['research'] as bool, theme),
                                const SizedBox(height: 8),
                                _MilestoneRow('Board Prep', resident['milestones']['boards'] as bool, theme),
                              ],
                            ),
                          )
                        ],
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

  Widget _MilestoneRow(String label, bool completed, PrimeThemeData theme) {
    return Row(
      children: [
        Icon(completed ? Icons.check_circle : Icons.radio_button_unchecked, color: completed ? Colors.green : Colors.grey),
        const SizedBox(width: 8),
        Text(label, style: theme.typography.bodyMedium),
      ],
    );
  }
}
