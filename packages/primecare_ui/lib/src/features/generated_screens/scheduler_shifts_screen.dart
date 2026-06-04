// Governance - Category: view | Purpose: UI Screen component rendering the Scheduler Shifts workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

class SchedulerShiftsScreen extends GovernedStatelessWidget {
  const SchedulerShiftsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    final theme = context.theme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GovDashboardHero(
            title: 'Scheduler Shifts',
            roleName: 'SCHEDULER Workspace',
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
