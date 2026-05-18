// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class PswCheckInScreen extends ConsumerWidget {
  const PswCheckInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return MasterLayout(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(theme.spacing.lg),
          child: PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xxl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(LucideIcons.mapPin, size: 64, color: theme.colors.primary),
                SizedBox(height: theme.spacing.xl),
                Text('Location Check-In', style: theme.typography.h2),
                SizedBox(height: theme.spacing.md),
                Text(
                  'Check in to your current client visit. Ensure your GPS is enabled.',
                  style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: theme.spacing.xxl),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.checkCircle),
                    label: const Text('Check In Now', style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colors.success,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
