// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A center for regional performance and site-to-site comparisons.
class RegionalPerformanceCenter extends StatelessWidget {
  final AnalyticsChart chart;

  const RegionalPerformanceCenter({super.key, required this.chart});

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
                    'Regional Performance Matrix',
                    style: theme.typography.h3,
                  ),
                  Text(
                    'Site-to-site comparative operational metrics',
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

/// A scorecard for territory health and operational status.
class TerritoryHealthScorecard extends StatelessWidget {
  const TerritoryHealthScorecard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Territory Health Scorecard', style: theme.typography.h3),
          Text(
            'Operational health indices across regional territories',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Territory', 'Score', 'Status', 'Trend'],
            rows: [
              _buildRow('North Region', '94/100', 'SUCCESS', 'UP'),
              _buildRow('South Region', '82/100', 'CAUTION', 'STABLE'),
              _buildRow('East Region', '91/100', 'SUCCESS', 'UP'),
              _buildRow('West Region', '76/100', 'CRITICAL', 'DOWN'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String territory,
    String score,
    String status,
    String trend,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(territory)),
        DataCell(
          Text(score, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(
          PrimeCareStatusBadge(
            label: status,
            type: status == 'SUCCESS'
                ? BadgeType.success
                : (status == 'CAUTION' ? BadgeType.warning : BadgeType.danger),
          ),
        ),
        DataCell(
          Icon(
            trend == 'UP'
                ? LucideIcons.trendingUp
                : (trend == 'DOWN'
                      ? LucideIcons.trendingDown
                      : LucideIcons.minus),
            color: trend == 'UP'
                ? Colors.green
                : (trend == 'DOWN' ? Colors.red : Colors.grey),
            size: 16,
          ),
        ),
      ],
    );
  }
}

/// Regional action hub for the Regional Manager.
class RegionalActionHub extends StatelessWidget {
  const RegionalActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: const [
        PrimeCareActionItem(
          title: 'Site Audit',
          icon: LucideIcons.clipboardCheck,
          route: '/regional/audit',
        ),
        PrimeCareActionItem(
          title: 'Review Perf',
          icon: LucideIcons.barChart,
          route: '/regional/performance',
        ),
        PrimeCareActionItem(
          title: 'Manage Staff',
          icon: LucideIcons.users,
          route: '/regional/staff',
        ),
        PrimeCareActionItem(
          title: 'Territory Plan',
          icon: LucideIcons.map,
          route: '/regional/territory',
        ),
      ],
    );
  }
}
