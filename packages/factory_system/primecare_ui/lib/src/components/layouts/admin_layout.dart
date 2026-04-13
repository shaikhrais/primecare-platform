import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'base_layout_shell.dart';

class AdminLayout extends StatelessWidget {
  final Widget child;

  const AdminLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final String currentPath = GoRouterState.of(context).uri.toString();

    return BaseLayoutShell(
      userRole: 'Admin',
      currentPath: currentPath,
      child: child,
    );
  }
}
