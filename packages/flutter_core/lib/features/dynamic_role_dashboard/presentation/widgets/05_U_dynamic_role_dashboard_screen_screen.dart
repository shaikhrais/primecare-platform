// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// High-Fidelity Dynamic Role Dashboard
/// A modular base dashboard designed to adapt to various institutional roles
/// by rendering dynamic widgets and metric panels.
class DynamicRoleDashboardScreen extends ConsumerWidget {
  final dynamic data;
  
  const DynamicRoleDashboardScreen({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final Map<String, dynamic>? dataMap = data is Map<String, dynamic> ? data as Map<String, dynamic> : null;
    final roleTitle = dataMap?['roleTitle'] as String? ?? 'Institutional Workspace';
    
    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDynamicHeader(context, theme, roleTitle),
            SizedBox(height: theme.spacing.xl),
            _buildQuickActions(context, theme),
            SizedBox(height: theme.spacing.xl),
            _buildModularGrid(context, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicHeader(BuildContext context, PrimeCareThemeData theme, String title) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: theme.colors.primary.withValues(alpha: 0.1),
            child: Icon(LucideIcons.user, color: theme.colors.primary),
          ),
          SizedBox(width: theme.spacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.typography.h2,
                ),
                Text(
                  'Personalized view for your specialized institutional workflow.',
                  style: theme.typography.labelSmall.copyWith(color: theme.colors.slateGray),
                ),
              ],
            ),
          ),
          PrimeCareButton(
            label: 'Settings',
            icon: LucideIcons.settings,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, PrimeCareThemeData theme) {
    return Row(
      children: [
        _buildActionItem(theme, 'My Tasks', LucideIcons.checkSquare),
        SizedBox(width: theme.spacing.md),
        _buildActionItem(theme, 'Reports', LucideIcons.barChart2),
        SizedBox(width: theme.spacing.md),
        _buildActionItem(theme, 'Messages', LucideIcons.mail),
        SizedBox(width: theme.spacing.md),
        _buildActionItem(theme, 'Team', LucideIcons.users),
      ],
    );
  }

  Widget _buildActionItem(PrimeCareThemeData theme, String label, IconData icon) {
    return Expanded(
      child: PrimeCareCard(
        onTap: () {},
        padding: EdgeInsets.symmetric(vertical: theme.spacing.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: theme.colors.primary, size: 24),
            SizedBox(height: theme.spacing.xs),
            Text(label, style: theme.typography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildModularGrid(BuildContext context, PrimeCareThemeData theme) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: theme.spacing.lg,
      mainAxisSpacing: theme.spacing.lg,
      childAspectRatio: 2.0,
      children: [
        _buildSummaryPanel(theme, 'Activity Stream', 'Live updates from your assigned facilities.'),
        _buildSummaryPanel(theme, 'Performance Tracking', 'Metric variances and KPI status.'),
        _buildSummaryPanel(theme, 'Announcements', 'Critical platform and institutional news.'),
        _buildSummaryPanel(theme, 'Documentation', 'Access to protocol and compliance guides.'),
      ],
    );
  }

  Widget _buildSummaryPanel(PrimeCareThemeData theme, String title, String description) {
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.typography.labelLarge),
          SizedBox(height: theme.spacing.xs),
          Text(description, style: theme.typography.bodySmall.copyWith(color: theme.colors.slateGray)),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(LucideIcons.arrowUpRight, size: 16, color: theme.colors.primary.withValues(alpha: 0.5)),
          ),
        ],
      ),
    );
  }
}
