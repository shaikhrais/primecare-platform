import 'package:primecare_ui/primecare_ui.dart';

class SignInView extends ConsumerWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('PrimeCare', style: context.theme.typography.h1),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await ref
                    .read(authProvider.notifier)
                    .login('admin@primecare.com', 'password');
              },
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenNotImplementedView extends StatelessWidget {
  final String? screenName;
  const ScreenNotImplementedView({super.key, this.screenName});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    
    return Center(
      child: Container(
        padding: const EdgeInsets.all(40),
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: theme.colors.surface,
          borderRadius: BorderRadius.circular(theme.radiusXl),
          border: Border.all(color: theme.colors.outlineVariant),
          boxShadow: theme.shadowsSurface2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colors.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                LucideIcons.construction,
                size: 48,
                color: theme.colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Screen Not Implemented',
              style: theme.typography.h2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              screenName ?? 'This feature is currently pending implementation in the platform registry.',
              style: theme.typography.bodyLarge.copyWith(
                color: theme.colors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.arrowUpCircle),
                label: const Text('Upvote Priority'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
