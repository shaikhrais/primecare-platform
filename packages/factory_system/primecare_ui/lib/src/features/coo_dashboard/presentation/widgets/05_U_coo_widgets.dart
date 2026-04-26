// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A heatmap showing operational continuity across all offices.
class OperationalContinuityHeatmap extends StatelessWidget {
  final AnalyticsChart chart;

  const OperationalContinuityHeatmap({super.key, required this.chart});

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
                  Text('Operational Continuity', style: theme.typography.h3),
                  Text(
                    'Logistics velocity and office-wide uptime',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              PrimeCareButton(
                label: 'LOGISTICS MAP',
                type: PrimeCareButtonType.text,
                onPressed: () {},
                icon: LucideIcons.map,
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

/// A grid monitoring staffing capacity and utilization rates.
class StaffingCapacityGrid extends StatelessWidget {
  const StaffingCapacityGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Human Capital Capacity', style: theme.typography.h3),
          Text(
            'Clinical and administrative staffing utilization',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Role Group', 'Capacity', 'Utilization', 'Status'],
            rows: [
              _buildRow('Clinical Nurses', '120/150', '80%', 'OPTIMAL'),
              _buildRow('Care Aides', '240/300', '80%', 'OPTIMAL'),
              _buildRow('Admin Staff', '45/50', '90%', 'CAUTION'),
              _buildRow('Field Logistics', '12/20', '60%', 'UNDER'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String group,
    String capacity,
    String utilization,
    String status,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(group)),
        DataCell(Text(capacity)),
        DataCell(
          Text(
            utilization,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataCell(
          PrimeCareStatusBadge(label: status, type: _getBadgeType(status)),
        ),
      ],
    );
  }

  BadgeType _getBadgeType(String status) {
    switch (status) {
      case 'OPTIMAL':
        return BadgeType.success;
      case 'CAUTION':
        return BadgeType.warning;
      case 'UNDER':
        return BadgeType.info;
      default:
        return BadgeType.neutral;
    }
  }
}

/// Operational action hub for the COO.
class CooActionHub extends StatelessWidget {
  CooActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: [
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_dispatch_supplies.tr(),
          icon: LucideIcons.truck,
          route: '/logistics/dispatch',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_capacity_audit.tr(),
          icon: LucideIcons.clipboardCheck,
          route: '/audit/capacity',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_incident_logs.tr(),
          icon: LucideIcons.alertTriangle,
          route: '/operations/incidents',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_facility_status.tr(),
          icon: LucideIcons.building,
          route: '/facilities/status',
        ),
      ],
    );
  }
}
