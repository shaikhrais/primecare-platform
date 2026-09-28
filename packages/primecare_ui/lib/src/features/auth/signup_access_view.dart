import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';

/// Shared access-request screen. Accounts remain administrator-provisioned.
class SignUpAccessView extends GovernedScreen {
  const SignUpAccessView({super.key});
  @override
  String get featureId => 'auth.login';
  @override
  String get requiredRole => 'Public';
  @override
  Widget buildGovernedView(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    return Scaffold(body: Center(child: AlertDialog(
        backgroundColor: theme.colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            Icon(Icons.admin_panel_settings_rounded, color: theme.colors.primary, size: 28),
            const SizedBox(width: 12),
            Text(
              'Access Request',
              style: theme.typography.h3,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'PrimeCare is a regulated, secure healthcare platform enforcing Zero-Trust access controls.',
              style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Public registration is restricted. To provision a new workspace or register as a provider, coordinator, or client, please contact your regional administrator or care team coordinator.',
              style: theme.typography.bodyMedium.copyWith(
                color: theme.colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        actions: [
          ElevatedButton(
            key: const Key('login_view_elevatedbutton_signup_ok'), 
            onPressed: () => context.go(CommonRoutes.login),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              elevation: 0,
            ),
            child: const Text('UNDERSTOOD', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      )));
  }
}
