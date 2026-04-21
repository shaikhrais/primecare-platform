// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// High-Fidelity Regional Business Development Manager Dashboard
/// Focuses on regional revenue, sales pipeline, and facility growth.
class RegionalBdmDashboardScreen extends ConsumerWidget {
  final dynamic data;
  
  const RegionalBdmDashboardScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = PrimeCareTheme.of(context);
    
    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBusinessHeader(context, theme),
            SizedBox(height: theme.spacing.xl),
            _buildRevenueMetrics(context, theme),
            SizedBox(height: theme.spacing.xl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildSalesPipeline(context, theme)),
                SizedBox(width: theme.spacing.xl),
                Expanded(flex: 3, child: _buildRegionalPerformance(context, theme)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessHeader(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
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
                  'Regional Business Development',
                  style: theme.typography.h2,
                ),
                Text(
                  'Q3 Target Tracking • Sales Pipeline • Market Expansion',
                  style: theme.typography.label.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          ClinicalGlassButton(
            label: 'Sales Report',
            icon: LucideIcons.fileText,
            onPressed: () {},
          ),
          SizedBox(width: theme.spacing.md),
          ClinicalGlassButton(
            label: 'New Opportunity',
            icon: LucideIcons.plusCircle,
            onPressed: () {},
            isPrimary: true,
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueMetrics(BuildContext context, PrimeCareThemeData theme) {
    return Row(
      children: [
        _buildMetricCard(theme, 'Monthly Revenue', PrimeCareFormatters.formatCurrency(4200000, isCompact: true), '+12%', LucideIcons.trendingUp, theme.colors.emeraldTeal),
        SizedBox(width: theme.spacing.lg),
        _buildMetricCard(theme, 'Pipeline Value', PrimeCareFormatters.formatCurrency(18500000, isCompact: true), 'High Intent', LucideIcons.dollarSign, theme.colors.primary),
        SizedBox(width: theme.spacing.lg),
        _buildMetricCard(theme, 'Retention Rate', PrimeCareFormatters.formatPercentage(0.942), 'Stable', LucideIcons.users, theme.colors.emeraldTeal),
        SizedBox(width: theme.spacing.lg),
        _buildMetricCard(theme, 'Churn Risk', '2 Accounts', 'Action Required', LucideIcons.alertTriangle, theme.colors.roseRed),
      ],
    );
  }

  Widget _buildMetricCard(PrimeCareThemeData theme, String label, String value, String trend, IconData icon, Color color) {
    return Expanded(
      child: ClinicalGlassPanel(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: theme.spacing.md),
            Text(
              value,
              style: theme.typography.h2.copyWith(fontWeight: FontWeight.w900),
            ),
            Text(label, style: theme.typography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
            Text(trend, style: theme.typography.labelSmall.copyWith(color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesPipeline(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
      title: 'Active Pipeline',
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        children: [
          _buildPipelineStage(theme, 'Discovery', 12, theme.colors.slateGray),
          _buildPipelineStage(theme, 'Proposal', 8, theme.colors.primary),
          _buildPipelineStage(theme, 'Negotiation', 5, theme.colors.amberWarning),
          _buildPipelineStage(theme, 'Closing', 3, theme.colors.emeraldTeal),
        ],
      ),
    );
  }

  Widget _buildPipelineStage(PrimeCareThemeData theme, String stage, int count, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Row(
        children: [
          Container(width: 4, height: 24, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
          SizedBox(width: theme.spacing.md),
          Expanded(child: Text(stage, style: theme.typography.bodyMedium)),
          Text('\$count', style: theme.typography.bodySmall.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRegionalPerformance(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
      title: 'Facility Performance Matrix',
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        children: [
          _buildFacilityRow(theme, 'Oakwood Heights', 0.98, 'In-Region'),
          _buildFacilityRow(theme, 'Maplewood Center', 0.82, 'In-Region'),
          _buildFacilityRow(theme, 'Pinecrest Manor', 0.94, 'In-Region'),
          _buildFacilityRow(theme, 'Sunset Gardens', 0.65, 'Action Needed'),
        ],
      ),
    );
  }

  Widget _buildFacilityRow(PrimeCareThemeData theme, String name, double occupancy, String status) {
    final statusColor = occupancy > 0.9 ? theme.colors.emeraldTeal : (occupancy > 0.8 ? theme.colors.amberWarning : theme.colors.roseRed);
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.md),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                Text('Occupancy: ${PrimeCareFormatters.formatPercentage(occupancy)}', style: theme.typography.labelSmall),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.sm, vertical: theme.spacing.xxs),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(theme.spacing.xxs),
            ),
            child: Text(
              status,
              style: theme.typography.labelSmall.copyWith(color: statusColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

