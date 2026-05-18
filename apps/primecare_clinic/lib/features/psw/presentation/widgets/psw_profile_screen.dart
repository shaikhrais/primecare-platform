// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class PswProfileScreen extends ConsumerWidget {
  const PswProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My Profile', style: theme.typography.h2),
            SizedBox(height: theme.spacing.xl),
            PrimeCareCard(
              padding: EdgeInsets.all(theme.spacing.xl),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: theme.colors.primary.withValues(alpha: 0.1),
                    child: Icon(LucideIcons.user, size: 40, color: theme.colors.primary),
                  ),
                  SizedBox(height: theme.spacing.lg),
                  Text('Jane Doe', style: theme.typography.h3),
                  Text('Senior Personal Support Worker', style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurfaceVariant)),
                  SizedBox(height: theme.spacing.xl),
                  Divider(color: theme.colors.border),
                  SizedBox(height: theme.spacing.xl),
                  _buildProfileRow(context, LucideIcons.mail, 'Email', 'jane.doe@primecare.com'),
                  SizedBox(height: theme.spacing.md),
                  _buildProfileRow(context, LucideIcons.phone, 'Phone', '+1 (555) 123-4567'),
                  SizedBox(height: theme.spacing.md),
                  _buildProfileRow(context, LucideIcons.mapPin, 'Region', 'Downtown Clinic District'),
                  SizedBox(height: theme.spacing.xl),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(LucideIcons.edit),
                      label: const Text('Edit Profile'),
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

  Widget _buildProfileRow(BuildContext context, IconData icon, String label, String value) {
    final theme = context.theme;
    return Row(
      children: [
        Icon(icon, color: theme.colors.primary, size: 20),
        SizedBox(width: theme.spacing.md),
        Text('$label:', style: theme.typography.labelMedium),
        SizedBox(width: theme.spacing.sm),
        Text(value, style: theme.typography.bodyLarge),
      ],
    );
  }
}
