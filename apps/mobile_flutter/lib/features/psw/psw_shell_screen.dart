import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:go_router/go_router.dart';
import '../shared/layouts/responsive_shell.dart';

class PswShellScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const PswShellScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveShell(
      navigationShell: navigationShell,
      activeIndicatorColor: const Color(0x3310B981),
      activeIconColor: PrimeCareColors.emerald,
      destinations: const [
        ResponsiveNavigationData(label: 'Home', icon: Icons.home_rounded, selectedIcon: Icons.home_rounded),
        ResponsiveNavigationData(label: 'Shifts', icon: Icons.space_dashboard_rounded, selectedIcon: Icons.space_dashboard_rounded),
        ResponsiveNavigationData(label: 'Clients', icon: Icons.people_outline, selectedIcon: Icons.people_outline),
        ResponsiveNavigationData(label: 'Timesheet', icon: Icons.timer_outlined, selectedIcon: Icons.timer_outlined),
        ResponsiveNavigationData(label: 'Profile', icon: Icons.person_outline, selectedIcon: Icons.person_outline),
      ],
    );
  }
}
