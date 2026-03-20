import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../shared/layouts/responsive_shell.dart';

class GmShellScreen extends StatelessWidget {
  const GmShellScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveShell(
      navigationShell: navigationShell,
      activeIndicatorColor: const Color(0xFFF59E0B).withAlpha(40),
      activeIconColor: const Color(0xFFF59E0B),
      destinations: const [
        ResponsiveNavigationData(label: 'Hub', icon: Icons.show_chart_rounded, selectedIcon: Icons.show_chart_rounded),
        ResponsiveNavigationData(label: 'Marketing', icon: Icons.campaign_outlined, selectedIcon: Icons.campaign_rounded),
        ResponsiveNavigationData(label: 'Revenue', icon: Icons.trending_down_outlined, selectedIcon: Icons.trending_down_rounded),
        ResponsiveNavigationData(label: 'Expand', icon: Icons.add_location_alt_outlined, selectedIcon: Icons.add_location_alt_rounded),
      ],
    );
  }
}
