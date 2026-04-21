// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// High-Fidelity Quality Assurance Dashboard
/// Focuses on clinical audit results, incident trends, and regulatory compliance metrics.
class QaDashboardScreen extends ConsumerWidget {
  final dynamic data;
  
  const QaDashboardScreen({super.key, this.data});

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
            _buildQualityIndicators(context, theme),
            SizedBox(height: theme.spacing.xl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildAuditLog(context, theme)),
                SizedBox(width: theme.spacing.xl),
                Expanded(flex: 2, child: _buildIncidentTrends(context, theme)),
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
                  'Quality Assurance Command Center',
                  style: theme.typography.h2,
                ),
                Text(
                  'Clinical Audits • Regulatory Compliance • Incident Management',
                  style: theme.typography.label.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          ClinicalGlassButton(
            label: 'New Audit',
            icon: LucideIcons.fileSpreadsheet,
            onPressed: () {},
          ),
          SizedBox(width: theme.spacing.md),
          ClinicalGlassButton(
            label: 'Report Incident',
            icon: LucideIcons.alertCircle,
            onPressed: () {},
            isPrimary: true,
          ),
        ],
      ),
    );
  }

  Widget _buildQualityIndicators(BuildContext context, PrimeCareThemeData theme) {
    return Row(
      children: [
        _buildIndicatorCard(theme, 'Medication Errors', '0.02%', 'Below Target', LucideIcons.pill, theme.colors.emeraldTeal),
        SizedBox(width: theme.spacing.lg),
        _buildIndicatorCard(theme, 'Clinical Documentation', '98.4%', '+1.2%', LucideIcons.fileText, theme.colors.emeraldTeal),
        SizedBox(width: theme.spacing.lg),
        _buildIndicatorCard(theme, 'Resident Satisfaction', '4.7/5.0', 'Elite Status', LucideIcons.heart, theme.colors.primary),
        SizedBox(width: theme.spacing.lg),
        _buildIndicatorCard(theme, 'Fall Incidents', '12', '+2 this month', LucideIcons.userX, theme.colors.amberWarning),
      ],
    );
  }

  Widget _buildIndicatorCard(PrimeCareThemeData theme, String label, String value, String status, IconData icon, Color color) {
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
            Text(status, style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray)),
          ],
        ),
      ),
    );
  }

  Widget _buildAuditLog(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
      title: 'Recent Quality Audits',
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        children: [
          _buildAuditItem(theme, 'Pharmacy Protocol Audit', 'Branch Ontario North', 'Passed', theme.colors.emeraldTeal),
          const Divider(),
          _buildAuditItem(theme, 'Hygiene Standards Check', 'Main Facility', 'Needs Action', theme.colors.amberWarning),
          const Divider(),
          _buildAuditItem(theme, 'Dietary Compliance Audit', 'Branch Quebec West', 'Passed', theme.colors.emeraldTeal),
          const Divider(),
          _buildAuditItem(theme, 'Staff Certification Audit', 'Enterprise Wide', 'Failed', theme.colors.roseRed),
        ],
      ),
    );
  }

  Widget _buildAuditItem(PrimeCareThemeData theme, String audit, String location, String result, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.md),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(audit, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                Text(location, style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.sm, vertical: theme.spacing.xxs),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(theme.spacing.xxs),
            ),
            child: Text(
              result,
              style: theme.typography.labelSmall.copyWith(color: color, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncidentTrends(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
      title: 'Incident Distribution',
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        children: [
          _buildIncidentRow(theme, 'Falls/Injury', 42, theme.colors.amberWarning),
          _buildIncidentRow(theme, 'Medication', 8, theme.colors.roseRed),
          _buildIncidentRow(theme, 'Behavioral', 15, theme.colors.primary),
          _buildIncidentRow(theme, 'Equipment', 4, theme.colors.slateGray),
        ],
      ),
    );
  }

  Widget _buildIncidentRow(PrimeCareThemeData theme, String label, int count, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: theme.spacing.lg),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: theme.typography.bodyMedium),
              Text('$count', style: theme.typography.bodySmall.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: theme.spacing.xs),
          LinearProgressIndicator(
            value: count / 50,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: color,
            minHeight: 10,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      ),
    );
  }
}
