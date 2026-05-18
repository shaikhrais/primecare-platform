// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class PswDocumentsScreen extends ConsumerWidget {
  const PswDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return MasterLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Documents & Manuals', style: theme.typography.h2),
            SizedBox(height: theme.spacing.md),
            Text('Access care manuals, policies, and guidelines.', style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurfaceVariant)),
            SizedBox(height: theme.spacing.xl),
            
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: theme.spacing.lg,
              mainAxisSpacing: theme.spacing.lg,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildDocCard(context, 'Care Policies', LucideIcons.book),
                _buildDocCard(context, 'Emergency Protocols', LucideIcons.alertTriangle),
                _buildDocCard(context, 'Infection Control', LucideIcons.shield),
                _buildDocCard(context, 'Training Materials', LucideIcons.graduationCap),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocCard(BuildContext context, String title, IconData icon) {
    final theme = context.theme;
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: theme.colors.primary),
          SizedBox(height: theme.spacing.md),
          Text(title, style: theme.typography.labelMedium, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
