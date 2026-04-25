// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// Heatmap visualizing staffing coverage across the facility.
class StaffingHeatmap extends StatelessWidget {
  final AnalyticsChart chart;

  const StaffingHeatmap({super.key, required this.chart});

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
                  Text('Staffing Coverage Matrix', style: theme.typography.h3),
                  Text(
                    'Real-time variance between required and actual staff',
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
  const ProtocolComplianceLog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Protocol Compliance Log', style: theme.typography.h3),
          Text(
            'Automated auditing of clinical workflow adherence',
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

  const IncidentTrendChart({super.key, required this.chart});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Incident Trends (30D)', style: theme.typography.h3),
          Text(
            'Criticality breakdown of reported clinical events',
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
  const ClinicalDirectorActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: const [
        PrimeCareActionItem(
          title: 'Review Audits',
          icon: LucideIcons.checkSquare,
          route: '/clinical/audits',
        ),
        PrimeCareActionItem(
          title: 'Staffing Plan',
          icon: LucideIcons.users,
          route: '/clinical/staffing',
        ),
        PrimeCareActionItem(
          title: 'Protocol Config',
          icon: LucideIcons.settings,
          route: '/clinical/protocols',
        ),
        PrimeCareActionItem(
          title: 'Incident Report',
          icon: LucideIcons.fileText,
          route: '/clinical/incidents',
        ),
      ],
    );
  }
}
