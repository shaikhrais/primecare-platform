// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// High-Fidelity Customer Support Dashboard
/// Focuses on resolution speed, ticket volume, and customer satisfaction.
class CustomerSupportDashboardScreen extends ConsumerWidget {
  final CustomerSupportDashboardViewModel? data;

  const CustomerSupportDashboardScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    // Fallback to empty if no data provided
    final viewModel = data ?? CustomerSupportDashboardViewModel.empty();
    final metrics = viewModel.metrics;

    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, theme),
            SizedBox(height: theme.spacing.xl),
            _buildSupportHealthIndex(context, theme),
            SizedBox(height: theme.spacing.xl),

            // Standardized KPI Grid (Active Tickets, Avg Resolution, CSAT, SLAViolation)
            PrimeCareResponsiveKpiGrid(metrics: metrics),

            SizedBox(height: theme.spacing.xl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _buildTicketVolumeChart(context, theme),
                ),
                SizedBox(width: theme.spacing.xl),
                Expanded(
                  flex: 2,
                  child: _buildServiceLevelAgreements(context, theme),
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
                Text(
                  'Support Excellence Dashboard',
                  style: theme.typography.h2,
                ),
                Text(
                  'Incident Mgmt • Q2 2026 • Support Center',
                  style: theme.typography.label.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          PrimeCareButton(
            label: 'Issue Logs',
            icon: LucideIcons.list,
            onPressed: () {},
          ),
          SizedBox(width: theme.spacing.sm),
          PrimeCareButton(
            label: 'Resolve Critical',
            icon: LucideIcons.shieldAlert,
            onPressed: () {},
            type: PrimeCareButtonType.secondary,
          ),
        ],
      ),
    );
  }

  Widget _buildSupportHealthIndex(
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
                  'CUSTOMER SATISFACTION INDEX',
                  style: theme.typography.label.copyWith(
                    color: theme.colors.primary,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: theme.spacing.sm),
                Text('Support Status: Stable', style: theme.typography.h1),
                SizedBox(height: theme.spacing.xs),
                Text(
                  'Current CSAT score is 4.8/5. Average wait time reduced by 15% since deployment.',
                  style: theme.typography.bodyLarge.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          _buildHealthGauge(theme, 0.96, 'Support Health'),
        ],
      ),
    );
  }

  Widget _buildHealthGauge(
    PrimeCareThemeData theme,
    double value,
    String label,
  ) {
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

  Widget _buildTicketVolumeChart(
    BuildContext context,
    PrimeCareThemeData theme,
  ) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Regional Ticket Load', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildQueueRow(
            theme,
            'Ontario Clinical Support',
            0.82,
            theme.colors.primary,
          ),
          _buildQueueRow(
            theme,
            'BC Technical Issues',
            0.54,
            theme.colors.warning,
          ),
          _buildQueueRow(
            theme,
            'Corporate Compliance Support',
            0.31,
            theme.colors.success,
          ),
          _buildQueueRow(
            theme,
            'Franchise Onboarding Desk',
            0.94,
            theme.colors.error,
          ),
          _buildQueueRow(
            theme,
            'Public Patient Portal Help',
            0.68,
            theme.colors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildQueueRow(
    PrimeCareThemeData theme,
    String name,
    double load,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                name,
                style: theme.typography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                ' ${PrimeCareFormatters.formatPercentage(load)} Capacity',
                style: theme.typography.label,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xs),
          LinearProgressIndicator(
            value: load,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceLevelAgreements(
    BuildContext context,
    PrimeCareThemeData theme,
  ) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SLA Status (Last 24h)', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildSlaItem(
            theme,
            'First Response Time',
            '< 15 mins',
            LucideIcons.clock,
            theme.colors.success,
          ),
          const Divider(),
          _buildSlaItem(
            theme,
            'Critical Resolution',
            '< 2 hours',
            LucideIcons.zap,
            theme.colors.warning,
          ),
          const Divider(),
          _buildSlaItem(
            theme,
            'Standard Tickets',
            '< 24 hours',
            LucideIcons.checkSquare,
            theme.colors.success,
          ),
          const Divider(),
          _buildSlaItem(
            theme,
            'SLA Breaches',
            '0',
            LucideIcons.shieldCheck,
            theme.colors.success,
          ),
        ],
      ),
    );
  }

  Widget _buildSlaItem(
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
          Icon(icon, color: color, size: 20),
          SizedBox(width: theme.spacing.md),
          Expanded(child: Text(title, style: theme.typography.bodyLarge)),
          Text(value, style: theme.typography.h4.copyWith(color: color)),
        ],
      ),
    );
  }
}
