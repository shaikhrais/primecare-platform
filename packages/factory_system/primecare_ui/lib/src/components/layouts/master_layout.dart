import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'admin_layout.dart';
import 'provider_layout.dart';
import 'client_layout.dart';
import '../diagnostic/execution_gate_overlay.dart';

enum AppShellType { admin, provider, client, none }

class MasterLayout extends ConsumerWidget {
  final Widget child;
  final AppShellType shellType;
  final List<Widget>? topBarActions;
  final Widget? customTopBarLeft;
  final Widget? customTopBarCenter;
  final Widget? customTopBarRight;

  const MasterLayout({
    super.key,
    required this.child,
    this.shellType = AppShellType.none,
    this.topBarActions,
    this.customTopBarLeft,
    this.customTopBarCenter,
    this.customTopBarRight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Generate a strictly local animation for the inner child whenever the page URL changes.
    // This physically prevents the Top Bar and Sidebar from reloading, and smoothly cross-fades the middle content.
    final String currentUri = GoRouterState.of(context).uri.toString();

    final Widget animatedChild = AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(
                0.01,
                0.0,
              ), // Tiny subliminal slide from the right
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: KeyedSubtree(
        key: ValueKey(
          currentUri,
        ), // The key forces the transition to trigger ONLY on route changes!
        child: child,
      ),
    );

    Widget shell;
    switch (shellType) {
      case AppShellType.admin:
        shell = AdminLayout(
          currentPath: currentUri,
          topBarActions: topBarActions,
          customTopBarLeft: customTopBarLeft,
          customTopBarCenter: customTopBarCenter,
          customTopBarRight: customTopBarRight,
          child: animatedChild,
        );
        break;
      case AppShellType.provider:
        shell = ProviderLayout(
          currentPath: currentUri,
          topBarActions: topBarActions,
          customTopBarLeft: customTopBarLeft,
          customTopBarCenter: customTopBarCenter,
          customTopBarRight: customTopBarRight,
          child: animatedChild,
        );
        break;
      case AppShellType.client:
        shell = ClientLayout(
          currentPath: currentUri,
          topBarActions: topBarActions,
          customTopBarLeft: customTopBarLeft,
          customTopBarCenter: customTopBarCenter,
          customTopBarRight: customTopBarRight,
          child: animatedChild,
        );
        break;
      case AppShellType.none:
        shell = Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: animatedChild,
        ); // Raw master wrapper
        break;
    }

    return ExecutionGateOverlay(child: shell);
  }
}
