import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'base_layout_shell.dart';

class ProviderLayout extends ConsumerWidget {
  final Widget child;

  const ProviderLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String currentPath = GoRouterState.of(context).uri.toString();

    return BaseLayoutShell(
      userRole: 'PSW',
      currentPath: currentPath,
      child: child,
    );
  }
}
