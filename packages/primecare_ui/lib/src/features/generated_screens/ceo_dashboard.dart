// CEO workspace: authenticated identity and access to the existing account page.
// Business dashboard APIs are not yet governed and connected.
import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';

class CeoDashboardScreen extends ConsumerWidget {
  const CeoDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final theme = context.theme;
    return Scaffold(
      backgroundColor: theme.colors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(theme.spacing.lg),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  header: true,
                  label: 'ceo-workspace-title',
                  child: Text('ceo_workspace_title'.tr(context: context),
                    style: theme.typography.h1),
                ),
                SizedBox(height: theme.spacing.md),
                Text(auth.userName ?? '', style: theme.typography.bodyLarge),
                SizedBox(height: theme.spacing.lg),
                Semantics(
                  label: 'ceo-workspace-unavailable',
                  child: Text('ceo_workspace_pending'.tr(context: context),
                    style: theme.typography.bodyMedium),
                ),
                SizedBox(height: theme.spacing.lg),
                Semantics(
                  label: 'ceo-workspace-account',
                  child: PrimeButton(
                    label: 'ceo_workspace_account'.tr(context: context),
                    onPressed: () => context.go('/success'),
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
