// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// High-Fidelity HR & Hiring Manager Dashboard
/// Focuses on recruitment pipeline, staff retention, payroll efficiency, and certification compliance.
class HrManagerDashboardScreen extends ConsumerWidget {
  final dynamic data;
  
  const HrManagerDashboardScreen({super.key, this.data});

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
            _buildWorkforceOverview(context, theme),
            SizedBox(height: theme.spacing.xl),
            _buildRecruitmentPipeline(context, theme),
            SizedBox(height: theme.spacing.xl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildCertificationCompliance(context, theme)),
                SizedBox(width: theme.spacing.xl),
                Expanded(flex: 2, child: _buildRetentionAnalytics(context, theme)),
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
                  'Human Resources Hub',
                  style: theme.typography.h2,
                ),
                Text(
                  'Talent Acquisition & Workforce Health',
                  style: theme.typography.labelSmall.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          PrimeCareButton(
            label: 'Post New Job',
            icon: LucideIcons.userPlus,
            onPressed: () {},
            type: PrimeCareButtonType.secondary,
          ),
          SizedBox(width: theme.spacing.md),
          PrimeCareButton(
            label: 'Payroll Audit',
            icon: LucideIcons.banknote,
            onPressed: () {},
            type: PrimeCareButtonType.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildWorkforceOverview(BuildContext context, PrimeCareThemeData theme) {
    return Row(
      children: [
        _buildHRCard(theme, 'Total Employees', '842', 'Active', LucideIcons.users, theme.colors.primary),
        SizedBox(width: theme.spacing.lg),
        _buildHRCard(theme, 'Retention Rate', '94.2%', '+2.1% YoY', LucideIcons.heartHandshake, theme.colors.success),
        SizedBox(width: theme.spacing.lg),
        _buildHRCard(theme, 'Open Positions', '28', '12 Urgent', LucideIcons.briefcase, theme.colors.warning),
        SizedBox(width: theme.spacing.lg),
        _buildHRCard(theme, 'Avg Time to Hire', '12 Days', '-3 Days', LucideIcons.timer, theme.colors.success),
      ],
    );
  }

  Widget _buildHRCard(PrimeCareThemeData theme, String label, String value, String footer, IconData icon, Color color) {
    return Expanded(
      child: PrimeCareCard(
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
            SizedBox(height: theme.spacing.xxs),
            Text(label, style: theme.typography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
            Text(footer, style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecruitmentPipeline(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Active Recruitment Pipeline', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPipelineStage(theme, 'Applied', 142, theme.colors.primary, 0.8),
              _buildPipelineStage(theme, 'Screening', 48, theme.colors.warning, 0.5),
              _buildPipelineStage(theme, 'Interview', 12, theme.colors.success, 0.3),
              _buildPipelineStage(theme, 'Offer', 4, theme.colors.success, 0.1),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPipelineStage(PrimeCareThemeData theme, String label, int count, Color color, double heightFactor) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 120 * heightFactor + 20,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(theme.spacing.sm),
            border: Border.all(color: color.withValues(alpha: 0.2)),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 120 * heightFactor,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(theme.spacing.xs)),
            ),
            child: Center(
              child: Text(
                '$count',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        SizedBox(height: theme.spacing.sm),
        Text(label, style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildCertificationCompliance(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Staff Certification Compliance', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildComplianceRow(theme, 'RN/RPN Licenses', 0.98, '3 Expiring Soon'),
          _buildComplianceRow(theme, 'Vulnerable Sector Checks', 1.0, 'Compliant'),
          _buildComplianceRow(theme, 'CPR/First Aid', 0.85, '12 Staff Overdue'),
          _buildComplianceRow(theme, 'Privacy Training (PHIPA)', 0.92, '8 In Progress'),
        ],
      ),
    );
  }

  Widget _buildComplianceRow(PrimeCareThemeData theme, String label, double progress, String status) {
    final color = progress == 1.0 ? theme.colors.success : (progress > 0.9 ? theme.colors.primary : theme.colors.warning);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.md),
      child: Column(
        children: [
          Row(
            children: [
              Text(label, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
              const Spacer(),
              Text(status, style: theme.typography.labelSmall.copyWith(color: color)),
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

  Widget _buildRetentionAnalytics(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Retention Analytics', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildRetentionItem(theme, 'Employee Satisfaction', '4.8/5.0', theme.colors.success),
          const Divider(),
          _buildRetentionItem(theme, 'Avg Tenacity', '3.2 Years', theme.colors.primary),
          const Divider(),
          _buildRetentionItem(theme, 'Exit Rate (Monthly)', '0.4%', theme.colors.success),
          const Divider(),
          _buildRetentionItem(theme, 'Training Completion', '92%', theme.colors.success),
        ],
      ),
    );
  }

  Widget _buildRetentionItem(PrimeCareThemeData theme, String label, String value, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Row(
        children: [
          Text(label, style: theme.typography.bodyMedium.copyWith(color: theme.colors.slateGray)),
          const Spacer(),
          Text(value, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
