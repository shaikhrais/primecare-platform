import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:go_router/go_router.dart';

class ScrumMasterShellScreen extends StatelessWidget {
  const ScrumMasterShellScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onTap,
        backgroundColor: PrimeCareColors.radarDark,
        indicatorColor: PrimeCareColors.emerald.withAlpha(50),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined, color: PrimeCareColors.slate400),
            selectedIcon: Icon(Icons.dashboard_rounded, color: PrimeCareColors.emerald),
            label: 'System Hub',
          ),
          NavigationDestination(
            icon: Icon(Icons.memory_outlined, color: PrimeCareColors.slate400),
            selectedIcon: Icon(Icons.memory_rounded, color: PrimeCareColors.emerald),
            label: 'Diagnostics',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_alt_outlined, color: PrimeCareColors.slate400),
            selectedIcon: Icon(Icons.people_alt_rounded, color: PrimeCareColors.emerald),
            label: 'Tenants',
          ),
          NavigationDestination(
            icon: Icon(Icons.security_outlined, color: PrimeCareColors.slate400),
            selectedIcon: Icon(Icons.security_rounded, color: PrimeCareColors.emerald),
            label: 'Security',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined, color: PrimeCareColors.slate400),
            selectedIcon: Icon(Icons.settings_rounded, color: PrimeCareColors.emerald),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
