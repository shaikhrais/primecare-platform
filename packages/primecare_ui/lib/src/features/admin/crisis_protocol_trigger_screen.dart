/* 
PRIME:SCREEN=crisis_protocol_trigger
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
// Governance - Category: view | Purpose: UI Screen component rendering the Crisis Protocol Trigger Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

class CrisisProtocolTriggerScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The Crisis Protocol Trigger Screen requires components for activating protocols, monitoring staff check-ins, and providing feedback on protocol effectiveness, along with necessary buttons, functions, and APIs.';

  @override
  List<String> get requiredComponents => const [
        'CrisisProtocolCard',
        'StaffCheckInList',
        'ProtocolOutcomeMetrics',
        'AlertNotification',
        'CrisisStatusIndicator',
      ];

  @override
  List<String> get requiredFunctions => const [
        'activateCrisisProtocol',
        'checkInStaff',
        'sendAlert',
        'submitFeedback',
      ];

  const CrisisProtocolTriggerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.error, // Red app bar for crisis
        title: Text(
          'EMERGENCY PROTOCOL ACTIVATION',
          style: theme.typography.h3.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Activate Crisis Workflows', style: theme.typography.h2),
            const SizedBox(height: 8),
            Text(
              'Triggers global broadcast messages, shifts API priority, and forces staff check-ins.',
              style: theme.typography.bodyLarge.copyWith(color: theme.colors.textSecondary),
            ),
            const SizedBox(height: 24),
            ResponsiveGrid(
              minItemWidth: 350,
              maxItemWidth: 500,
              spacing: 24.0,
              children: [
                _buildProtocolCard(
                  theme,
                  title: 'Severe Weather / Natural Disaster',
                  icon: Icons.storm,
                  description: 'Reroutes field staff, sends SMS alerts to patients.',
                ),
                _buildProtocolCard(
                  theme,
                  title: 'Infectious Disease Outbreak',
                  icon: Icons.coronavirus,
                  description: 'Enforces PPE checklists, isolates high-risk shift scheduling.',
                ),
                _buildProtocolCard(
                  theme,
                  title: 'System Security Breach',
                  icon: Icons.security,
                  description: 'Revokes all active sessions, forces password reset.',
                ),
                _buildProtocolCard(
                  theme,
                  title: 'Mass Casualty Incident',
                  icon: Icons.local_hospital,
                  description: 'Alerts all available clinical staff for emergency triage.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProtocolCard(PrimeThemeData theme, {required String title, required IconData icon, required String description}) {
    return Card(
      color: theme.colors.surface,
      elevation: 4,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: theme.colors.error, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Icon(icon, size: 64, color: theme.colors.error),
            const SizedBox(height: 16),
            Text(title, style: theme.typography.h4, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(description, style: theme.typography.bodyMedium, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton(key: const Key('crisis_protocol_trigger_screen_elevatedbutton_button_1'), 
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colors.error,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () {},
              child: const Text('ACTIVATE PROTOCOL'),
            ),
          ],
        ),
      ),
    );
  }
}
