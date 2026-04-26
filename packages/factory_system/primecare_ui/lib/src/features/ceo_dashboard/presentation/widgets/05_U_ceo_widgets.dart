// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A global performance heatmap showing financial and operational health.
class GlobalPerformanceHeatmap extends StatelessWidget {
  final AnalyticsChart chart;

  const GlobalPerformanceHeatmap({super.key, required this.chart});

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
                    'Global Performance Heatmap',
                    style: theme.typography.h3,
                  ),
                  Text(
                    'Consolidated operational and financial velocity',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              PrimeCareButton(
                label: 'EXPORT REPORT',
                type: PrimeCareButtonType.text,
                onPressed: () {},
                icon: LucideIcons.download,
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

/// A grid showing synergy and performance across different corporate offices.
class MultiOfficePerformanceGrid extends StatelessWidget {
  const MultiOfficePerformanceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Institutional Synergy Grid', style: theme.typography.h3),
          Text(
            'Cross-office performance metrics and audit status',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Office', 'Health Index', 'Compliance', 'Action'],
            rows: [
              _buildRow('Clinical Operations', '98%', 'Verified', 'SUCCESS'),
              _buildRow('Business Development', '85%', 'Pending', 'CAUTION'),
              _buildRow('Franchise Network', '92%', 'Verified', 'SUCCESS'),
              _buildRow('Corporate Finance', '78%', 'In-Audit', 'INFO'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String office,
    String health,
    String compliance,
    String status,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Text(office, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(Text(health)),
        DataCell(Text(compliance)),
        DataCell(
          PrimeCareStatusBadge(label: status, type: _getBadgeType(status)),
        ),
      ],
    );
  }

  BadgeType _getBadgeType(String status) {
    switch (status) {
      case 'SUCCESS':
        return BadgeType.success;
      case 'CAUTION':
        return BadgeType.warning;
      case 'INFO':
        return BadgeType.info;
      default:
        return BadgeType.neutral;
    }
  }
}

/// Strategic action hub for the CEO.
class CeoActionHub extends StatelessWidget {
  CeoActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: [
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_board_report.tr(),
          icon: LucideIcons.presentation,
          route: '/reports/board',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_global_audit.tr(),
          icon: LucideIcons.shieldCheck,
          route: '/audit/global',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_strategic_plan.tr(),
          icon: LucideIcons.target,
          route: '/strategy/plan',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_capital_request.tr(),
          icon: LucideIcons.banknote,
          route: '/finance/capital',
        ),
      ],
    );
  }
}
