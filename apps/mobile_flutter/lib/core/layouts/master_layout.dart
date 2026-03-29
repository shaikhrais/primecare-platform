import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_mobile/core/api_client.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/auth/auth_provider.dart';
import 'package:primecare_mobile/core/widgets/language_toggle_button.dart';

/// Explicit Master Layout Class
/// Consolidates the Universal Skeleton (GlobalTopBar + Sidebar) out of the GoRouter config natively.
class MasterLayout extends ConsumerWidget {
  final Widget child;
  final String currentPath;

  const MasterLayout({
    super.key,
    required this.child,
    required this.currentPath,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeRole = ref.watch(authProvider).role ?? 'psw_granular';
    return Scaffold(
      appBar: GlobalTopBar(
        title: 'PrimeCare Native',
        onLogout: () async {
          await apiClient.logout();
          context.go('/login');
        },
        activeRole: activeRole,
        languageToggleWidget: const LanguageToggleButton(),
      ),
      body: UniversalRoleSidebar( // This dynamically intercepts the role to handle 'role-wise layout' rendering natively!
        currentPath: currentPath,
        child: child,
      ),
    );
  }
}
