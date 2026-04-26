// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A heatmap showing clinical safety indices and incident trends.
class ClinicalSafetyHeatmap extends StatelessWidget {
  final AnalyticsChart chart;

  const ClinicalSafetyHeatmap({super.key, required this.chart});

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
                  Text('Clinical Safety Index', style: theme.typography.h3),
                  Text(
                    'Patient safety metrics and incident resolution velocity',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              PrimeCareStatusBadge(
                label: '99.2% SAFE',
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

/// A matrix tracking clinical compliance and quality indices.
class ClinicalComplianceMatrix extends StatelessWidget {
  const ClinicalComplianceMatrix({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Clinical Compliance Matrix', style: theme.typography.h3),
          Text(
            'Quality indices across specialized clinical departments',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Department', 'Compliance', 'Audit', 'Status'],
            rows: [
              _buildRow('Nursing', '98%', 'Verified', 'SUCCESS'),
              _buildRow('Therapy', '94%', 'Verified', 'SUCCESS'),
              _buildRow('Pharmacy', '88%', 'Pending', 'CAUTION'),
              _buildRow('Diagnostics', '91%', 'Verified', 'SUCCESS'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String dept,
    String compliance,
    String audit,
    String status,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(dept)),
        DataCell(
          Text(compliance, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(Text(audit)),
        DataCell(
          PrimeCareStatusBadge(
            label: status,
            type: status == 'SUCCESS' ? BadgeType.success : BadgeType.warning,
          ),
        ),
      ],
    );
  }
}

/// Clinical action hub for the Clinical Director.
class ClinicalActionHub extends StatelessWidget {
  ClinicalActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: [
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_review_incident.tr(),
          icon: LucideIcons.alertTriangle,
          route: '/clinical/incidents',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_evaluate_plan.tr(),
          icon: LucideIcons.fileSearch,
          route: '/clinical/care-plans',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_staff_audit.tr(),
          icon: LucideIcons.userCheck,
          route: '/clinical/staff-audit',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_quality_review.tr(),
          icon: LucideIcons.shieldCheck,
          route: '/clinical/quality',
        ),
      ],
    );
  }
}
