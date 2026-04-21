// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

class CfoDashboardScreen extends ConsumerWidget {
  final dynamic data;
  
  const CfoDashboardScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    
    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, theme),
            SizedBox(height: theme.spacing.xl),
            _buildKpiGrid(context, theme),
            SizedBox(height: theme.spacing.lg),
            _buildMainMetrics(context, theme),
            SizedBox(height: theme.spacing.lg),
            _buildTransactionFeed(context, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.lg,
        vertical: theme.spacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Financial Oversight Dashboard',
                  style: theme.typography.h2,
                ),
                Text(
                  'CFO Office • Enterprise Health Metrics',
                  style: theme.typography.labelSmall.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search ledger...',
                prefixIcon: const Icon(LucideIcons.search, size: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(theme.radii.md),
                ),
              ),
            ),
          ),
          SizedBox(width: theme.spacing.md),
          PrimeCareButton(
            onPressed: () {},
            label: 'Export Q3 Report',
            icon: LucideIcons.download,
          ),
        ],
      ),
    );
  }

  Widget _buildKpiGrid(BuildContext context, PrimeCareThemeData theme) {
    return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: theme.spacing.md,
      mainAxisSpacing: theme.spacing.md,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildKpiCard(
          context,
          theme,
          title: 'Total Revenue',
          value: PrimeCareFormatters.formatCurrency(4200000, isCompact: true),
          trend: '+12.5%',
          icon: LucideIcons.trendingUp,
          color: theme.colors.success,
        ),
        _buildKpiCard(
          context,
          theme,
          title: 'Operating Expenses',
          value: PrimeCareFormatters.formatCurrency(2800000, isCompact: true),
          trend: '-2.1%',
          icon: LucideIcons.calculator,
          color: theme.colors.warning,
        ),
        _buildKpiCard(
          context,
          theme,
          title: 'Net Profit Margin',
          value: PrimeCareFormatters.formatPercentage(0.425),
          trend: '+1.5%',
          icon: LucideIcons.pieChart,
          color: theme.colors.primary,
        ),
        _buildKpiCard(
          context,
          theme,
          title: 'Days Sales Out.',
          value: '42 Days',
          trend: '-4 Days',
          icon: LucideIcons.activity,
          color: theme.colors.error,
        ),
      ],
    );
  }

  Widget _buildKpiCard(
    BuildContext context,
    PrimeCareThemeData theme, {
    required String title,
    required String value,
    required String trend,
    required IconData icon,
    required Color color,
  }) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(theme.spacing.xs),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(theme.spacing.xxs),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Text(
                trend,
                style: theme.typography.labelSmall.copyWith(
                  color: trend.startsWith('+') ? theme.colors.success : color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: theme.typography.labelMedium.copyWith(
              color: theme.colors.slateGray,
            ),
          ),
          SizedBox(height: theme.spacing.xxs),
          Text(
            value,
            style: theme.typography.h3.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainMetrics(BuildContext context, PrimeCareThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Revenue vs Forecast', style: theme.typography.titleLarge),
                SizedBox(height: theme.spacing.md),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: theme.colors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(theme.radii.md),
                  ),
                  child: Center(
                    child: Text(
                      'Chart Visualization Placeholder',
                      style: theme.typography.bodySmall.copyWith(
                        color: theme.colors.slateGray.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: theme.spacing.lg),
        Expanded(
          child: PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Budget Allocation', style: theme.typography.titleLarge),
                SizedBox(height: theme.spacing.md),
                _buildBudgetRow(theme, 'Clinical Ops', 0.65),
                _buildBudgetRow(theme, 'Staffing', 0.22),
                _buildBudgetRow(theme, 'Rent/Facilities', 0.08),
                _buildBudgetRow(theme, 'Marketing', 0.05),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBudgetRow(PrimeCareThemeData theme, String label, double percent) {
    return Padding(
      padding: EdgeInsets.only(bottom: theme.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.w500)),
              Text(PrimeCareFormatters.formatPercentage(percent), style: theme.typography.labelSmall),
            ],
          ),
          SizedBox(height: theme.spacing.xs),
          LinearProgressIndicator(
            value: percent,
            backgroundColor: theme.colors.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(theme.colors.primary),
            borderRadius: BorderRadius.circular(theme.spacing.xxs),
            minHeight: 6,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionFeed(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Ledger Activity', style: theme.typography.titleLarge),
              PrimeCareButton(
                onPressed: () {},
                type: PrimeCareButtonType.text,
                label: 'View All Ledger',
              ),
            ],
          ),
          SizedBox(height: theme.spacing.md),
          _buildTransactionItem(
            theme,
            'Vendor Payout: Medical Supplies Inc',
            PrimeCareFormatters.formatCurrency(-12400.00),
            'Processing',
            LucideIcons.arrowUpRight,
          ),
          _buildTransactionItem(
            theme,
            'Insurance Disbursement: Blue Cross',
            PrimeCareFormatters.formatCurrency(45210.00),
            'Completed',
            LucideIcons.arrowDownLeft,
          ),
          _buildTransactionItem(
            theme,
            'Payroll: Regional Clinic A',
            PrimeCareFormatters.formatCurrency(-88200.00),
            'Completed',
            LucideIcons.users,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
    PrimeCareThemeData theme,
    String title,
    String amount,
    String status,
    IconData icon,
  ) {
    final isPositive = amount.startsWith('+');
    return Container(
      margin: EdgeInsets.only(bottom: theme.spacing.sm),
      padding: EdgeInsets.all(theme.spacing.md),
      decoration: BoxDecoration(
        color: theme.colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(theme.spacing.md),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(theme.spacing.sm),
            decoration: BoxDecoration(
              color: theme.colors.surfaceContainerHigh,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: theme.colors.slateGray),
          ),
          SizedBox(width: theme.spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                Text(status, style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray)),
              ],
            ),
          ),
          Text(
            amount,
            style: theme.typography.h3.copyWith(
              color: isPositive ? theme.colors.success : theme.colors.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

