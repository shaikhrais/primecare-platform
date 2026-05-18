// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class PswScheduleScreen extends ConsumerWidget {
  const PswScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shift Tracker & Schedule', style: theme.typography.h2),
                ElevatedButton.icon(
                  label: Text('Clock In'),
                  icon: Icon(LucideIcons.clock),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: theme.spacing.xl),
            PrimeCareCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(theme.spacing.lg),
                    decoration: BoxDecoration(
                      color: theme.colors.surface,
                      border: Border(bottom: BorderSide(color: theme.colors.border.withValues(alpha: 0.5))),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Current Week', style: theme.typography.h4),
                        Row(
                          children: [
                            IconButton(icon: Icon(LucideIcons.chevronLeft, size: 20), onPressed: () {}),
                            Text('May 15 - May 21', style: theme.typography.bodyLarge),
                            IconButton(icon: Icon(LucideIcons.chevronRight, size: 20), onPressed: () {}),
                          ],
                        )
                      ],
                    ),
                  ),
                  _buildDayRow(theme, day: 'Mon, May 15', hours: '8.0h', status: 'Completed', isToday: false),
                  Divider(height: 1, color: theme.colors.border.withValues(alpha: 0.5)),
                  _buildDayRow(theme, day: 'Tue, May 16', hours: '7.5h', status: 'Completed', isToday: false),
                  Divider(height: 1, color: theme.colors.border.withValues(alpha: 0.5)),
                  _buildDayRow(theme, day: 'Wed, May 17', hours: '8.0h', status: 'Active Shift', isToday: true),
                  Divider(height: 1, color: theme.colors.border.withValues(alpha: 0.5)),
                  _buildDayRow(theme, day: 'Thu, May 18', hours: '0.0h', status: 'Scheduled', isToday: false),
                  Divider(height: 1, color: theme.colors.border.withValues(alpha: 0.5)),
                  _buildDayRow(theme, day: 'Fri, May 19', hours: '0.0h', status: 'Scheduled', isToday: false),
                  Container(
                    padding: EdgeInsets.all(theme.spacing.lg),
                    decoration: BoxDecoration(
                      color: theme.colors.surface,
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Hours', style: theme.typography.h4),
                        Text('23.5h', style: theme.typography.h3.copyWith(color: theme.colors.primary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayRow(PrimeThemeData theme, {
    required String day,
    required String hours,
    required String status,
    required bool isToday,
  }) {
    Color statusColor;
    if (status == 'Completed') statusColor = theme.colors.success;
    else if (status == 'Active Shift') statusColor = theme.colors.primary;
    else statusColor = theme.colors.onSurface.withValues(alpha: 0.4);

    return Container(
      padding: EdgeInsets.all(theme.spacing.lg),
      color: isToday ? theme.colors.primary.withValues(alpha: 0.05) : Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (isToday) 
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: theme.colors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              Text(
                day,
                style: theme.typography.bodyLarge.copyWith(
                  fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                status,
                style: theme.typography.bodyMedium.copyWith(color: statusColor, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: theme.spacing.xl),
              SizedBox(
                width: 50,
                child: Text(
                  hours,
                  textAlign: TextAlign.right,
                  style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
