// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// [FinanceDirectorDashboardScreen] provides a high-fidelity operational view of the clinic's
/// financial health, focusing on Ledger balance, Tax compliance, and Audit readiness.
class FinanceDirectorDashboardScreen extends ConsumerWidget {
  final dynamic data;
  
  const FinanceDirectorDashboardScreen({super.key, this.data});

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
            _buildBalanceSummary(context, theme),
            SizedBox(height: theme.spacing.lg),
            _buildOperationalMetrics(context, theme),
            SizedBox(height: theme.spacing.lg),
            _buildTreasuryPulse(context, theme),
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
                  'Finance & Treasury Operations',
                  style: theme.typography.h2,
                ),
                Text(
                  'Institutional Ledger Control • Finance Director',
                  style: theme.typography.labelSmall.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          const ClinicalSearchTextField(
            hintText: 'Search ledger entries...',
            width: 300,
          ),
          SizedBox(width: theme.spacing.md),
          PrimeCareButton(
            onPressed: () {},
            label: 'Generate Tax Report',
            icon: LucideIcons.fileText,
            type: PrimeCareButtonType.secondary,
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceSummary(BuildContext context, PrimeCareThemeData theme) {
    return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: theme.spacing.md,
      mainAxisSpacing: theme.spacing.md,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildFinanceCard(
          context,
          theme,
          title: 'Accounts Receivable',
          value: PrimeCareFormatters.formatCurrency(1240500),
          subtitle: '98 Pending Payors',
          icon: LucideIcons.arrowDownLeft,
          color: theme.colors.success,
        ),
        _buildFinanceCard(
          context,
          theme,
          title: 'Accounts Payable',
          value: PrimeCareFormatters.formatCurrency(842100),
          subtitle: 'Due in < 15 Days',
          icon: LucideIcons.arrowUpRight,
          color: theme.colors.error,
        ),
        _buildFinanceCard(
          context,
          theme,
          title: 'Tax Remittance',
          value: PrimeCareFormatters.formatCurrency(156000),
          subtitle: 'Q3 HST Estimated',
          icon: LucideIcons.calculator,
          color: theme.colors.warning,
        ),
        _buildFinanceCard(
          context,
          theme,
          title: 'Audit Score',
          value: PrimeCareFormatters.formatPercentage(0.98),
          subtitle: 'Compliance Ready',
          icon: LucideIcons.shieldCheck,
          color: theme.colors.primary,
        ),
      ],
    );
  }

  Widget _buildFinanceCard(
    BuildContext context,
    PrimeCareThemeData theme, {
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(theme.spacing.xs),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(theme.spacing.xs),
            ),
            child: Icon(icon, color: color, size: 20),
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
          SizedBox(height: theme.spacing.xxs),
          Text(
            subtitle,
            style: theme.typography.bodySmall.copyWith(
              color: theme.colors.slateGray.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOperationalMetrics(BuildContext context, PrimeCareThemeData theme) {
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
                Text('Cash Flow Projection (Rolling 12M)', style: theme.typography.titleLarge),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: theme.colors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(theme.spacing.md),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.barChart3,
                          size: 48,
                          color: theme.colors.slateGray.withValues(alpha: 0.2),
                        ),
                        SizedBox(height: theme.spacing.md),
                        Text(
                          'AI Cash Flow Forecasting Active',
                          style: theme.typography.bodyMedium.copyWith(
                            color: theme.colors.slateGray.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
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
                Text('Audit Trait Compliance', style: theme.typography.titleLarge),
                SizedBox(height: theme.spacing.md),
                _buildComplianceItem(theme, 'Expense Validation', 0.95),
                _buildComplianceItem(theme, 'Payroll Matching', 1.0),
                _buildComplianceItem(theme, 'Billable Sync', 0.88),
                _buildComplianceItem(theme, 'Inventory Value', 0.92),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildComplianceItem(PrimeCareThemeData theme, String label, double progress) {
    return Padding(
      padding: EdgeInsets.only(bottom: theme.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
              Text(PrimeCareFormatters.formatPercentage(progress), style: theme.typography.labelSmall),
            ],
          ),
          SizedBox(height: theme.spacing.sm),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: theme.colors.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(
              progress == 1.0 ? theme.colors.success : theme.colors.primary,
            ),
            minHeight: 4,
            borderRadius: BorderRadius.circular(theme.spacing.xxs),
          ),
        ],
      ),
    );
  }

  Widget _buildTreasuryPulse(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Recent Treasury Transactions', style: theme.typography.titleLarge),
              const Spacer(),
              PrimeCareButton(
                onPressed: () {},
                label: 'View Reconciliation Report',
                type: PrimeCareButtonType.text,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.lg),
          Column(
            children: [
              _buildTreasuryItem(
                theme,
                'HST Quarter Remittance - Canada Revenue',
                PrimeCareFormatters.formatCurrency(-45200.00),
                'Pending Approval',
                LucideIcons.landmark,
                theme.colors.warning,
              ),
              _buildTreasuryItem(
                theme,
                'Institutional Grant: Health Canada',
                PrimeCareFormatters.formatCurrency(250500.00),
                'Cleared',
                LucideIcons.award,
                theme.colors.success,
              ),
              _buildTreasuryItem(
                theme,
                'Regional Operations Disbursement',
                PrimeCareFormatters.formatCurrency(-120400.00),
                'In Progress',
                LucideIcons.send,
                theme.colors.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTreasuryItem(
    PrimeCareThemeData theme,
    String title,
    String amount,
    String status,
    IconData icon,
    Color statusColor,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: theme.spacing.sm),
      child: Container(
        padding: EdgeInsets.all(theme.spacing.md),
        decoration: BoxDecoration(
          color: theme.colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(theme.spacing.md),
          border: Border.all(
            color: theme.colors.slateGray.withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: theme.colors.slateGray),
            SizedBox(width: theme.spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                  Text(
                    status,
                    style: theme.typography.labelSmall.copyWith(
                      color: statusColor, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: theme.typography.h3.copyWith(
                fontWeight: FontWeight.bold,
                color: amount.startsWith('+') ? theme.colors.success : theme.colors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

