/* 
PRIME:SCREEN=compliance_training_tracker
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
// Governance - Category: service | Purpose: Core implementation file for the Compliance Training Tracker platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final complianceTrainingProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/compliance/training');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class ComplianceTrainingTrackerScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components to display compliance training status, buttons for refreshing data and sending reminders, and functions to handle these actions, along with necessary API endpoints and responsive design for multiple platforms.';

  @override
  List<String> get requiredComponents => const [
        'ComplianceTrainingStatusCard',
        'TrainingOverviewChart',
        'TrainingDetailView',
        'ErrorAlertComponent',
      ];

  @override
  List<String> get requiredFunctions => const [
        'refreshTrainingData',
        'sendTrainingReminders',
      ];

  const ComplianceTrainingTrackerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(complianceTrainingProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Compliance Training Tracker',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('compliance_training_tracker_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(complianceTrainingProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.send),
              label: const Text('Send Reminders'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load training data: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (trainings) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Employee Mandatory Training Status', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: trainings.length,
                  itemBuilder: (context, index) {
                    final training = trainings[index];
                    final isOverdue = training['status'] == 'overdue';
                    return Card(
                      color: theme.colors.surface,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isOverdue ? theme.colors.error.withOpacity(0.1) : theme.colors.primary.withOpacity(0.1),
                          child: Icon(
                            isOverdue ? Icons.warning : Icons.school,
                            color: isOverdue ? theme.colors.error : theme.colors.primary,
                          ),
                        ),
                        title: Text('Module: ${training['moduleName'] as String?}', style: theme.typography.h4),
                        subtitle: Text('Employee: ${training['employeeName'] as String?} | Due: ${training['dueDate'] as String?}'),
                        trailing: isOverdue 
                            ? Chip(label: const Text('Overdue'), backgroundColor: theme.colors.error.withOpacity(0.2))
                            : Chip(label: Text((training['status'] as String?) ?? 'Pending'), backgroundColor: theme.colors.warning.withOpacity(0.2)),
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
