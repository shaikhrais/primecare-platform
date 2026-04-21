
// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// High-Fidelity Administrative Oversight Dashboard
class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(adminDashboardProvider);

    return state.when(
      loading: () => const Center(child: DashboardLoadingWidget()),
      error: (error, _) => Center(child: DashboardErrorWidget(message: error.toString())),
      data: (metrics) => SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, theme),
            SizedBox(height: theme.spacing.xl),
            PrimeCareResponsiveKpiGrid(metrics: metrics),
            SizedBox(height: theme.spacing.xl),
            
            // --- LIVE DISK MANAGEMENT (PDM) ---
            const PrimeCareDiskUsageCard(
              totalSectors: 337,
              occupiedSectors: 330,
              emptySectors: 0,
              missingSectors: 7,
            ),
            
            SizedBox(height: theme.spacing.xl),
            _buildAdminControls(context, theme),
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
                  'Administrative Command Center',
                  style: theme.typography.h2,
                ),
                Text(
                  'Infrastructure Monitoring • System Governance',
                  style: theme.typography.labelSmall.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          PrimeCareButton(
            label: 'System Logs',
            icon: LucideIcons.fileText,
            onPressed: () <String, dynamic>{},
            type: PrimeCareButtonType.secondary,
          ),
          SizedBox(width: theme.spacing.md),
          PrimeCareButton(
            label: 'Global Settings',
            icon: LucideIcons.settings,
            onPressed: () <String, dynamic>{},
            type: PrimeCareButtonType.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildAdminControls(BuildContext context, PrimeCareThemeData theme) {
    // Keep legacy controls for now if they are useful, but wrap in a Card
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Critical Administration Tasks', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.lg),
          Wrap(
            spacing: theme.spacing.md,
            runSpacing: theme.spacing.md,
            children: [
              _buildTaskItem(theme, 'Database Backup', 'Last: 2h ago', LucideIcons.database),
              _buildTaskItem(theme, 'Security Audit', 'Scheduled: 12:00 PM', LucideIcons.shield),
              _buildTaskItem(theme, 'User Reconciliation', '12 Pending Actions', LucideIcons.userCheck),
              _buildTaskItem(theme, 'Cache Invalidation', 'Clean State', LucideIcons.hardDrive),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(PrimeCareThemeData theme, String title, String subtitle, IconData icon) {
    return Container(
      width: 280,
      padding: EdgeInsets.all(theme.spacing.md),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colors.borderLight.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(theme.spacing.md),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.colors.slateGray, size: 24),
          SizedBox(width: theme.spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                Text(subtitle, style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
