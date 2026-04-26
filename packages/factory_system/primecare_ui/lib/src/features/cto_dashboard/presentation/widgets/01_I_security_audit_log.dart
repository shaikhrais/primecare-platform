// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/primecare_ui.dart';

class SecurityAuditLog extends StatelessWidget {
  final List<DashboardActivity> activities;

  const SecurityAuditLog({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      backgroundColor: theme.colors.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.shieldCheck,
                color: theme.colors.success,
                size: 20,
              ),
              SizedBox(width: theme.spacing.sm),
              Text(
                'SECURITY AUDIT TRAIL',
                style: theme.typography.label.copyWith(
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                'LIVE UPDATES',
                style: theme.typography.labelSmall.copyWith(
                  color: theme.colors.success,
                ),
              ),
            ],
          ),
          SizedBox(height: theme.spacing.md),
          Expanded(
            child: ListView.separated(
              itemCount: activities.length,
              separatorBuilder: (context, index) => Divider(
                color: theme.colors.outlineVariant.withValues(alpha: 0.1),
              ),
              itemBuilder: (context, index) {
                final activity = activities[index];
                return _buildAuditItem(theme, activity);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuditItem(PrimeCareThemeData theme, DashboardActivity activity) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(theme.spacing.xs),
            decoration: BoxDecoration(
              color: theme.colors.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getActivityIcon(activity.title),
              size: 14,
              color: theme.colors.onSurfaceVariant,
            ),
          ),
          SizedBox(width: theme.spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: theme.typography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${activity.subtitle} • ${PrimeCareFormatters.formatRelativeTime(DateTime.tryParse(activity.timestamp) ?? DateTime.now())}',
                  style: theme.typography.labelSmall.copyWith(
                    color: theme.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getActivityIcon(String title) {
    final lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('auth') || lowerTitle.contains('login')) {
      return LucideIcons.key;
    }
    if (lowerTitle.contains('data') || lowerTitle.contains('database')) {
      return LucideIcons.database;
    }
    if (lowerTitle.contains('system') || lowerTitle.contains('config')) {
      return LucideIcons.settings;
    }
    return LucideIcons.info;
  }
}
