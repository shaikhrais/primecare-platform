// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// High-Fidelity CEO Leadership Dashboard
/// Focuses on institutional health, revenue growth, and strategic compliance.
class CeoDashboardScreen extends ConsumerWidget {
  final DashboardMetrics? data;
  
  const CeoDashboardScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    
    // Fallback to empty if no data provided
    final metrics = data ?? DashboardMetrics.empty();
    
    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, theme),
            SizedBox(height: theme.spacing.xl),
            _buildExecutiveSummary(context, theme),
            SizedBox(height: theme.spacing.xl),
            
            // Modern standardized KPI Grid
            PrimeCareResponsiveKpiGrid(metrics: metrics),
            
            SizedBox(height: theme.spacing.xl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildBranchPerformance(context, theme)),
                SizedBox(width: theme.spacing.xl),
                Expanded(flex: 2, child: _buildStrategicAlerts(context, theme)),
              ],
            ),
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
                  'Executive Leadership Dashboard',
                  style: theme.typography.h2,
                ),
                Text(
                  'Institutional Overview • Q2 2026 • CEO Office',
                  style: theme.typography.label.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          PrimeCareButton(
            label: 'Export Report',
            icon: LucideIcons.download,
            onPressed: () {},
          ),
          SizedBox(width: theme.spacing.sm),
          PrimeCareButton(
            label: 'Strategic Plan',
            icon: LucideIcons.target,
            onPressed: () {},
            type: PrimeCareButtonType.secondary,
          ),
        ],
      ),
    );
  }

  Widget _buildExecutiveSummary(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'INSTITUTIONAL HEALTH INDEX',
                  style: theme.typography.label.copyWith(
                    color: theme.colors.primary,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: theme.spacing.sm),
                Text(
                  'System Status: Optimal',
                  style: theme.typography.h1,
                ),
                SizedBox(height: theme.spacing.xs),
                Text(
                  'All 14 regions are operating within target variance. Revenue is up 12% YoY.',
                  style: theme.typography.bodyLarge.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          _buildHealthGauge(theme, 0.94),
        ],
      ),
    );
  }

  Widget _buildHealthGauge(PrimeCareThemeData theme, double value) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: value,
            strokeWidth: 12,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: theme.colors.success,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                PrimeCareFormatters.formatPercentage(value),
                style: theme.typography.h2.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'H-Index',
                style: theme.typography.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBranchPerformance(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Regional Performance', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildBranchRow(theme, 'Ontario North', 0.88, theme.colors.success),
          _buildBranchRow(theme, 'Toronto Enterprise', 0.94, theme.colors.success),
          _buildBranchRow(theme, 'BC Regional', 0.72, theme.colors.warning),
          _buildBranchRow(theme, 'Quebec Hub', 0.81, theme.colors.success),
          _buildBranchRow(theme, 'Alberta East', 0.64, theme.colors.error),
        ],
      ),
    );
  }

  Widget _buildBranchRow(PrimeCareThemeData theme, String name, double progress, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                name, 
                style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(' Target', style: theme.typography.label),
            ],
          ),
          SizedBox(height: theme.spacing.xs),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildStrategicAlerts(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Strategic Alerts', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildAlertItem(theme, 'Capacity Warning', 'Ontario North reaching 95% bed capacity by next week.', LucideIcons.alertTriangle, theme.colors.warning),
          const Divider(),
          _buildAlertItem(theme, 'Revenue Opportunity', 'Home Care services in BC can be optimized for 5% margin gain.', LucideIcons.lightbulb, theme.colors.primary),
          const Divider(),
          _buildAlertItem(theme, 'Compliance Deadline', 'Annual institutional audit due in 14 days.', LucideIcons.calendar, theme.colors.error),
        ],
      ),
    );
  }

  Widget _buildAlertItem(PrimeCareThemeData theme, String title, String description, IconData icon, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: theme.spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title, 
                  style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: theme.spacing.xxs),
                Text(
                  description, 
                  style: theme.typography.bodyMedium.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
