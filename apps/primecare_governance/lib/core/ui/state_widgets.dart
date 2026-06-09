// Governance - Category: view | Purpose: Core implementation file for the State Widgets platform logic.
import 'package:getwidget/getwidget.dart';
import 'package:primecare_ui/primecare_ui.dart';

class EmptyState extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onRetry;
  final String? retryLabel;

  const EmptyState({
    super.key,
    this.icon,
    required this.title,
    this.subtitle,
    this.onRetry,
    this.retryLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 64,
                color: theme.colors.primary.withValues(alpha: 0.2),
              ),
              const SizedBox(height: 24),
            ],
            Text(
              title,
              style: theme.typography.h3,
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: theme.typography.bodyMedium.copyWith(
                  color: theme.colors.primary.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (onRetry != null) ...[
              const SizedBox(height: 32),
              ElevatedButton(key: const Key('state_widgets_elevatedbutton_button_1'), 
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(retryLabel ?? 'Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AppErrorState extends StatelessWidget {
  final Object error;
  final VoidCallback? onRetry;

  const AppErrorState({super.key, required this.error, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.redAccent),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              GFButton(onPressed: onRetry, text: 'Retry'),
            ],
          ],
        ),
      ),
    );
  }
}

class NoAccessScreen extends GovernedStatelessWidget {
  @override
  String get screenDescription =>
      'The No Access screen requires components for displaying permissions, notifications, and access history, along with buttons for navigation and permission requests.';

  @override
  List<String> get requiredComponents => const [
        'PermissionOverview',
        'NotificationAlert',
        'PermissionRequestLink',
        'AccessHistory',
      ];

  @override
  List<String> get requiredFunctions => const [
        'navigateBack',
        'requestPermissions',
      ];

  const NoAccessScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock_person_outlined,
              size: 100,
              color: Colors.orange,
            ),
            const SizedBox(height: 24),
            Text(
              'Access Restricted',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const Text(
              'You do not have the required permissions to view this screen.',
            ),
            const SizedBox(height: 32),
            GFButton(
              onPressed: () => Navigator.of(context).pop(),
              text: 'Go Back',
              type: GFButtonType.outline,
            ),
          ],
        ),
      ),
    );
  }
}
