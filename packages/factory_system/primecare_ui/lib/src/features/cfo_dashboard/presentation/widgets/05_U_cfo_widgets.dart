// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A card displaying AI-driven cash flow forecasting.
class CashFlowForecastCard extends StatelessWidget {
  final AnalyticsChart chart;

  const CashFlowForecastCard({super.key, required this.chart});

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
                  Text('Fiscal Velocity Forecast', style: theme.typography.h3),
                  Text(
                    'AI-projected cash flow and liquidity trends',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              PrimeCareStatusBadge(
                label: 'AI-OPTIMIZED',
                type: BadgeType.success,
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

/// A grid showing the health and reconciliation status of key ledger accounts.
class LedgerHealthGrid extends StatelessWidget {
  const LedgerHealthGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ledger Integrity Monitor', style: theme.typography.h3),
          Text(
            'Real-time reconciliation status of double-entry accounts',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Account', 'Balance', 'Variance', 'Status'],
            rows: [
              _buildRow('Operating Fund', '\$1,240,500', '0.02%', 'BALANCED'),
              _buildRow('Accounts Receivable', '\$450,200', '1.5%', 'REVIEW'),
              _buildRow('Payroll Clearing', '\$120,000', '0.0%', 'BALANCED'),
              _buildRow('Tax Liability', '\$85,000', '0.1%', 'PENDING'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String account,
    String balance,
    String variance,
    String status,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(account)),
        DataCell(
          Text(balance, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(Text(variance)),
        DataCell(
          PrimeCareStatusBadge(label: status, type: _getBadgeType(status)),
        ),
      ],
    );
  }

  BadgeType _getBadgeType(String status) {
    switch (status) {
      case 'BALANCED':
        return BadgeType.success;
      case 'REVIEW':
        return BadgeType.danger;
      case 'PENDING':
        return BadgeType.warning;
      default:
        return BadgeType.neutral;
    }
  }
}

/// Tracking tax remittance status and deadlines.
class TaxComplianceTracker extends StatelessWidget {
  const TaxComplianceTracker({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tax Governance Hub', style: theme.typography.h3),
          Text(
            'Remittance status for HST/GST and Corporate Tax',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          Row(
            children: [
              _buildTaxMetric(context, 'Q1 HST', 'Remitted', true),
              const Spacer(),
              _buildTaxMetric(context, 'Q2 GST', 'Due in 14d', false),
              const Spacer(),
              _buildTaxMetric(context, 'Corp Tax', 'Estimated', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaxMetric(
    BuildContext context,
    String label,
    String status,
    bool completed,
  ) {
    final theme = context.theme;
    return Column(
      children: [
        Text(label, style: theme.typography.labelLarge),
        SizedBox(height: theme.spacing.xs),
        PrimeCareStatusBadge(
          label: status,
          type: completed ? BadgeType.success : BadgeType.info,
        ),
      ],
    );
  }
}

/// Fiscal action hub for the CFO.
class CfoActionHub extends StatelessWidget {
  const CfoActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: const [
        PrimeCareActionItem(
          title: 'Approve Budget',
          icon: LucideIcons.checkSquare,
          route: '/finance/budget',
        ),
        PrimeCareActionItem(
          title: 'Reconcile',
          icon: LucideIcons.refreshCw,
          route: '/finance/reconcile',
        ),
        PrimeCareActionItem(
          title: 'Tax Filing',
          icon: LucideIcons.fileText,
          route: '/finance/tax',
        ),
        PrimeCareActionItem(
          title: 'Capital Plan',
          icon: LucideIcons.trendingUp,
          route: '/finance/capital',
        ),
      ],
    );
  }
}
