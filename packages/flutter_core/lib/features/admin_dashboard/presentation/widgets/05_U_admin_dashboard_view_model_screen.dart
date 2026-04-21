// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// High-Fidelity Administrative Oversight Dashboard
class AdminDashboardViewModelScreen extends ConsumerWidget {
  final dynamic data;
  
  const AdminDashboardViewModelScreen({super.key, this.data});

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
            _buildSystemStatus(context, theme),
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
            onPressed: () {},
            type: PrimeCareButtonType.secondary,
          ),
          SizedBox(width: theme.spacing.md),
          PrimeCareButton(
            label: 'Global Settings',
            icon: LucideIcons.settings,
            onPressed: () {},
            type: PrimeCareButtonType.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildSystemStatus(BuildContext context, PrimeCareThemeData theme) {
    return Row(
      children: [
        _buildStatusCard(theme, 'API Uptime', '100%', 'Operational', LucideIcons.activity, theme.colors.success),
        SizedBox(width: theme.spacing.lg),
        _buildStatusCard(theme, 'Worker Performance', '0.8ms', 'Healthy', LucideIcons.zap, theme.colors.success),
        SizedBox(width: theme.spacing.lg),
        _buildStatusCard(theme, 'Active Sessions', '1,284', '+5% from 1h', LucideIcons.users, theme.colors.primary),
        SizedBox(width: theme.spacing.lg),
        _buildStatusCard(theme, 'Error Rate', '0.01%', 'Safe Range', LucideIcons.alertTriangle, theme.colors.success),
      ],
    );
  }

  Widget _buildStatusCard(PrimeCareThemeData theme, String label, String value, String status, IconData icon, Color color) {
    return Expanded(
      child: PrimeCareCard(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(theme.spacing.xs),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(theme.spacing.xs),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const Spacer(),
                Text(
                  status,
                  style: theme.typography.labelSmall.copyWith(color: color),
                ),
              ],
            ),
            SizedBox(height: theme.spacing.md),
            Text(label, style: theme.typography.labelSmall),
            Text(value, style: theme.typography.h3),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminControls(BuildContext context, PrimeCareThemeData theme) {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
              Text(subtitle, style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray)),
            ],
          ),
        ],
      ),
    );
  }
}
