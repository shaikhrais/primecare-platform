// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// High-Fidelity Compliance & Quality Assurance Dashboard
/// Focuses on regulatory adherence, safety incidents, audit outcomes, and policy versioning.
class ComplianceManagerDashboardScreen extends ConsumerWidget {
  final dynamic data;
  
  const ComplianceManagerDashboardScreen({super.key, this.data});

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
            _buildCompliancePulse(context, theme),
            SizedBox(height: theme.spacing.xl),
            _buildSafetyIncidentHeatmap(context, theme),
            SizedBox(height: theme.spacing.xl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildRegulatoryTimeline(context, theme)),
                SizedBox(width: theme.spacing.xl),
                Expanded(flex: 2, child: _buildPolicyHealth(context, theme)),
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
                  'Compliance & Quality Command',
                  style: theme.typography.h2,
                ),
                Text(
                  'Regulatory Vigilance • Institutional Safety',
                  style: theme.typography.label.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          PrimeCareButton(
            label: 'New Incident',
            icon: LucideIcons.alertOctagon,
            onPressed: () {},
          ),
          SizedBox(width: theme.spacing.md),
          PrimeCareButton(
            label: 'Start Audit',
            icon: LucideIcons.fileCheck2,
            onPressed: () {},
            type: PrimeCareButtonType.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildCompliancePulse(BuildContext context, PrimeCareThemeData theme) {
    return Row(
      children: [
        _buildComplianceCard(theme, 'Regulatory Score', PrimeCareFormatters.formatNumber(98.2), 'Superior', LucideIcons.shieldCheck, theme.colors.success),
        SizedBox(width: theme.spacing.lg),
        _buildComplianceCard(theme, 'Open Incidents', PrimeCareFormatters.formatNumber(4), '2 High Priority', LucideIcons.flag, theme.colors.error),
        SizedBox(width: theme.spacing.lg),
        _buildComplianceCard(theme, 'Audit Readiness', PrimeCareFormatters.formatPercentage(1.0), 'Accreditation Ready', LucideIcons.checkCircle2, theme.colors.success),
        SizedBox(width: theme.spacing.lg),
        _buildComplianceCard(theme, 'Missing Docs', PrimeCareFormatters.formatNumber(12), 'Staff Credentials', LucideIcons.fileWarning, theme.colors.warning),
      ],
    );
  }

  Widget _buildComplianceCard(PrimeCareThemeData theme, String label, String value, String status, IconData icon, Color color) {
    return Expanded(
      child: PrimeCareCard(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(theme.spacing.sm),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(height: theme.spacing.md),
            Text(
              value,
              style: theme.typography.h2.copyWith(fontWeight: FontWeight.w900),
            ),
            SizedBox(height: theme.spacing.xxs),
            Text(label, style: theme.typography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
            Text(status, style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray)),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyIncidentHeatmap(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Institutional Safety Incident Pulse (30 Days)', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.lg),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(15, (index) {
              final height = (index % 5 + 2) * 15.0;
              final color = index == 12 ? theme.colors.error : (index > 8 ? theme.colors.warning : theme.colors.success);
              return Column(
                children: [
                  Container(
                    width: 12,
                    height: height,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  SizedBox(height: theme.spacing.xs),
                  Text('${index + 1}', style: theme.typography.labelSmall.copyWith(fontSize: 8)),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildRegulatoryTimeline(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upcoming Regulatory Deadlines', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.lg),
          Column(
            children: [
              _buildTimelineItem(theme, 'Ministry Annual Review', 'In 12 Days', LucideIcons.calendar, theme.colors.error),
              SizedBox(height: theme.spacing.md),
              _buildTimelineItem(theme, 'Health & Safety Inspection', 'In 24 Days', LucideIcons.shield, theme.colors.warning),
              SizedBox(height: theme.spacing.md),
              _buildTimelineItem(theme, 'Staff Credentialing Batch', 'In 45 Days', LucideIcons.award, theme.colors.primary),
              SizedBox(height: theme.spacing.md),
              _buildTimelineItem(theme, 'Policy Manual v4.2 Release', 'In 60 Days', LucideIcons.bookOpen, theme.colors.success),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(PrimeCareThemeData theme, String title, String date, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: theme.spacing.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
            Text(date, style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray)),
          ],
        ),
        const Spacer(),
        PrimeCareButton(label: 'View', onPressed: () {}, type: PrimeCareButtonType.text),
      ],
    );
  }

  Widget _buildPolicyHealth(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Policy Ecosystem Health', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.lg),
          Column(
            children: [
          _buildPolicyStat(theme, 'Standard Operating Procedures', 0.95, '${PrimeCareFormatters.formatPercentage(0.95)} Current'),
          SizedBox(height: theme.spacing.lg),
          _buildPolicyStat(theme, 'Clinical Guidelines', 0.88, '${PrimeCareFormatters.formatPercentage(0.88)} Up-to-date'),
          SizedBox(height: theme.spacing.lg),
          _buildPolicyStat(theme, 'Emergency Protocols', 1.0, '${PrimeCareFormatters.formatPercentage(1.0)} Critical'),
          SizedBox(height: theme.spacing.lg),
          _buildPolicyStat(theme, 'Data Governance', 0.82, 'Review Pending'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyStat(PrimeCareThemeData theme, String label, double progress, String footer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
            const Spacer(),
            Text(footer, style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray)),
          ],
        ),
        SizedBox(height: theme.spacing.xs),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: theme.colors.surfaceContainerHighest,
          color: progress == 1.0 ? theme.colors.success : theme.colors.primary,
          minHeight: 6,
          borderRadius: BorderRadius.circular(3),
        ),
      ],
    );
  }
}

