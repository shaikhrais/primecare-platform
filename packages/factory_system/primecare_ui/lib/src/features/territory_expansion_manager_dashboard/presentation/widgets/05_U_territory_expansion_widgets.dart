// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A heatmap showing market penetration in expansion territories.
class MarketPenetrationHeatmap extends StatelessWidget {
  final AnalyticsChart chart;

  const MarketPenetrationHeatmap({super.key, required this.chart});

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
                  Text('Market Penetration', style: theme.typography.h3),
                  Text(
                    'Growth velocity across target expansion territories',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              PrimeCareButton(
                label: 'MARKET DATA',
                type: PrimeCareButtonType.text,
                onPressed: () {},
                icon: LucideIcons.database,
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

/// A grid showing detailed territory expansion opportunities.
class TerritoryOpportunityGrid extends StatelessWidget {
  const TerritoryOpportunityGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Expansion Opportunity Matrix', style: theme.typography.h3),
          Text(
            'Market viability and saturation metrics by territory',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Territory', 'Saturation', 'Viability', 'Status'],
            rows: [
              _buildRow('Toronto West', '85%', 'High', 'LAUNCHED'),
              _buildRow('Vancouver Island', '12%', 'Very High', 'ANALYSIS'),
              _buildRow('Ottawa Central', '45%', 'Medium', 'PENDING'),
              _buildRow('Calgary North', '8%', 'High', 'SCOUTING'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String territory,
    String saturation,
    String viability,
    String status,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(territory)),
        DataCell(Text(saturation)),
        DataCell(
          Text(viability, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(
          PrimeCareStatusBadge(label: status, type: _getBadgeType(status)),
        ),
      ],
    );
  }

  BadgeType _getBadgeType(String status) {
    switch (status) {
      case 'LAUNCHED':
        return BadgeType.success;
      case 'ANALYSIS':
        return BadgeType.info;
      case 'PENDING':
        return BadgeType.warning;
      case 'SCOUTING':
        return BadgeType.neutral;
      default:
        return BadgeType.neutral;
    }
  }
}

/// Expansion action hub for the Territory Expansion Manager.
class ExpansionActionHub extends StatelessWidget {
  ExpansionActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: [
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_analyze_market.tr(),
          icon: LucideIcons.search,
          route: '/expansion/analyze',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_launch_territory.tr(),
          icon: LucideIcons.rocket,
          route: '/expansion/launch',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_growth_report.tr(),
          icon: LucideIcons.trendingUp,
          route: '/expansion/reports',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_scout_location.tr(),
          icon: LucideIcons.mapPin,
          route: '/expansion/scout',
        ),
      ],
    );
  }
}
