import 'package:flutter/material.dart';
import '../global_top_bar.dart';
import '../universal_role_sidebar.dart';
import '../adaptive_scaling_wrapper.dart';
import 'package:primecare_core/flutter_core.dart';

class BaseLayoutShell extends StatelessWidget {
  final Widget child;
  final String currentPath;
  final String userRole;
  final List<Widget>? topBarActions;

  const BaseLayoutShell({
    super.key,
    required this.child,
    required this.currentPath,
    required this.userRole,
    this.topBarActions,
  });

  @override
  Widget build(BuildContext context) {
    final List<PrimeCareNavigationItem> items =
        NavigationRegistry.getMenuForRole(userRole);

    return AdaptiveScalingWrapper(
      child: Column(
        children: [
          GlobalTopBar(userRole: userRole, actions: topBarActions),
          Expanded(
            child: UniversalRoleSidebar(
              currentPath: currentPath,
              items: items,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
