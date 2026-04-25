// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A heatmap showing equity growth and enterprise value trends.
class EquityGrowthHeatmap extends StatelessWidget {
  final AnalyticsChart chart;

  const EquityGrowthHeatmap({super.key, required this.chart});

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
                  Text('Equity Growth Trajectory', style: theme.typography.h3),
                  Text(
                    'Consolidated enterprise valuation and growth velocity',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              PrimeCareStatusBadge(label: '9.2% YoY', type: BadgeType.success),
            ],
          ),
          SizedBox(height: theme.spacing.lg),
          SizedBox(height: 300, child: PrimeCareLineChart(chart: chart)),
        ],
      ),
    );
  }
}

/// A grid tracking dividend distributions and equity events.
class DividendDistributionGrid extends StatelessWidget {
  const DividendDistributionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Equity Distribution Matrix', style: theme.typography.h3),
          Text(
            'Owner distributions, dividends, and capital allocations',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Event', 'Date', 'Amount', 'Status'],
            rows: [
              _buildRow(
                'Q1 Dividend',
                '2026-03-31',
                '\$250,000',
                'DISTRIBUTED',
              ),
              _buildRow(
                'Capital Injection',
                '2026-02-15',
                '\$100,000',
                'VERIFIED',
              ),
              _buildRow(
                'Q2 Distribution',
                '2026-06-30',
                '\$250,000',
                'PENDING',
              ),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(String event, String date, String amount, String status) {
    return DataRow(
      cells: [
        DataCell(Text(event)),
        DataCell(Text(date)),
        DataCell(
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(
          PrimeCareStatusBadge(
            label: status,
            type: status == 'DISTRIBUTED' || status == 'VERIFIED'
                ? BadgeType.success
                : BadgeType.info,
          ),
        ),
      ],
    );
  }
}

/// Ownership action hub for the Entity Owner.
class OwnerActionHub extends StatelessWidget {
  const OwnerActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: const [
        PrimeCareActionItem(
          title: 'Equity Report',
          icon: LucideIcons.pieChart,
          route: '/owner/equity',
        ),
        PrimeCareActionItem(
          title: 'Distribution',
          icon: LucideIcons.banknote,
          route: '/owner/distribution',
        ),
        PrimeCareActionItem(
          title: 'Board Resolutions',
          icon: LucideIcons.fileText,
          route: '/owner/resolutions',
        ),
        PrimeCareActionItem(
          title: 'Tax Planning',
          icon: LucideIcons.calculator,
          route: '/owner/tax',
        ),
      ],
    );
  }
}
