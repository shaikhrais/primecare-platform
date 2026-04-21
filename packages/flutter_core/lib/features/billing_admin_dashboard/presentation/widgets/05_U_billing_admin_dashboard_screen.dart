// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// High-Fidelity Billing Administrator Dashboard
/// Focuses on revenue cycle management, claims processing, and financial reconciliation.
class BillingAdminDashboardScreen extends ConsumerWidget {
  final dynamic data;
  
  const BillingAdminDashboardScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = PrimeCareTheme.of(context);
    
    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, theme),
            SizedBox(height: theme.spacing.xl),
            _buildFinancialOverview(context, theme),
            SizedBox(height: theme.spacing.xl),
            _buildBillingPipeline(context, theme),
            SizedBox(height: theme.spacing.xl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildOutstandingReceivables(context, theme)),
                SizedBox(width: theme.spacing.xl),
                Expanded(flex: 2, child: _buildClaimRejections(context, theme)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, PrimeCareThemeData theme) {
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
                  'Billing & Revenue Command',
                  style: theme.typography.h2,
                ),
                Text(
                  'Revenue Cycle Management • Live Financial Ledger',
                  style: theme.typography.label.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          ClinicalGlassButton(
            label: 'Generate Batch',
            icon: LucideIcons.files,
            onPressed: () {},
          ),
          SizedBox(width: theme.spacing.md),
          ClinicalGlassButton(
            label: 'Submit Claims',
            icon: LucideIcons.send,
            onPressed: () {},
            isPrimary: true,
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialOverview(BuildContext context, PrimeCareThemeData theme) {
    return Row(
      children: [
        _buildFinancialCard(theme, 'Monthly Billables', PrimeCareFormatters.formatCurrency(2400000, isCompact: true), '+8% vs LY', LucideIcons.dollarSign, theme.colors.emeraldTeal),
        SizedBox(width: theme.spacing.lg),
        _buildFinancialCard(theme, 'Outstanding A/R', PrimeCareFormatters.formatCurrency(842000, isCompact: true), '14% Overdue', LucideIcons.clock, theme.colors.amberWarning),
        SizedBox(width: theme.spacing.lg),
        _buildFinancialCard(theme, 'Claim Pass Rate', PrimeCareFormatters.formatPercentage(0.964), 'Optimal', LucideIcons.checkCircle2, theme.colors.emeraldTeal),
        SizedBox(width: theme.spacing.lg),
        _buildFinancialCard(theme, 'Unbilled Revenue', PrimeCareFormatters.formatCurrency(124000, isCompact: true), 'Action Needed', LucideIcons.alertTriangle, theme.colors.primary),
      ],
    );
  }

  Widget _buildFinancialCard(PrimeCareThemeData theme, String label, String value, String footer, IconData icon, Color color) {
    return Expanded(
      child: ClinicalGlassPanel(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const Spacer(),
                Text(
                  footer,
                  style: theme.typography.labelSmall.copyWith(color: color, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: theme.spacing.md),
            Text(
              value,
              style: theme.typography.h2.copyWith(fontWeight: FontWeight.w900),
            ),
            SizedBox(height: theme.spacing.xxs),
            Text(label, style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray)),
          ],
        ),
      ),
    );
  }

  Widget _buildBillingPipeline(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
      title: 'Billing Cycle Pipeline',
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildPipelineNode(theme, 'Provisioned', PrimeCareFormatters.formatCurrency(1200000, isCompact: true), 0.95, theme.colors.primary),
          _buildPipelineNode(theme, 'Validated', PrimeCareFormatters.formatCurrency(940000, isCompact: true), 0.85, theme.colors.emeraldTeal),
          _buildPipelineNode(theme, 'Submitted', PrimeCareFormatters.formatCurrency(812000, isCompact: true), 0.70, theme.colors.primary),
          _buildPipelineNode(theme, 'Paid', PrimeCareFormatters.formatCurrency(640000, isCompact: true), 0.55, theme.colors.emeraldTeal),
        ],
      ),
    );
  }

  Widget _buildPipelineNode(PrimeCareThemeData theme, String label, String amount, double progress, Color color) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 6,
                backgroundColor: theme.colors.surfaceContainerHighest,
                color: color,
              ),
            ),
            Text(amount, style: theme.typography.bodySmall.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: theme.spacing.sm),
        Text(label, style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildOutstandingReceivables(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
      title: 'A/R Aging Analysis',
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        children: [
          _buildAgingRow(theme, '0-30 Days', 0.82, PrimeCareFormatters.formatCurrency(420000, isCompact: true), theme.colors.emeraldTeal),
          _buildAgingRow(theme, '31-60 Days', 0.12, PrimeCareFormatters.formatCurrency(64000, isCompact: true), theme.colors.primary),
          _buildAgingRow(theme, '61-90 Days', 0.04, PrimeCareFormatters.formatCurrency(22000, isCompact: true), theme.colors.amberWarning),
          _buildAgingRow(theme, '90+ Days', 0.02, PrimeCareFormatters.formatCurrency(8000, isCompact: true), theme.colors.roseRed),
        ],
      ),
    );
  }

  Widget _buildAgingRow(PrimeCareThemeData theme, String label, double weight, String amount, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.md),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label, style: theme.typography.bodyLarge)),
          Expanded(
            child: LinearProgressIndicator(
              value: weight,
              backgroundColor: theme.colors.surfaceContainerHighest,
              color: color,
              minHeight: 12,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          SizedBox(width: theme.spacing.lg),
          Text(amount, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildClaimRejections(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
      title: 'Top Rejection Reasons',
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        children: [
          _buildRejectionItem(theme, 'Missing Modifier', '14%', theme.colors.roseRed),
          const Divider(),
          _buildRejectionItem(theme, 'Coverage Expired', '12%', theme.colors.amberWarning),
          const Divider(),
          _buildRejectionItem(theme, 'Incomplete DX Code', '8%', theme.colors.primary),
          const Divider(),
          _buildRejectionItem(theme, 'Duplicate Claim', '4%', theme.colors.emeraldTeal),
        ],
      ),
    );
  }

  Widget _buildRejectionItem(PrimeCareThemeData theme, String label, String percentage, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Row(
        children: [
          Text(label, style: theme.typography.bodyMedium.copyWith(color: theme.colors.slateGray)),
          const Spacer(),
          Text(percentage, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}

