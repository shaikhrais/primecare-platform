// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// High-Fidelity HR Manager Dashboard
/// Focuses on human capital, recruitment pipeline, and staff retention.
class HrManagerDashboardScreen extends ConsumerWidget {
  final HrHiringDashboardViewModel? data;

  const HrManagerDashboardScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    // Fallback to empty if no data provided
    final viewModel = data ?? HrHiringDashboardViewModel.empty();
    final metrics = viewModel.metrics;

    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, theme),
            SizedBox(height: theme.spacing.xl),
            _buildHumanCapitalSummary(context, theme),
            SizedBox(height: theme.spacing.xl),

            // Standardized KPI Grid (Headcount, Openings, Retention, Time-to-Fill)
            PrimeCareResponsiveKpiGrid(metrics: metrics),

            SizedBox(height: theme.spacing.xl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _buildRecruitmentPipeline(context, theme),
                ),
                SizedBox(width: theme.spacing.xl),
                Expanded(
                  flex: 2,
                  child: _buildAdministrativeQueue(context, theme),
                ),
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
                Text('HR Human Capital Dashboard', style: theme.typography.h2),
                Text(
                  'Recruitment • Q2 2026 • HR Department',
                  style: theme.typography.label.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          PrimeCareButton(
            label: 'Post New Job',
            icon: LucideIcons.plus,
            onPressed: () {},
          ),
          SizedBox(width: theme.spacing.sm),
          PrimeCareButton(
            label: 'Staff List',
            icon: LucideIcons.users,
            onPressed: () {},
            type: PrimeCareButtonType.secondary,
          ),
        ],
      ),
    );
  }

  Widget _buildHumanCapitalSummary(
    BuildContext context,
    PrimeCareThemeData theme,
  ) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ORGANIZATIONAL HEALTH INDEX',
                  style: theme.typography.label.copyWith(
                    color: theme.colors.primary,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: theme.spacing.sm),
                Text('Status: Optimized', style: theme.typography.h1),
                SizedBox(height: theme.spacing.xs),
                Text(
                  'Staffing levels are at 94% of capacity. Retention has improved by 8% following the Q1 incentive program.',
                  style: theme.typography.bodyLarge.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          _buildGauge(theme, 0.94, 'Staff Capacity'),
        ],
      ),
    );
  }

  Widget _buildGauge(PrimeCareThemeData theme, double value, String label) {
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
            color: theme.colors.primary,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                PrimeCareFormatters.formatPercentage(value),
                style: theme.typography.h2.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(label, style: theme.typography.labelSmall),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecruitmentPipeline(
    BuildContext context,
    PrimeCareThemeData theme,
  ) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recruitment Pipeline', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildPipelineRow(
            theme,
            'Nursing (RN/RPN)',
            0.85,
            theme.colors.primary,
          ),
          _buildPipelineRow(
            theme,
            'Support Staff (PSW)',
            0.92,
            theme.colors.success,
          ),
          _buildPipelineRow(
            theme,
            'Clinical Admin',
            0.45,
            theme.colors.warning,
          ),
          _buildPipelineRow(theme, 'Specialist Care', 0.30, theme.colors.error),
          _buildPipelineRow(
            theme,
            'Facility Operations',
            0.70,
            theme.colors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildPipelineRow(
    PrimeCareThemeData theme,
    String role,
    double density,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                role,
                style: theme.typography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                ' ${PrimeCareFormatters.formatPercentage(density)} Fulfilled',
                style: theme.typography.label,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xs),
          LinearProgressIndicator(
            value: density,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildAdministrativeQueue(
    BuildContext context,
    PrimeCareThemeData theme,
  ) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pending Actions', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildQueueItem(
            theme,
            'Leave Requests',
            '12',
            LucideIcons.calendar,
            theme.colors.primary,
          ),
          const Divider(),
          _buildQueueItem(
            theme,
            'Interviews Today',
            '5',
            LucideIcons.userCheck,
            theme.colors.success,
          ),
          const Divider(),
          _buildQueueItem(
            theme,
            'Expiring Certs',
            '8',
            LucideIcons.alertTriangle,
            theme.colors.warning,
          ),
          const Divider(),
          _buildQueueItem(
            theme,
            'New Hires Onboarding',
            '3',
            LucideIcons.briefcase,
            theme.colors.info,
          ),
        ],
      ),
    );
  }

  Widget _buildQueueItem(
    PrimeCareThemeData theme,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.md),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(theme.spacing.sm),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: theme.spacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.typography.labelSmall),
              Text(value, style: theme.typography.h3),
            ],
          ),
        ],
      ),
    );
  }
}
