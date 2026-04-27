import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/src/shared/src/infrastructure/self_healing_notifier.dart';
import '../layouts/admin_layout.dart';
import '../layouts/provider_layout.dart';
import '../layouts/client_layout.dart';

enum AppShellType { admin, provider, client, none }

class MasterLayout extends ConsumerWidget {
  final Widget child;
  final AppShellType shellType;
  final List<Widget>? topBarActions;
  final Widget? customTopBarLeft;
  final Widget? customTopBarCenter;
  final Widget? customTopBarRight;
  final String? overrideUri;

  const MasterLayout({
    super.key,
    required this.child,
    this.shellType = AppShellType.none,
    this.topBarActions,
    this.customTopBarLeft,
    this.customTopBarCenter,
    this.customTopBarRight,
    this.overrideUri,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Monitor Platform Resilience
    ref.listen(selfHealingProvider, (previous, next) {
      if (next.isLockoutActive &&
          (previous == null || !previous.isLockoutActive)) {
        // In a real production app, this would trigger an automated Sentry/Telemetry report
        // with the full hydration stack trace.
        debugPrint(
          '[RESILIENCE] Catastrophic hydration failure on: ${next.failingRouteId}',
        );
      }
    });

    // Generate a strictly local animation for the inner child whenever the page URL changes.
    // This physically prevents the Top Bar and Sidebar from reloading, and smoothly cross-fades the middle content.
    String currentUri = overrideUri ?? '';
    if (currentUri.isEmpty) {
      try {
        currentUri = GoRouterState.of(context).uri.toString();
      } catch (_) {
        // Safely ignore if not in a GoRouter context
      }
    }

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

    return Stack(
      children: [
        shell,
      ],
    );
  }
}

