// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// High-Fidelity Franchise Owner Performance Dashboard
class FranchiseOwnerDashboardViewModelScreen extends ConsumerWidget {
  final dynamic data;
  
  const FranchiseOwnerDashboardViewModelScreen({super.key, this.data});

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
            _buildBusinessOversight(context, theme),
            SizedBox(height: theme.spacing.xl),
            _buildRecentActivity(context, theme),
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
                  'Franchise Owner Dashboard',
                  style: theme.typography.h2,
                ),
                Text(
                  'Business Growth • Unit Performance • Quality Compliance',
                  style: theme.typography.labelSmall.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          PrimeCareButton(
            label: 'Generate Statement',
            icon: LucideIcons.filePlus,
            onPressed: () {},
            type: PrimeCareButtonType.secondary,
          ),
          SizedBox(width: theme.spacing.md),
          PrimeCareButton(
            label: 'Expansion Portal',
            icon: LucideIcons.trendingUp,
            onPressed: () {},
            type: PrimeCareButtonType.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessOversight(BuildContext context, PrimeCareThemeData theme) {
    return Row(
      children: [
        _buildMetricCard(theme, 'Monthly Revenue', PrimeCareFormatters.formatCurrency(184200), '+8.2%', LucideIcons.dollarSign, theme.colors.success),
        SizedBox(width: theme.spacing.lg),
        _buildMetricCard(theme, 'Active Patients', '124', 'Optimal', LucideIcons.userPlus, theme.colors.primary),
        SizedBox(width: theme.spacing.lg),
        _buildMetricCard(theme, 'Staff Count', '42', '2 Pending', LucideIcons.users, theme.colors.slateGray),
        SizedBox(width: theme.spacing.lg),
        _buildMetricCard(theme, 'Compliance Score', PrimeCareFormatters.formatPercentage(0.98), 'Exemplary', LucideIcons.checkCircle, theme.colors.success),
      ],
    );
  }

  Widget _buildMetricCard(PrimeCareThemeData theme, String label, String value, String trend, IconData icon, Color color) {
    return Expanded(
      child: PrimeCareCard(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const Spacer(),
                Text(
                  trend,
                  style: theme.typography.labelSmall.copyWith(
                    color: trend.contains('+') ? theme.colors.success : theme.colors.warning,
                  ),
                ),
              ],
            ),
            SizedBox(height: theme.spacing.md),
            Text(label, style: theme.typography.labelSmall),
            Text(value, style: theme.typography.h3),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Key Business Activities', style: theme.typography.h3),
          SizedBox(height: theme.spacing.lg),
          _buildActivityRow(theme, 'Payroll Processing', 'Completed for cycle: Oct 1-15', '2h ago', LucideIcons.calculator),
          Divider(color: theme.colors.borderLight.withValues(alpha: 0.05), height: 32),
          _buildActivityRow(theme, 'Quality Audit Result', 'Facility scored 98% in Q3 Review', 'Yesterday', LucideIcons.award),
          Divider(color: theme.colors.borderLight.withValues(alpha: 0.05), height: 32),
          _buildActivityRow(theme, 'License Renewal', 'Franchise license renewed successfully', '2 days ago', LucideIcons.shieldCheck),
        ],
      ),
    );
  }

  Widget _buildActivityRow(PrimeCareThemeData theme, String title, String desc, String time, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: theme.colors.slateGray, size: 24),
        SizedBox(width: theme.spacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.typography.bodyBold),
              Text(desc, style: theme.typography.body.copyWith(color: theme.colors.slateGray)),
            ],
          ),
        ),
        Text(time, style: theme.typography.label.copyWith(color: theme.colors.slateGray)),
      ],
    );
  }
}

