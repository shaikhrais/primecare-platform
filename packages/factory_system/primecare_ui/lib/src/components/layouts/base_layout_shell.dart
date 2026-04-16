import 'package:flutter/material.dart';
import '../../theme/design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../global_top_bar.dart';
import '../universal_role_sidebar.dart';
import '../adaptive_scaling_wrapper.dart';
import 'package:primecare_core/flutter_core.dart';

class BaseLayoutShell extends ConsumerWidget {
  final Widget child;
  final String? currentPath;
  final List<Widget>? topBarActions;
  final Widget? customTopBarLeft;
  final Widget? customTopBarCenter;
  final Widget? customTopBarRight;

  const BaseLayoutShell({
    super.key,
    required this.child,
    this.currentPath,
    this.topBarActions,
    this.customTopBarLeft,
    this.customTopBarCenter,
    this.customTopBarRight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(navigationMenuProvider);
    final mediaQuery = MediaQuery.of(context);

    // Synchronize global layout state with local MediaQuery data
    // Use addPostFrameCallback to avoid state modification during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(screenMetricsProvider) != mediaQuery) {
        ref.read(screenMetricsProvider.notifier).state = mediaQuery;
      }
    });

    // Fallback path logic
    String effectivePath = currentPath ?? '/';
    if (currentPath == null) {
      try {
        effectivePath = GoRouterState.of(context).uri.toString();
      } catch (_) {
        // Not in a GoRouter context (e.g. tests or early boot)
      }
    }

    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;

    // Mobile & Tablet layout (Hidden/Overlay Sidebar)
    if (layout.isHidden) {
      return AdaptiveScalingWrapper(
        child: Scaffold(
          extendBodyBehindAppBar: true, // Allow glassmorphism to blur the content
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(72.0 * scale),
            child: GlobalTopBar(
              actions: topBarActions,
              customLeft: customTopBarLeft,
              customCenter: customTopBarCenter,
              customRight: customTopBarRight,
            ),
          ),
          drawer: UniversalRoleDrawer(currentPath: effectivePath, items: items),
          bottomNavigationBar: items.isNotEmpty
              ? BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: items.indexWhere((item) => item.route == effectivePath).clamp(0, items.length - 1),
                  selectedItemColor: Theme.of(context).colorScheme.primary,
                  unselectedItemColor: Theme.of(context).disabledColor,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  elevation: 8,
                  items: items.map((item) {
                    final iconSize = 24.0 * scale;
                    return BottomNavigationBarItem(
                      icon: Icon(item.icon, size: iconSize),
                      label: item.label,
                    );
                  }).toList(),
                  onTap: (index) => context.go(items[index].route),
                )
              : null,
          body: Padding(
            key: const Key('shell_content_padding'),
            padding: EdgeInsets.only(
              top: 72.0 * scale, // Account for the extended AppBar
              left: PrimeCareSpacing.scaledEdgeScreen(scale).left,
              right: PrimeCareSpacing.scaledEdgeScreen(scale).right,
              bottom: PrimeCareSpacing.scaledEdgeScreen(scale).bottom,
            ),
            child: child,
          ),
        ),
      );
    }

    // Desktop layout (Fixed Sidebar)
    return AdaptiveScalingWrapper(
      child: Scaffold(
        extendBodyBehindAppBar: true, // Allow glassmorphism to blur the content
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(72.0 * scale),
          child: GlobalTopBar(
            actions: topBarActions,
            customLeft: customTopBarLeft,
            customCenter: customTopBarCenter,
            customRight: customTopBarRight,
          ),
        ),
        drawer: layout.isHidden
            ? UniversalRoleDrawer(currentPath: effectivePath, items: items)
            : null,
        body: UniversalRoleSidebar(
          currentPath: effectivePath,
          items: items,
          child: Padding(
            key: const Key('shell_content_padding'),
            padding: EdgeInsets.only(
              top: 72.0 * scale, // Account for the extended AppBar
              left: PrimeCareSpacing.scaledEdgeScreen(scale).left,
              right: PrimeCareSpacing.scaledEdgeScreen(scale).right,
              bottom: PrimeCareSpacing.scaledEdgeScreen(scale).bottom,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
