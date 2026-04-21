// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// High-Fidelity CEO Strategic Dashboard
class CeoDashboardViewModelScreen extends ConsumerWidget {
  final dynamic data;
  
  const CeoDashboardViewModelScreen({super.key, this.data});

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
            _buildStrategicMetrics(context, theme),
            SizedBox(height: theme.spacing.xl),
            _buildInstitutionalPerformance(context, theme),
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
                  'CEO Executive Suite',
                  style: theme.typography.h2,
                ),
                Text(
                  'Enterprise Vision • Institutional Health • Strategic Growth',
                  style: theme.typography.label.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          PrimeCareButton(
            label: 'Executive Summary',
            icon: LucideIcons.fileSpreadsheet,
            onPressed: () {},
          ),
          SizedBox(width: theme.spacing.md),
          PrimeCareButton(
            label: 'Network Expansion',
            icon: LucideIcons.network,
            onPressed: () {},
            type: PrimeCareButtonType.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildStrategicMetrics(BuildContext context, PrimeCareThemeData theme) {
    return Row(
      children: [
        _buildMetricCard(theme, 'Network Revenue', '\$4.2M', '+12.4%', LucideIcons.trendingUp, theme.colors.success),
        SizedBox(width: theme.spacing.lg),
        _buildMetricCard(theme, 'Total Institutions', '18', '2 Upcoming', LucideIcons.home, theme.colors.primary),
        SizedBox(width: theme.spacing.lg),
        _buildMetricCard(theme, 'Quality Index', '96.2%', 'Exemplary', LucideIcons.award, theme.colors.success),
        SizedBox(width: theme.spacing.lg),
        _buildMetricCard(theme, 'Staff Health', '94%', 'Stable', LucideIcons.heartPulse, theme.colors.primary),
      ],
    );
  }

  Widget _buildMetricCard(PrimeCareThemeData theme, String label, String value, String trend, IconData icon, Color color) {
    return Expanded(
      child: PrimeCareCard(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            SizedBox(height: theme.spacing.md),
            Text(value, style: theme.typography.h2.copyWith(fontWeight: FontWeight.w900)),
            Text(label, style: theme.typography.label.copyWith(fontWeight: FontWeight.bold)),
            Text(trend, style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray)),
          ],
        ),
      ),
    );
  }

  Widget _buildInstitutionalPerformance(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        children: [
          _buildPerformanceRow(theme, 'Ontario North Region', 0.94, 'Exceeding Targets'),
          SizedBox(height: theme.spacing.md),
          _buildPerformanceRow(theme, 'Ontario West Region', 0.82, 'Review Required'),
          SizedBox(height: theme.spacing.md),
          _buildPerformanceRow(theme, 'New York Metro Hub', 0.98, 'Market Leader'),
          SizedBox(height: theme.spacing.md),
          _buildPerformanceRow(theme, 'Florida Senior Care Network', 0.88, 'Growth Phase'),
        ],
      ),
    );
  }

  Widget _buildPerformanceRow(PrimeCareThemeData theme, String region, double index, String status) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(region, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          flex: 3,
          child: LinearProgressIndicator(
            value: index,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: index > 0.9 ? theme.colors.success : (index > 0.85 ? theme.colors.primary : theme.colors.warning),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: theme.spacing.xl),
        Text(status, style: theme.typography.label.copyWith(color: theme.colors.slateGray)),
      ],
    );
  }
}
