// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class PswSystemLogsScreen extends ConsumerWidget {
  const PswSystemLogsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('System Logs', style: theme.typography.h2),
            SizedBox(height: theme.spacing.md),
            Text('Activity history and connection logs.', style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurfaceVariant)),
            SizedBox(height: theme.spacing.xl),
            
            PrimeCareCard(
              padding: EdgeInsets.zero,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                separatorBuilder: (context, index) => Divider(color: theme.colors.border, height: 1),
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(theme.spacing.lg),
                    leading: Icon(LucideIcons.activity, color: theme.colors.primary),
                    title: Text('Data Sync Completed', style: theme.typography.labelMedium),
                    subtitle: Text('Synced with main server - 10:4${index} AM', style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant)),
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
