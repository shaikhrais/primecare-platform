// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class PswDashboardScreen extends ConsumerWidget {
  const PswDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Care Dashboard', style: theme.typography.h2),
            SizedBox(height: theme.spacing.xl),
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    theme,
                    title: 'Today\'s Visits',
                    value: '4/6',
                    icon: LucideIcons.calendarCheck,
                    color: theme.colors.primary,
                  ),
                ),
                SizedBox(width: theme.spacing.lg),
                Expanded(
                  child: _buildMetricCard(
                    theme,
                    title: 'Pending Tasks',
                    value: '12',
                    icon: LucideIcons.listTodo,
                    color: theme.colors.warning,
                  ),
                ),
                SizedBox(width: theme.spacing.lg),
                Expanded(
                  child: _buildMetricCard(
                    theme,
                    title: 'Hours Logged',
                    value: '34h',
                    icon: LucideIcons.clock,
                    color: theme.colors.success,
                  ),
                ),
              ],
            ),
            SizedBox(height: theme.spacing.xxl),
            Text('Upcoming Schedule', style: theme.typography.h3),
            SizedBox(height: theme.spacing.lg),
            PrimeCareCard(
              padding: EdgeInsets.all(theme.spacing.xl),
              child: Column(
                children: [
                  _buildScheduleItem(
                    theme,
                    time: '10:00 AM',
                    clientName: 'Eleanor Vance',
                    careType: 'Personal Care',
                    isCompleted: true,
                  ),
                  Divider(height: theme.spacing.xl, color: theme.colors.border),
                  _buildScheduleItem(
                    theme,
                    time: '01:30 PM',
                    clientName: 'Arthur Pendelton',
                    careType: 'Medication Administration',
                    isCompleted: false,
                  ),
                  Divider(height: theme.spacing.xl, color: theme.colors.border),
                  _buildScheduleItem(
                    theme,
                    time: '04:00 PM',
                    clientName: 'Sophia Lin',
                    careType: 'Companionship',
                    isCompleted: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(PrimeThemeData theme, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(theme.spacing.md),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          SizedBox(width: theme.spacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface.withValues(alpha: 0.7)),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(PrimeThemeData theme, {
    required String time,
    required String clientName,
    required String careType,
    required bool isCompleted,
  }) {
    final statusColor = isCompleted ? theme.colors.success : theme.colors.primary;
    
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            time,
            style: theme.typography.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colors.onSurface.withValues(alpha: 0.8),
            ),
          ),
        ),
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: theme.spacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(clientName, style: theme.typography.h4),
              Text(
                careType,
                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface.withValues(alpha: 0.6)),
              ),
            ],
          ),
        ),
        if (isCompleted)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(LucideIcons.checkCircle2, color: theme.colors.success, size: 16),
                const SizedBox(width: 4),
                Text(
                  'Completed',
                  style: theme.typography.bodyMedium.copyWith(
                    color: theme.colors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        else
          Icon(LucideIcons.chevronRight, color: theme.colors.onSurface.withValues(alpha: 0.3)),
      ],
    );
  }
}
