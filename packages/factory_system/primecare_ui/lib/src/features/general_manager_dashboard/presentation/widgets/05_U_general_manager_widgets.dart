// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A heatmap showing performance across all departments.
class DepartmentalPerformanceHeatmap extends StatelessWidget {
  final AnalyticsChart chart;

  const DepartmentalPerformanceHeatmap({super.key, required this.chart});

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
                  Text('Departmental Velocity', style: theme.typography.h3),
                  Text(
                    'Cross-departmental operational health indices',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              PrimeCareButton(
                label: 'SITE AUDIT',
                type: PrimeCareButtonType.text,
                onPressed: () {},
                icon: LucideIcons.clipboardCheck,
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

/// A grid showing site-level logistics and infrastructure status.
class SiteLogisticsGrid extends StatelessWidget {
  const SiteLogisticsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Site Logistics Matrix', style: theme.typography.h3),
          Text(
            'Real-time infrastructure and logistical status by location',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Site Location', 'Uptime', 'Logistics', 'Health'],
            rows: [
              _buildRow('Main Campus', '99.9%', 'Verified', 'SUCCESS'),
              _buildRow('Satellite A', '94.2%', 'Verified', 'SUCCESS'),
              _buildRow('Training Wing', '88.5%', 'Pending', 'CAUTION'),
              _buildRow('Remote Ops', '91.0%', 'Verified', 'SUCCESS'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String location,
    String uptime,
    String logistics,
    String status,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(location)),
        DataCell(
          Text(uptime, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(Text(logistics)),
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

/// General action hub for the General Manager.
class GmActionHub extends StatelessWidget {
  const GmActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: const [
        PrimeCareActionItem(
          title: 'Site Visit',
          icon: LucideIcons.mapPin,
          route: '/gm/visits/new',
        ),
        PrimeCareActionItem(
          title: 'Review Metrics',
          icon: LucideIcons.lineChart,
          route: '/gm/metrics',
        ),
        PrimeCareActionItem(
          title: 'Incident Log',
          icon: LucideIcons.alertCircle,
          route: '/gm/incidents',
        ),
        PrimeCareActionItem(
          title: 'Staff Meeting',
          icon: LucideIcons.users,
          route: '/gm/meetings',
        ),
      ],
    );
  }
}
