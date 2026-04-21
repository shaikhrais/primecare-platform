// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// High-Fidelity Clinical Director Dashboard
/// Focuses on patient safety, clinical quality, provider performance, and regulatory compliance.
class ClinicalDirectorDashboardScreen extends ConsumerWidget {
  final dynamic data;
  
  const ClinicalDirectorDashboardScreen({super.key, this.data});

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
            _buildClinicalSafetyIndex(context, theme),
            SizedBox(height: theme.spacing.xl),
            _buildClinicalKPIs(context, theme),
            SizedBox(height: theme.spacing.xl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildProviderPerformance(context, theme)),
                SizedBox(width: theme.spacing.xl),
                Expanded(flex: 2, child: _buildInfectionControl(context, theme)),
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
                  'Clinical Command Hub',
                  style: theme.typography.h2,
                ),
                Text(
                  'Patient Safety & Care Quality • Live Telemetry',
                  style: theme.typography.label.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          ClinicalGlassButton(
            label: 'Incident Report',
            icon: LucideIcons.alertCircle,
            onPressed: () {},
          ),
          SizedBox(width: theme.spacing.md),
          ClinicalGlassButton(
            label: 'Quality Audit',
            icon: LucideIcons.clipboardCheck,
            onPressed: () {},
            isPrimary: true,
          ),
        ],
      ),
    );
  }

  Widget _buildClinicalSafetyIndex(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CLINICAL SAFETY QUOTIENT',
                  style: theme.typography.labelSmall.copyWith(
                    color: theme.colors.emeraldTeal,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: theme.spacing.sm),
                Text(
                  'Status: High Excellence',
                  style: theme.typography.h1,
                ),
                SizedBox(height: theme.spacing.xs),
                Text(
                  'Zero critical incidents in the last 48 hours. Medication adherence is at 99.4%.',
                  style: theme.typography.bodyLarge.copyWith(color: theme.colors.slateGray),
                ),
              ],
            ),
          ),
          _buildSafetyGauge(theme, 0.98),
        ],
      ),
    );
  }

  Widget _buildSafetyGauge(PrimeCareThemeData theme, double value) {
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
            color: theme.colors.emeraldTeal,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${(value * 100).toInt()}%',
                style: theme.typography.h2.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'Safety',
                style: theme.typography.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClinicalKPIs(BuildContext context, PrimeCareThemeData theme) {
    return Row(
      children: [
        _buildClinicalCard(theme, 'Patient Outcomes', 'Highly Positive', LucideIcons.heart, theme.colors.emeraldTeal),
        SizedBox(width: theme.spacing.lg),
        _buildClinicalCard(theme, 'Meds Accuracy', '99.8%', LucideIcons.pill, theme.colors.primary),
        SizedBox(width: theme.spacing.lg),
        _buildClinicalCard(theme, 'Provider Burnout', 'Low (12%)', LucideIcons.smile, theme.colors.emeraldTeal),
        SizedBox(width: theme.spacing.lg),
        _buildClinicalCard(theme, 'Regulatory Compliance', 'Active (98%)', LucideIcons.shieldCheck, theme.colors.primary),
      ],
    );
  }

  Widget _buildClinicalCard(PrimeCareThemeData theme, String label, String value, IconData icon, Color color) {
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
            SizedBox(height: theme.spacing.xxs),
            Text(
              label,
              style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderPerformance(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
      title: 'Provider Excellence Matrix',
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        children: [
          _buildProviderRow(theme, 'Dr. Sarah Wilson', 'Lead Physician', 0.96),
          _buildProviderRow(theme, 'James Miller', 'Senior RPN', 0.92),
          _buildProviderRow(theme, 'Elena Rodriguez', 'Care Coordinator', 0.88),
          _buildProviderRow(theme, 'David Chang', 'Clinical Lead', 0.94),
          _buildProviderRow(theme, 'Maria Garcia', 'PSW Manager', 0.91),
        ],
      ),
    );
  }

  Widget _buildProviderRow(PrimeCareThemeData theme, String name, String role, double score) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: theme.colors.primary.withValues(alpha: 0.1),
            child: Text(name[0], style: TextStyle(color: theme.colors.primary, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: theme.spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                Text(role, style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray)),
              ],
            ),
          ),
          SizedBox(width: theme.spacing.lg),
          Text(
            '${(score * 100).toInt()}%',
            style: theme.typography.bodyLarge.copyWith(color: theme.colors.emeraldTeal, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildInfectionControl(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
      title: 'Infection Control Status',
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        children: [
          _buildInfectionItem(theme, 'Sanitization Audit', 'Passed', theme.colors.emeraldTeal),
          const Divider(),
          _buildInfectionItem(theme, 'Waste Management', 'Action Required', theme.colors.amberWarning),
          const Divider(),
          _buildInfectionItem(theme, 'PPE Stocks', 'Adequate', theme.colors.emeraldTeal),
          const Divider(),
          _buildInfectionItem(theme, 'Staff Vaccination', '98% Complete', theme.colors.emeraldTeal),
        ],
      ),
    );
  }

  Widget _buildInfectionItem(PrimeCareThemeData theme, String label, String status, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Row(
        children: [
          Text(label, style: theme.typography.bodyMedium.copyWith(color: theme.colors.slateGray)),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.sm, vertical: theme.spacing.xxs),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(theme.spacing.xs),
            ),
            child: Text(
              status,
              style: theme.typography.labelSmall.copyWith(color: color, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
