// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A heatmap showing quality assurance metrics and error rates.
class QualityAssuranceHeatmap extends StatelessWidget {
  final AnalyticsChart chart;

  const QualityAssuranceHeatmap({super.key, required this.chart});

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
                  Text('Quality Velocity Index', style: theme.typography.h3),
                  Text(
                    'Enterprise-wide error rates and audit performance',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              PrimeCareStatusBadge(
                label: '98.5% ACCURACY',
                type: BadgeType.success,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.lg),
          SizedBox(height: 250, child: PrimeCareBarChart(chart: chart)),
        ],
      ),
    );
  }
}

/// A grid tracking the resolution of quality audit findings.
class AuditResolutionGrid extends StatelessWidget {
  const AuditResolutionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Audit Resolution Matrix', style: theme.typography.h3),
          Text(
            'Real-time tracking of quality corrective actions',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Finding', 'Severity', 'Resolution', 'Status'],
            rows: [
              _buildRow('Doc Gap: Toronto', 'MEDIUM', 'In Progress', 'INFO'),
              _buildRow('Meds Verification', 'HIGH', 'Resolved', 'SUCCESS'),
              _buildRow('Staff Training', 'LOW', 'Scheduled', 'INFO'),
              _buildRow('Safety Protocol', 'HIGH', 'Resolved', 'SUCCESS'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String finding,
    String severity,
    String resolution,
    String status,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(finding)),
        DataCell(
          PrimeCareStatusBadge(
            label: severity,
            type: severity == 'HIGH'
                ? BadgeType.danger
                : (severity == 'MEDIUM' ? BadgeType.warning : BadgeType.info),
          ),
        ),
        DataCell(Text(resolution)),
        DataCell(
          PrimeCareStatusBadge(
            label: status,
            type: status == 'SUCCESS' ? BadgeType.success : BadgeType.info,
          ),
        ),
      ],
    );
  }
}

/// Quality assurance action hub for the QA Manager.
class QaActionHub extends StatelessWidget {
  QaActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: [
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_start_audit.tr(),
          icon: LucideIcons.clipboardCheck,
          route: '/qa/audit/new',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_log_incident.tr(),
          icon: LucideIcons.alertCircle,
          route: '/qa/incident/new',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_quality_report.tr(),
          icon: LucideIcons.fileText,
          route: '/qa/reports',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_root_cause.tr(),
          icon: LucideIcons.search,
          route: '/qa/rca',
        ),
      ],
    );
  }
}
