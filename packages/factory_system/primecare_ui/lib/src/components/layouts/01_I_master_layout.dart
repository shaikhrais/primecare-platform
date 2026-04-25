import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_adapters/src/infrastructure/01_I_self_healing_notifier.dart';
import '../../theme/01_I_primecare_theme.dart';
import '../telemetry/01_I_telemetry_hud.dart';
import '../layouts/01_I_admin_layout.dart';
import '../layouts/01_I_provider_layout.dart';
import '../layouts/01_I_client_layout.dart';
import '../../registry/04_I_platform_governance_audit.dart';
import '../../features/auditor_hud/presentation/widgets/05_U_auditor_hud_overlay.dart';

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

    return AuditorHudOverlay(
      child: Stack(
        children: [
          shell,
          const DiagnosticBanner(),
          GovernanceTelemetryHud(currentUri: currentUri),
        ],
      ),
    );
  }
}

class DiagnosticBanner extends ConsumerWidget {
  const DiagnosticBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!kDebugMode) return const SizedBox.shrink();

    final audit = ref.watch(platformGovernanceAuditProvider);
    final theme = context.theme;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    audit.integrityScore > 90
                        ? Colors.greenAccent
                        : Colors.orangeAccent,
                    audit.integrityScore > 95
                        ? Colors.greenAccent
                        : theme.colors.primary,
                    audit.orphans.isNotEmpty
                        ? Colors.redAccent
                        : Colors.blueAccent,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            if (audit.orphans.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                color: Colors.redAccent.withValues(alpha: 0.9),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      size: 12,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'ORPHANS DETECTED: ${audit.orphans.length}',
                      style: theme.typography.labelSmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
