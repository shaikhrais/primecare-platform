// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A card tracking the sales funnel stages for franchise acquisition.
class SalesFunnelHeatmap extends StatelessWidget {
  final AnalyticsChart chart;

  const SalesFunnelHeatmap({super.key, required this.chart});

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
                  Text('Franchise Sales Funnel', style: theme.typography.h3),
                  Text(
                    'Lead acquisition velocity and stage conversion rates',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              PrimeCareButton(
                label: 'NEW LEAD',
                type: PrimeCareButtonType.text,
                onPressed: () {},
                icon: LucideIcons.userPlus,
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

/// A grid showing detailed lead conversion metrics and status.
class FranchiseSalesLeadConversionGrid extends StatelessWidget {
  const FranchiseSalesLeadConversionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Franchise Lead Matrix', style: theme.typography.h3),
          Text(
            'Lead quality and conversion performance by region',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Lead Name', 'Region', 'Stage', 'Score'],
            rows: [
              _buildRow('Elite Care Group', 'Ontario', 'Discovery', '88'),
              _buildRow('Pacific Health LLC', 'BC', 'Proposal', '94'),
              _buildRow('Atlantic Senior Care', 'NS', 'Closed', '100'),
              _buildRow('Prairie Wellness', 'AB', 'Lead', '45'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(String name, String region, String stage, String score) {
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(Text(region)),
        DataCell(Text(stage)),
        DataCell(
          PrimeCareStatusBadge(
            label: score,
            type: int.parse(score) > 80 ? BadgeType.success : BadgeType.info,
          ),
        ),
      ],
    );
  }
}

/// Sales action hub for the Franchise Sales Manager.
class SalesActionHub extends StatelessWidget {
  const SalesActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: const [
        PrimeCareActionItem(
          title: 'Add Lead',
          icon: LucideIcons.userPlus,
          route: '/sales/leads/new',
        ),
        PrimeCareActionItem(
          title: 'Discovery Call',
          icon: LucideIcons.phoneCall,
          route: '/sales/discovery',
        ),
        PrimeCareActionItem(
          title: 'Pipeline Report',
          icon: LucideIcons.barChart,
          route: '/sales/reports/pipeline',
        ),
        PrimeCareActionItem(
          title: 'Closing Desk',
          icon: LucideIcons.checkCircle,
          route: '/sales/closing',
        ),
      ],
    );
  }
}
