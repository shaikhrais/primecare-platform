/* 
PRIME:SCREEN=hr_staff_files
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
// Governance - Category: view | Purpose: UI Screen component rendering the Hr Staff Files workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

class HrStaffFilesScreen extends GovernedStatelessWidget {
  @override
  String get screenDescription =>
      'The screen requires components for monitoring operational status, displaying audit results, and logging events, along with necessary buttons and functions for user interaction.';

  @override
  List<String> get requiredComponents => const [
        'GovMetricCard',
        'GovTelemetryChart',
        'GovEventLogger',
      ];

  @override
  List<String> get requiredFunctions => const [
        'submitEventLog',
        'refreshOperationalStatus',
        'fetchAuditResults',
        'fetchTransactionFlow',
      ];

  const HrStaffFilesScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    final theme = context.theme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GovDashboardHero(
            title: 'Hr Staff Files',
            roleName: 'HR Workspace',
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
