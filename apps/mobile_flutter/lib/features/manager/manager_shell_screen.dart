import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:go_router/go_router.dart';
import '../shared/layouts/responsive_shell.dart';

class ManagerShellScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ManagerShellScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveShell(
      navigationShell: navigationShell,
      activeIndicatorColor: const Color(0x33F59E0B),
      activeIconColor: PrimeCareColors.amber,
      destinations: const [
        ResponsiveNavigationData(label: 'Overview', icon: Icons.stacked_bar_chart_rounded, selectedIcon: Icons.stacked_bar_chart_rounded),
        ResponsiveNavigationData(label: 'Directory', icon: Icons.business_outlined, selectedIcon: Icons.business_outlined),
        ResponsiveNavigationData(label: 'System', icon: Icons.settings_applications_outlined, selectedIcon: Icons.settings_applications_outlined),
        ResponsiveNavigationData(label: 'Execute', icon: Icons.admin_panel_settings_outlined, selectedIcon: Icons.admin_panel_settings_outlined),
      ],
    );
  }
}
