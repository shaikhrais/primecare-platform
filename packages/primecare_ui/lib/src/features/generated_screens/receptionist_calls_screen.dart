/* 
PRIME:SCREEN=receptionist_calls
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_LAYOUT_DONE
PRIME:COMP=COMP_MISSING
PRIME:LOGIC=LOGIC_NONE
PRIME:API=API_NONE
PRIME:DB=DB_NONE
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=30
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
// Governance - Category: view | Purpose: UI Screen component rendering the Receptionist Calls workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

class ReceptionistCallsScreen extends GovernedStatelessWidget {
  @override
  String get screenDescription =>
      'The screen requires components for monitoring operational status, compliance, and transaction flow, along with a form for submitting secure events.';

  @override
  List<String> get requiredComponents => const [
        'OperationalStatusIndicator',
        'VerificationAuditStatus',
        'TelemetryChart',
        'SecureEventLoggingForm',
      ];

  @override
  List<String> get requiredFunctions => const [
        'checkCompliance',
        'logOperationalEvent',
        'trackTransactionFlow',
      ];

  const ReceptionistCallsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    final theme = context.theme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GovDashboardHero(
            title: 'Receptionist Calls',
            roleName: 'RECEPTIONIST Workspace',
            description: 'Manage institutional settings, track real-time clinical workflows, and verify live compliance standing.',
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: GovMetricCard(
                  title: 'Operational Status',
                  value: 'ACTIVE',
                  trendLabel: 'SLA uptime is 99.98%',
                  progress: 0.95,
                  icon: LucideIcons.activity,
                  brandColor: theme.colors.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GovMetricCard(
                  title: 'Verification Audits',
                  value: 'Compliant',
                  trendLabel: 'Zero issues detected',
                  progress: 1.0,
                  icon: LucideIcons.shieldCheck,
                  brandColor: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          GovTelemetryChart(
            title: 'Hourly Transaction flow',
            dataPoints: const [45, 62, 58, 87, 81, 95],
            labels: const ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00'],
            accentColor: theme.colors.primary,
          ),
          const SizedBox(height: 24),
          GovIngestionForm(
            title: 'Secure Operational Event Logger',
            buttonLabel: 'Submit Secure Ledger Event',
            fields: const [
              'Operator Employee ID',
              'Event Classification Type',
              'Security Consent Signature',
            ],
            onSubmit: (data) {},
          ),
        ],
      ),
    );
  }
}
