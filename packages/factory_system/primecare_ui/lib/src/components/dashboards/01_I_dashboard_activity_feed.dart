// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/primecare_ui.dart';

/// A standard activity feed for dashboards, consuming DashboardActivity models.
class DashboardActivityFeed extends StatelessWidget {
  final List<DashboardActivity> activities;

  const DashboardActivityFeed({
    super.key,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    final theme = PrimeCareTheme.of(context);

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Activity Stream',
            style: theme.typography.h4.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          if (activities.isEmpty)
             const Center(
               child: Text('No recent activity'),
             )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activities.length,
              separatorBuilder: (_, __) => const Divider(height: 32),
              itemBuilder: (context, index) {
                final activity = activities[index];
                final catColor = _getCategoryColor(activity.color);
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: catColor.withValues(alpha: 0.1),
                      child: Icon(
                        _getCategoryIcon(activity.icon),
                        size: 12,
                        color: catColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activity.title,
                            style: theme.typography.bodyMedium,
                          ),
                          if (activity.subtitle.isNotEmpty)
                            const SizedBox(height: 2),
                          if (activity.subtitle.isNotEmpty)
                            Text(
                              activity.subtitle,
                              style: theme.typography.bodySmall.copyWith(color: Colors.grey),
                            ),
                          const SizedBox(height: 4),
                          Text(
                            activity.timestamp,
                            style: theme.typography.bodySmall.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String color) {
    switch (color.toLowerCase()) {
      case 'green':
      case 'revenue': return Colors.green;
      case 'orange':
      case 'compliance': return Colors.orange;
      case 'blue':
      case 'operational': return Colors.blue;
      case 'purple':
      case 'partnership': return Colors.purple;
      default: return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String icon) {
    switch (icon.toLowerCase()) {
       case 'trending_up':
       case 'revenue': return Icons.trending_up;
       case 'verified_user':
       case 'compliance': return Icons.verified_user_outlined;
       case 'settings':
       case 'operational': return Icons.settings_outlined;
       case 'handshake':
       case 'partnership': return Icons.handshake_outlined;
       default: return Icons.info_outline;
    }
  }
}
