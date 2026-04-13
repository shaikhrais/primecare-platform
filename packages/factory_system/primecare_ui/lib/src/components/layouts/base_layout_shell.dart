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

  const BaseLayoutShell({
    super.key,
    required this.child,
    this.currentPath,
    this.topBarActions,
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

    return AdaptiveScalingWrapper(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.0 * scale + 1.0),
          child: GlobalTopBar(actions: topBarActions),
        ),
        body: UniversalRoleSidebar(
          currentPath: effectivePath,
          items: items,
          child: Padding(
            key: const Key('shell_content_padding'),
            padding: PrimeCareSpacing.scaledEdgeScreen(scale),
            child: child,
          ),
        ),
      ),
    );
  }
}
