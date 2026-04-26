// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A card tracking staffing turnover and recruitment trends.
class StaffingTurnoverCard extends StatelessWidget {
  final List<ChartDataPoint> data;

  StaffingTurnoverCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return PrimeCareChartCard(
      title: LocaleKeys.dashboards_common_labels_human_capital_velocity.tr(),
      chart: PrimeCareLineChart(
        chart: AnalyticsChart(
          id: 'hr-velocity',
          title: LocaleKeys.dashboards_common_labels_human_capital_velocity
              .tr(),
          type: ChartType.line,
          dataPoints: data,
        ),
      ),
    );
  }
}

/// A grid tracking mandatory training and certification compliance.
class TrainingComplianceGrid extends StatelessWidget {
  const TrainingComplianceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Institutional Compliance', style: theme.typography.h3),
          Text(
            'Mandatory training and certification audit status',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Certification', 'Certified', 'Expiring', 'Status'],
            rows: [
              _buildRow('First Aid / CPR', '92%', '8', 'STABLE'),
              _buildRow('Dementia Care', '85%', '12', 'CAUTION'),
              _buildRow('WHMIS 2026', '98%', '2', 'STABLE'),
              _buildRow('Privacy Policy', '75%', '24', 'CRITICAL'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String cert,
    String certified,
    String expiring,
    String status,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(cert)),
        DataCell(
          Text(certified, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(Text(expiring)),
        DataCell(
          PrimeCareStatusBadge(label: status, type: _getBadgeType(status)),
        ),
      ],
    );
  }

  BadgeType _getBadgeType(String status) {
    switch (status) {
      case 'STABLE':
        return BadgeType.success;
      case 'CAUTION':
        return BadgeType.warning;
      case 'CRITICAL':
        return BadgeType.danger;
      default:
        return BadgeType.neutral;
    }
  }
}

/// HR-specific action hub.
class HrActionHub extends StatelessWidget {
  HrActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: [
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_post_job.tr(),
          icon: LucideIcons.briefcase,
          route: '/hr/jobs/new',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_approve_leave.tr(),
          icon: LucideIcons.calendarX,
          route: '/hr/leave',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_run_payroll.tr(),
          icon: LucideIcons.banknote,
          route: '/hr/payroll',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_audit_training.tr(),
          icon: LucideIcons.graduationCap,
          route: '/hr/training',
        ),
      ],
    );
  }
}
