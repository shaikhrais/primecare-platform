import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResponsiveNavigationData {
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  const ResponsiveNavigationData({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}

class ResponsiveShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final List<ResponsiveNavigationData> destinations;
  final Color activeIndicatorColor;
  final Color activeIconColor;

  const ResponsiveShell({
    super.key,
    required this.navigationShell,
    required this.destinations,
    this.activeIndicatorColor = const Color(0xFFE2E8F0),
    this.activeIconColor = const Color(0xFF0F172A),
  });

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Breakpoint shifting to Persistent Sidebars on Desktop/Web
        if (constraints.maxWidth >= 800) {
          return Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: navigationShell.currentIndex,
                  onDestinationSelected: _goBranch,
                  labelType: NavigationRailLabelType.all,
                  backgroundColor: Colors.white,
                  indicatorColor: activeIndicatorColor,
                  selectedIconTheme: IconThemeData(color: activeIconColor),
                  unselectedIconTheme: const IconThemeData(color: Color(0xFF94A3B8)),
                  selectedLabelTextStyle: TextStyle(color: activeIconColor, fontWeight: FontWeight.bold, fontSize: 13),
                  unselectedLabelTextStyle: const TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.normal, fontSize: 12),
                  groupAlignment: 0, // Centers the Rail items
                  destinations: destinations.map((d) => NavigationRailDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.selectedIcon),
                    label: Text(d.label),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  )).toList(),
                ),
                const VerticalDivider(thickness: 1, width: 1, color: Color(0xFFE2E8F0)),
                // Render the Nested Navigation State
                Expanded(child: navigationShell),
              ],
            ),
          );
        } else {
          // Fallback to Mobile-First Bottom Nav
          return Scaffold(
            body: navigationShell,
            bottomNavigationBar: NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _goBranch,
              backgroundColor: Colors.white,
              indicatorColor: activeIndicatorColor,
              destinations: destinations.map((d) => NavigationDestination(
                icon: Icon(d.icon, color: const Color(0xFF94A3B8)),
                selectedIcon: Icon(d.selectedIcon, color: activeIconColor),
                label: d.label,
              )).toList(),
            ),
          );
        }
      },
    );
  }
}
