// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class PswReportsScreen extends ConsumerWidget {
  const PswReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Clinical Reports', style: theme.typography.h2),
            SizedBox(height: theme.spacing.md),
            Text('View and generate shift and client reports.', style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurfaceVariant)),
            SizedBox(height: theme.spacing.xl),
            
            PrimeCareCard(
              padding: EdgeInsets.zero,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                separatorBuilder: (context, index) => Divider(color: theme.colors.border, height: 1),
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(theme.spacing.lg),
                    leading: CircleAvatar(
                      backgroundColor: theme.colors.primary.withValues(alpha: 0.1),
                      child: Icon(LucideIcons.fileText, color: theme.colors.primary),
                    ),
                    title: Text('Shift Report - Week ${42 - index}', style: theme.typography.labelMedium),
                    subtitle: Text('Generated on Oct ${20 - index}, 2026', style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant)),
                    trailing: Icon(LucideIcons.download, color: theme.colors.primary, size: 20),
                    onTap: () {},
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
