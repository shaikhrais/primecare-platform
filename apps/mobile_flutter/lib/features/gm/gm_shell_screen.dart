import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onTap,
        backgroundColor: const Color(0xFF0F172A), // Dark Obsidian Base
        indicatorColor: const Color(0xFFF59E0B).withAlpha(40), // Premium Amber/Gold Highlight
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.show_chart_rounded, color: Color(0xFF94A3B8)),
            selectedIcon: Icon(Icons.show_chart_rounded, color: Color(0xFFF59E0B)),
            label: 'Hub',
          ),
          NavigationDestination(
            icon: Icon(Icons.campaign_outlined, color: Color(0xFF94A3B8)),
            selectedIcon: Icon(Icons.campaign_rounded, color: Color(0xFFF59E0B)),
            label: 'Marketing',
          ),
          NavigationDestination(
            icon: Icon(Icons.trending_down_outlined, color: Color(0xFF94A3B8)),
            selectedIcon: Icon(Icons.trending_down_rounded, color: Color(0xFFF59E0B)),
            label: 'Revenue',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_location_alt_outlined, color: Color(0xFF94A3B8)),
            selectedIcon: Icon(Icons.add_location_alt_rounded, color: Color(0xFFF59E0B)),
            label: 'Expand',
          ),
        ],
      ),
    );
  }
}
