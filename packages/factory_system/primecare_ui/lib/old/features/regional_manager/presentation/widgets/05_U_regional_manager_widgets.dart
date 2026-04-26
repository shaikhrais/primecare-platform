// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A center for regional performance and site-to-site comparisons.
class RegionalPerformanceCenter extends StatelessWidget {
  final AnalyticsChart chart;

  RegionalPerformanceCenter({super.key, required this.chart});

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
                    LocaleKeys.regional_manager_labels_performance_matrix.tr(),
                    style: theme.typography.h3,
                  ),
                  Text(
                    LocaleKeys.regional_manager_labels_comparative_metrics.tr(),
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
  TerritoryHealthScorecard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.regional_manager_labels_health_scorecard.tr(),
            style: theme.typography.h3,
          ),
          Text(
            LocaleKeys.regional_manager_labels_health_indices.tr(),
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
  RegionalActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: [
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_site_audit.tr(),
          icon: LucideIcons.clipboardCheck,
          route: '/regional/audit',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_review_perf.tr(),
          icon: LucideIcons.barChart,
          route: '/regional/performance',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_manage_staff.tr(),
          icon: LucideIcons.users,
          route: '/regional/staff',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_territory_plan.tr(),
          icon: LucideIcons.map,
          route: '/regional/territory',
        ),
      ],
    );
  }
}
