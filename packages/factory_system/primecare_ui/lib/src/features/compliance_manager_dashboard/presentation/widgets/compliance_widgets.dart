// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A heatmap showing regulatory adherence and policy compliance trends.
class RegulatoryAdherenceHeatmap extends StatelessWidget {
  final AnalyticsChart chart;

  const RegulatoryAdherenceHeatmap({super.key, required this.chart});

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
                  Text(
                    'Regulatory Adherence Index',
                    style: theme.typography.h3,
                  ),
                  Text(
                    'Consolidated governance and policy compliance telemetry',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              PrimeCareStatusBadge(
                label: '94% ADHERENT',
                type: BadgeType.success,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.lg),
          SizedBox(height: 250, child: PrimeCareLineChart(chart: chart)),
        ],
      ),
    );
  }
}

/// A grid tracking policy enforcement and regulatory infractions.
class ComplianceEnforcementGrid extends StatelessWidget {
  const ComplianceEnforcementGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Compliance Enforcement Matrix', style: theme.typography.h3),
          Text(
            'Tracking regulatory findings and policy enforcement status',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Policy', 'Domain', 'Status', 'Risk'],
            rows: [
              _buildRow('Privacy Act', 'Governance', 'COMPLIANT', 'LOW'),
              _buildRow('Staff Safety', 'Clinical', 'VERIFIED', 'LOW'),
              _buildRow('Medication Protocol', 'Clinical', 'PENDING', 'MEDIUM'),
              _buildRow('Data Security', 'IT', 'COMPLIANT', 'LOW'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(String policy, String domain, String status, String risk) {
    return DataRow(
      cells: [
        DataCell(Text(policy)),
        DataCell(Text(domain)),
        DataCell(
          PrimeCareStatusBadge(
            label: status,
            type: (status == 'COMPLIANT' || status == 'VERIFIED')
                ? BadgeType.success
                : BadgeType.info,
          ),
        ),
        DataCell(
          PrimeCareStatusBadge(
            label: risk,
            type: risk == 'LOW' ? BadgeType.success : BadgeType.warning,
          ),
        ),
      ],
    );
  }
}

/// Compliance action hub for the Compliance Manager.
class ComplianceActionHub extends StatelessWidget {
  ComplianceActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: [
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_review_policy.tr(),
          icon: LucideIcons.fileText,
          route: '/compliance/policy',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_log_finding.tr(),
          icon: LucideIcons.alertCircle,
          route: '/compliance/finding/new',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_regulatory_audit.tr(),
          icon: LucideIcons.shieldCheck,
          route: '/compliance/audit',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_enforcement.tr(),
          icon: LucideIcons.gavel,
          route: '/compliance/enforcement',
        ),
      ],
    );
  }
}
