import 'package:flutter/material.dart';
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
        backgroundColor: const Color(0xFF0F172A),
        indicatorColor: const Color(0xFF10B981).withAlpha(50),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined, color: Color(0xFF94A3B8)),
            selectedIcon: Icon(Icons.dashboard_rounded, color: Color(0xFF10B981)),
            label: 'System Hub',
          ),
          NavigationDestination(
            icon: Icon(Icons.memory_outlined, color: Color(0xFF94A3B8)),
            selectedIcon: Icon(Icons.memory_rounded, color: Color(0xFF10B981)),
            label: 'Diagnostics',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_alt_outlined, color: Color(0xFF94A3B8)),
            selectedIcon: Icon(Icons.people_alt_rounded, color: Color(0xFF10B981)),
            label: 'Tenants',
          ),
          NavigationDestination(
            icon: Icon(Icons.security_outlined, color: Color(0xFF94A3B8)),
            selectedIcon: Icon(Icons.security_rounded, color: Color(0xFF10B981)),
            label: 'Security',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined, color: Color(0xFF94A3B8)),
            selectedIcon: Icon(Icons.settings_rounded, color: Color(0xFF10B981)),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
