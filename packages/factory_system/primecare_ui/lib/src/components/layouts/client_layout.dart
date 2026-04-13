import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'base_layout_shell.dart';

class ClientLayout extends StatelessWidget {
  final Widget child;

  const ClientLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final String currentPath = GoRouterState.of(context).uri.toString();

    return BaseLayoutShell(
      userRole: 'Client',
      currentPath: currentPath,
      child: child,
    );
  }
}
