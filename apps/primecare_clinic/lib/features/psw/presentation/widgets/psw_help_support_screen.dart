// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class PswHelpSupportScreen extends ConsumerWidget {
  const PswHelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Help & Support', style: theme.typography.h2),
            SizedBox(height: theme.spacing.md),
            Text('Get assistance from the PrimeCare support team.', style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurfaceVariant)),
            SizedBox(height: theme.spacing.xl),
            
            PrimeCareCard(
              padding: EdgeInsets.all(theme.spacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(LucideIcons.phone, color: theme.colors.primary, size: 30),
                    title: Text('Call Support', style: theme.typography.labelMedium),
                    subtitle: Text('Available 24/7 for urgent clinical issues.', style: theme.typography.bodyMedium),
                    trailing: const Icon(LucideIcons.chevronRight),
                    onTap: () {},
                  ),
                  Divider(color: theme.colors.border, height: 32),
                  ListTile(
                    leading: Icon(LucideIcons.messageCircle, color: theme.colors.primary, size: 30),
                    title: Text('Live Chat', style: theme.typography.labelMedium),
                    subtitle: Text('Chat with a support agent for non-urgent queries.', style: theme.typography.bodyMedium),
                    trailing: const Icon(LucideIcons.chevronRight),
                    onTap: () {},
                  ),
                  Divider(color: theme.colors.border, height: 32),
                  ListTile(
                    leading: Icon(LucideIcons.helpCircle, color: theme.colors.primary, size: 30),
                    title: Text('FAQ & Guides', style: theme.typography.labelMedium),
                    subtitle: Text('Browse common questions and troubleshooting steps.', style: theme.typography.bodyMedium),
                    trailing: const Icon(LucideIcons.chevronRight),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
