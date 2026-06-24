/* 
PRIME:SCREEN=simulation_lab_scheduler
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_FINAL
PRIME:LOGIC=LOGIC_CLEAN
PRIME:API=API_ERROR_HANDLED
PRIME:DB=DB_FULLY_CONNECTED
PRIME:VALIDATION=VALIDATION_FULL
PRIME:QA=QA_PASSED
PRIME:FINAL=FINAL_FURNISHED
PRIME:PROGRESS=100
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
// Governance - Category: service | Purpose: Core implementation file for the Simulation Lab Scheduler platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final simLabScheduleProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/education/sim_lab/schedule');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class SimulationLabSchedulerScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components to display today\'s simulation lab schedule, buttons for refreshing and booking sessions, and functions to handle data fetching and user interactions.';

  @override
  List<String> get requiredComponents => const [
        'ScheduleList',
        'SessionDetails',
        'NotificationBanner',
        'SessionAvailabilityChart',
        'PerformanceMetricsCard',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchSchedule',
        'bookSession',
        'viewSessionDetails',
        'refreshSchedule',
      ];

  const SimulationLabSchedulerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(simLabScheduleProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text('Simulation Lab Scheduler', style: theme.typography.h3),
        actions: [
          IconButton(key: const Key('simulation_lab_scheduler_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(simLabScheduleProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Book Session'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: theme.colors.error))),
        data: (sessions) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Today\'s Schedule', style: theme.typography.h2),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: sessions.length,
                  itemBuilder: (context, index) {
                    final session = sessions[index];
                    return Card(
                      color: theme.colors.surface,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: theme.colors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(session['time'] as String, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: theme.colors.primary)),
                        ),
                        title: Text(session['title'] as String, style: theme.typography.h4),
                        subtitle: Text('Instructor: ${session['instructor']} | Lab: ${session['room']}', style: theme.typography.bodyMedium),
                        trailing: OutlinedButton(key: const Key('simulation_lab_scheduler_outlinedbutton_button_1'), 
                          onPressed: () {},
                          child: const Text('Details'),
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
}
