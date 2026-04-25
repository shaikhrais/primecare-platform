// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A performance card focusing on territory-specific lead velocity.
class TerritoryPerformanceCard extends StatelessWidget {
  final AnalyticsChart chart;

  const TerritoryPerformanceCard({super.key, required this.chart});

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
                  Text('Territory Lead Velocity', style: theme.typography.h3),
                  Text(
                    'Current performance vs quarterly targets',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              _buildTargetBadge(theme, '92% OF TARGET'),
            ],
          ),
          SizedBox(height: theme.spacing.lg),
          SizedBox(height: 250, child: PrimeCareLineChart(chart: chart)),
        ],
      ),
    );
  }

  Widget _buildTargetBadge(PrimeCareThemeData theme, String text) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.sm,
        vertical: theme.spacing.xxs,
      ),
      decoration: BoxDecoration(
        color: theme.colors.success.withValues(alpha: 0.1),
        borderRadius: PrimeCareRadii.boardPill,
        border: Border.all(color: theme.colors.success.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: theme.typography.labelSmall.copyWith(
          color: theme.colors.success,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// A scorecard showing synergy ratings for regional partners.
class RegionalSynergyScorecard extends StatelessWidget {
  const RegionalSynergyScorecard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Regional Synergy Scorecard', style: theme.typography.h3),
          Text(
            'Partner engagement and referral quality metrics',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Partner', 'Engage Score', 'Quality', 'Last Visit'],
            rows: [
              _buildRow('City Health', '9.4', 'A+', '2d ago'),
              _buildRow('Sunrise Manor', '8.2', 'A', '5d ago'),
              _buildRow('Parkview Clinic', '6.8', 'B+', '1w ago'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String partner,
    String score,
    String quality,
    String visit,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(partner)),
        DataCell(
          Text(score, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(
          PrimeCareStatusBadge(
            label: quality,
            type: quality.startsWith('A')
                ? BadgeType.success
                : BadgeType.warning,
          ),
        ),
        DataCell(Text(visit)),
      ],
    );
  }
}

/// Action hub for Regional Business Development Managers.
class BdmActionHub extends StatelessWidget {
  const BdmActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: const [
        PrimeCareActionItem(
          title: 'Log Visit',
          icon: LucideIcons.mapPin,
          route: '/activity/log-visit',
        ),
        PrimeCareActionItem(
          title: 'Sync Data',
          icon: LucideIcons.refreshCw,
          route: '/system/sync',
        ),
        PrimeCareActionItem(
          title: 'Regional Audit',
          icon: LucideIcons.fileSearch,
          route: '/audit/regional',
        ),
      ],
    );
  }
}
