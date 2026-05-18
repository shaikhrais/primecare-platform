// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class PswNotificationsScreen extends ConsumerWidget {
  const PswNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notifications', style: theme.typography.h2),
            SizedBox(height: theme.spacing.xl),
            
            PrimeCareCard(
              padding: EdgeInsets.zero,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                separatorBuilder: (context, index) => Divider(color: theme.colors.border, height: 1),
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(theme.spacing.lg),
                    leading: CircleAvatar(
                      backgroundColor: theme.colors.error.withValues(alpha: 0.1),
                      child: Icon(LucideIcons.bellRing, color: theme.colors.error),
                    ),
                    title: Text('Schedule Update', style: theme.typography.labelMedium),
                    subtitle: Text('Your afternoon shift has been updated by the coordinator.', style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant)),
                    trailing: Text('2m ago', style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
