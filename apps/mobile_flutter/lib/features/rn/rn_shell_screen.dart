import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../shared/layouts/responsive_shell.dart';

class RnShellScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const RnShellScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveShell(
      navigationShell: navigationShell,
      activeIndicatorColor: const Color(0x33E11D48),
      activeIconColor: const Color(0xFFE11D48),
      destinations: const [
        ResponsiveNavigationData(label: 'Triage', icon: Icons.speed_rounded, selectedIcon: Icons.speed_rounded),
        ResponsiveNavigationData(label: 'Patients', icon: Icons.healing_rounded, selectedIcon: Icons.healing_rounded),
        ResponsiveNavigationData(label: 'Inbox', icon: Icons.forum_outlined, selectedIcon: Icons.forum_outlined),
        ResponsiveNavigationData(label: 'Profile', icon: Icons.person_outline, selectedIcon: Icons.person_outline),
      ],
    );
  }
}
