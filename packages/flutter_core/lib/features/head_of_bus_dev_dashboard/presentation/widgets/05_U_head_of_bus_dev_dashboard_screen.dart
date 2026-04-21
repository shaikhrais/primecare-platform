
// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// High-Fidelity Head Of Bus Dev Dashboard
class HeadOfBusDevDashboardScreen extends ConsumerWidget {
  const HeadOfBusDevDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, theme),
          SizedBox(height: theme.spacing.xl),
          const PrimeCareResponsiveKpiGrid(metrics: {
            'Performance': '98.5%',
            'Utility': 'High',
            'Status': 'Operational',
            'SLA': '100%',
          }),
          SizedBox(height: theme.spacing.xl),
          _buildMainContent(context, theme),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Head Of Bus Dev Dashboard',
                  style: theme.typography.h2,
                ),
                Text(
                  'Standardized Platform Dashboard • V4 Optimized',
                  style: theme.typography.labelSmall.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          PrimeCareButton(
            label: 'Generate Report',
            icon: LucideIcons.fileText,
            onPressed: () {},
            type: PrimeCareButtonType.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Center(
        child: Column(
          children: [
            Icon(LucideIcons.layoutDashboard, size: 64, color: theme.colors.primary.withValues(alpha: 0.2)),
            SizedBox(height: theme.spacing.lg),
            Text(
              'Unified Role-Based Interface',
              style: theme.typography.titleLarge,
            ),
            SizedBox(height: theme.spacing.sm),
            Text(
              'This sector has been defragmented and standardized for the PrimeCare Unified UX.',
              textAlign: TextAlign.center,
              style: theme.typography.bodyMedium.copyWith(color: theme.colors.slateGray),
            ),
          ],
        ),
      ),
    );
  }
}
