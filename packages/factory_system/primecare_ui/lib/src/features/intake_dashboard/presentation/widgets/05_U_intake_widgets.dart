// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A heatmap showing intake velocity and volume.
class IntakeVelocityHeatmap extends StatelessWidget {
  final AnalyticsChart chart;

  const IntakeVelocityHeatmap({super.key, required this.chart});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Intake Velocity Index', style: theme.typography.h3),
                  Text(
                    'Onboarding volume and clinical processing speed',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              PrimeCareStatusBadge(label: 'Avg 4.2h', type: BadgeType.info),
            ],
          ),
          SizedBox(height: theme.spacing.lg),
          SizedBox(height: 250, child: PrimeCareBarChart(chart: chart)),
        ],
      ),
    );
  }
}

/// A matrix tracking referral sources and acquisition channels.
class ReferralSourceMatrix extends StatelessWidget {
  const ReferralSourceMatrix({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Referral Source Matrix', style: theme.typography.h3),
          Text(
            'Patient acquisition channels and referral velocity',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Source', 'Count', 'Conversion', 'Status'],
            rows: [
              _buildRow('Hospital A', '42', '18%', 'SUCCESS'),
              _buildRow('Community Clinic', '28', '24%', 'SUCCESS'),
              _buildRow('Direct Inquiry', '15', '45%', 'INFO'),
              _buildRow('Long-term Care', '12', '12%', 'CAUTION'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String source,
    String count,
    String conversion,
    String status,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(source)),
        DataCell(
          Text(count, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(Text(conversion)),
        DataCell(
          PrimeCareStatusBadge(
            label: status,
            type: status == 'SUCCESS'
                ? BadgeType.success
                : (status == 'INFO' ? BadgeType.info : BadgeType.warning),
          ),
        ),
      ],
    );
  }
}

/// Intake action hub for the Intake Coordinator.
class IntakeDashboardActionHub extends StatelessWidget {
  const IntakeDashboardActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: const [
        PrimeCareActionItem(
          title: 'New Intake',
          icon: LucideIcons.userPlus,
          route: '/intake/new',
        ),
        PrimeCareActionItem(
          title: 'Schedule',
          icon: LucideIcons.calendar,
          route: '/intake/schedule',
        ),
        PrimeCareActionItem(
          title: 'Assessments',
          icon: LucideIcons.clipboardList,
          route: '/intake/assessments',
        ),
        PrimeCareActionItem(
          title: 'Referrals',
          icon: LucideIcons.share2,
          route: '/intake/referrals',
        ),
      ],
    );
  }
}
