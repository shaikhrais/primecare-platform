// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// Heatmap visualizing staffing coverage across the facility.
class StaffingHeatmap extends StatelessWidget {
  final AnalyticsChart chart;

  StaffingHeatmap({super.key, required this.chart});

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
                    LocaleKeys.clinical_director_labels_staffing_matrix.tr(),
                    style: theme.typography.h3,
                  ),
                  Text(
                    LocaleKeys.clinical_director_labels_staffing_variance.tr(),
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              PrimeCareStatusBadge(
                text: '98.2% COVERAGE',
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

/// A log tracking compliance with clinical protocols.
class ProtocolComplianceLog extends StatelessWidget {
  ProtocolComplianceLog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.clinical_director_labels_compliance_log.tr(),
            style: theme.typography.h3,
          ),
          Text(
            LocaleKeys.clinical_director_labels_audit_adherence.tr(),
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Protocol', 'Auditor', 'Timestamp', 'Status'],
            rows: [
              _buildRow('Hand Hygiene', 'System AI', '10:15 AM', 'PASS'),
              _buildRow('Wound Care Sync', 'Head Nurse', '09:45 AM', 'PASS'),
              _buildRow('Meds Verification', 'System AI', '09:12 AM', 'PASS'),
              _buildRow('Staff Briefing', 'Director', '08:00 AM', 'WARNING'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String protocol,
    String auditor,
    String time,
    String status,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(protocol)),
        DataCell(Text(auditor)),
        DataCell(Text(time)),
        DataCell(
          PrimeCareStatusBadge(
            text: status,
            type: status == 'PASS' ? BadgeType.success : BadgeType.warning,
          ),
        ),
      ],
    );
  }
}

/// A trend chart showing clinical incidents over time.
class IncidentTrendChart extends StatelessWidget {
  final AnalyticsChart chart;

  IncidentTrendChart({super.key, required this.chart});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.clinical_director_labels_incident_trends.tr(),
            style: theme.typography.h3,
          ),
          Text(
            LocaleKeys.clinical_director_labels_incident_criticality.tr(),
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          SizedBox(height: 250, child: PrimeCareLineChart(chart: chart)),
        ],
      ),
    );
  }
}

/// Action hub for Clinical Director oversight.
class ClinicalDirectorActionHub extends StatelessWidget {
  ClinicalDirectorActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: [
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_review_audits.tr(),
          icon: LucideIcons.checkSquare,
          route: '/clinical/audits',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_staffing_plan.tr(),
          icon: LucideIcons.users,
          route: '/clinical/staffing',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_protocol_config.tr(),
          icon: LucideIcons.settings,
          route: '/clinical/protocols',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_incident_report.tr(),
          icon: LucideIcons.fileText,
          route: '/clinical/incidents',
        ),
      ],
    );
  }
}
