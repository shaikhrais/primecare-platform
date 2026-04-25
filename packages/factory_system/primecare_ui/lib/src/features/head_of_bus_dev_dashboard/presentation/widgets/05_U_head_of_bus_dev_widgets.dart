// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A high-fidelity visualization of regional growth and expansion metrics.
class RegionalGrowthHeatmap extends StatelessWidget {
  final AnalyticsChart chart;

  const RegionalGrowthHeatmap({super.key, required this.chart});

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
                  Text('Regional Growth Heatmap', style: theme.typography.h3),
                  Text(
                    'Expansion velocity by territory',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              PrimeCareButton(
                label: 'MAP VIEW',
                type: PrimeCareButtonType.text,
                onPressed: () {},
                icon: LucideIcons.map,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.lg),
          SizedBox(height: 300, child: PrimeCareLineChart(chart: chart)),
        ],
      ),
    );
  }
}

/// A visualization of the franchise pipeline and acquisition funnel.
class FranchisePipelineOverview extends StatelessWidget {
  const FranchisePipelineOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Franchise Pipeline Funnel', style: theme.typography.h3),
          Text(
            'Acquisition velocity and onboarding status',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Region', 'Leads', 'Under Review', 'Onboarding'],
            rows: [
              _buildRow('North America', '42', '12', '5'),
              _buildRow('Europe', '28', '8', '3'),
              _buildRow('Asia Pacific', '15', '4', '1'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String region,
    String leads,
    String review,
    String onboarding,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Text(region, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(Text(leads)),
        DataCell(Text(review)),
        DataCell(
          PrimeCareStatusBadge(label: onboarding, type: BadgeType.success),
        ),
      ],
    );
  }
}

/// Strategic action hub for the Head of Business Development.
class StrategicActionHub extends StatelessWidget {
  const StrategicActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: const [
        PrimeCareActionItem(
          title: 'Add Franchise',
          icon: LucideIcons.plusCircle,
          route: '/onboarding/franchise',
        ),
        PrimeCareActionItem(
          title: 'Growth Audit',
          icon: LucideIcons.trendingUp,
          route: '/audit/growth',
        ),
        PrimeCareActionItem(
          title: 'Market Analysis',
          icon: LucideIcons.barChart4,
          route: '/reports/market',
        ),
        PrimeCareActionItem(
          title: 'Legal Review',
          icon: LucideIcons.gavel,
          route: '/audit/legal',
        ),
      ],
    );
  }
}
