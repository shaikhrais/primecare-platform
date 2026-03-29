import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_mobile/core/api_client.dart';



/// Explicit Master Layout Class
/// Consolidates the Universal Skeleton (GlobalTopBar + Sidebar) out of the GoRouter config natively.
class MasterLayout extends StatelessWidget {
  final Widget child;
  final String currentPath;

  const MasterLayout({
    super.key,
    required this.child,
    required this.currentPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalTopBar(
        title: 'PrimeCare Native',
        onLogout: () async {
          await apiClient.logout();
          context.go('/login');
        },
      ),
      body: UniversalRoleSidebar( // This dynamically intercepts the role to handle 'role-wise layout' rendering natively!
        currentPath: currentPath,
        child: child,
      ),
    );
  }
}
