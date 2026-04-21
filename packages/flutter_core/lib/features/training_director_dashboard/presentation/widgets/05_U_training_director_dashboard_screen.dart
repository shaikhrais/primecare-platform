// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// High-Fidelity Training & Education Director Dashboard
/// Focuses on institutional training compliance, module development, and staff competency analytics.
class TrainingDirectorDashboardScreen extends ConsumerWidget {
  final dynamic data;
  
  const TrainingDirectorDashboardScreen({super.key, this.data});

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
            _buildAcademyPulse(context, theme),
            SizedBox(height: theme.spacing.xl),
            _buildCompletionVelocity(context, theme),
            SizedBox(height: theme.spacing.xl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildActiveCertificationWaves(context, theme)),
                SizedBox(width: theme.spacing.xl),
                Expanded(flex: 2, child: _buildStaffCompetencyMatrix(context, theme)),
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
                  'Academy & Education Hub',
                  style: theme.typography.h2,
                ),
                Text(
                  'Knowledge Governance • Clinical Competency',
                  style: theme.typography.label.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          ClinicalGlassButton(
            label: 'Create Module',
            icon: LucideIcons.bookPlus,
            onPressed: () {},
          ),
          SizedBox(width: theme.spacing.md),
          ClinicalGlassButton(
            label: 'Compliance Report',
            icon: LucideIcons.fileBarChart,
            onPressed: () {},
            isPrimary: true,
          ),
        ],
      ),
    );
  }

  Widget _buildAcademyPulse(BuildContext context, PrimeCareThemeData theme) {
    return Row(
      children: [
        _buildPulseCard(theme, 'Overall Compliance', '94.8%', 'Target: 98%', LucideIcons.graduationCap, theme.colors.primary),
        SizedBox(width: theme.spacing.lg),
        _buildPulseCard(theme, 'Active Learners', '642', '+12% this week', LucideIcons.users, theme.colors.emeraldTeal),
        SizedBox(width: theme.spacing.lg),
        _buildPulseCard(theme, 'Modules Completed', '1,240', 'Monthly Total', LucideIcons.checkCircle2, theme.colors.emeraldTeal),
        SizedBox(width: theme.spacing.lg),
        _buildPulseCard(theme, 'Overdue Training', '18', 'Immediate Action', LucideIcons.alertCircle, theme.colors.roseRed),
      ],
    );
  }

  Widget _buildPulseCard(PrimeCareThemeData theme, String label, String value, String subtitle, IconData icon, Color color) {
    return Expanded(
      child: ClinicalGlassPanel(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            SizedBox(height: theme.spacing.md),
            Text(
              value,
              style: theme.typography.h2.copyWith(fontWeight: FontWeight.w900),
            ),
            SizedBox(height: theme.spacing.xxs),
            Text(label, style: theme.typography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
            Text(subtitle, style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletionVelocity(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
      title: 'Training Completion Velocity (Last 14 Days)',
      padding: EdgeInsets.all(theme.spacing.xl),
      child: SizedBox(
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(14, (index) {
            final value = (index * 7 % 10 + 5) / 15;
            return Container(
              width: 20,
              height: 120 * value,
              decoration: BoxDecoration(
                color: theme.colors.primary.withValues(alpha: 0.3 + (value * 0.7)),
                borderRadius: BorderRadius.circular(theme.spacing.xxs),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildActiveCertificationWaves(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
      title: 'Critical Certification Waves',
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        children: [
          _buildCertificationRow(theme, 'Annual HIPAA Recertification', '420 Staff', 0.85, theme.colors.primary),
          SizedBox(height: theme.spacing.md),
          _buildCertificationRow(theme, 'Core Nursing Competencies', '124 Staff', 0.62, theme.colors.amberWarning),
          SizedBox(height: theme.spacing.md),
          _buildCertificationRow(theme, 'Emergency Response Drill', '82 Staff', 0.94, theme.colors.emeraldTeal),
          SizedBox(height: theme.spacing.md),
          _buildCertificationRow(theme, 'Cultural Sensitivity Phase 2', '210 Staff', 0.45, theme.colors.primary),
        ],
      ),
    );
  }

  Widget _buildCertificationRow(PrimeCareThemeData theme, String label, String staffCount, double progress, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
            const Spacer(),
            Text(staffCount, style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray)),
          ],
        ),
        SizedBox(height: theme.spacing.xs),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: theme.colors.surfaceContainerHighest,
          color: color,
          minHeight: 10,
          borderRadius: BorderRadius.circular(5),
        ),
      ],
    );
  }

  Widget _buildStaffCompetencyMatrix(BuildContext context, PrimeCareThemeData theme) {
    return ClinicalGlassPanel(
      title: 'Competency Matrix',
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        children: [
          _buildCompetencyItem(theme, 'Clinical Skills', '4.9/5.0'),
          Divider(height: theme.spacing.lg),
          _buildCompetencyItem(theme, 'Compliance Knowledge', '4.7/5.0'),
          Divider(height: theme.spacing.lg),
          _buildCompetencyItem(theme, 'Documentation Accuracy', '4.8/5.0'),
          Divider(height: theme.spacing.lg),
          _buildCompetencyItem(theme, 'Communication', '4.6/5.0'),
          Divider(height: theme.spacing.lg),
          _buildCompetencyItem(theme, 'Crisis Management', '4.9/5.0'),
        ],
      ),
    );
  }

  Widget _buildCompetencyItem(PrimeCareThemeData theme, String label, String score) {
    return Row(
      children: [
        Text(label, style: theme.typography.bodyMedium.copyWith(color: theme.colors.slateGray)),
        const Spacer(),
        Text(score, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: theme.colors.primary)),
      ],
    );
  }
}
