import 'package:flutter/material.dart';
import 'colors.dart';
import 'theme_tokens.dart';
import 'theme_extension.dart';

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
  final Color? activeIndicatorColor;
  final Color? activeIconColor;

  const ResponsiveShell({
    super.key,
    required this.navigationShell,
    required this.destinations,
    this.activeIndicatorColor,
    this.activeIconColor,
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
        if (constraints.maxWidth >= 1024) {
          // ENTERPRISE DESKTOP (macOS, Windows, Web HD)
          return Scaffold(
            backgroundColor: context.pTheme.surfaceElevated,
            body: Row(
              children: [
                _DesktopSidebar(
                  currentIndex: navigationShell.currentIndex,
                  destinations: destinations,
                  onNavigate: _goBranch,
                  activeIndicatorColor: activeIndicatorColor,
                  activeIconColor: activeIconColor,
                ),
                VerticalDivider(thickness: 1, width: 1, color: context.pTheme.borderSubtle),
                Expanded(child: navigationShell),
              ],
            ),
          );
        } else if (constraints.maxWidth >= 600) {
          // ENTERPRISE TABLET (iPadOS, Android Tab, Foldables)
          return Scaffold(
            backgroundColor: context.pTheme.surfaceElevated,
            body: Row(
              children: [
                _TabletNavRail(
                  currentIndex: navigationShell.currentIndex,
                  destinations: destinations,
                  onNavigate: _goBranch,
                  activeIndicatorColor: activeIndicatorColor,
                  activeIconColor: activeIconColor,
                ),
                VerticalDivider(thickness: 1, width: 1, color: context.pTheme.borderSubtle),
                Expanded(child: navigationShell),
              ],
            ),
          );
        } else {
          // ENTERPRISE MOBILE (iOS, Android Phone)
          return Scaffold(
            body: navigationShell,
            bottomNavigationBar: _MobileBottomBar(
              currentIndex: navigationShell.currentIndex,
              destinations: destinations,
              onNavigate: _goBranch,
              activeIndicatorColor: activeIndicatorColor,
              activeIconColor: activeIconColor,
            ),
          );
        }
      },
    );
  }
}

class _DesktopSidebar extends StatelessWidget {
  final int currentIndex;
  final List<ResponsiveNavigationData> destinations;
  final ValueChanged<int> onNavigate;
  final Color? activeIndicatorColor;
  final Color? activeIconColor;

  const _DesktopSidebar({
    required this.currentIndex,
    required this.destinations,
    required this.onNavigate,
    this.activeIndicatorColor,
    this.activeIconColor,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.pTheme;
    final primaryIcon = activeIconColor ?? PrimeCareColors.skyBlue;
    final primaryIndicator = activeIndicatorColor ?? PrimeCareColors.skyBlue.withValues(alpha: 0.1);

    return Container(
      width: 260,
      color: t.surfaceElevated,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: PrimeCareSpacing.edgeAllLg,
            child: Row(
              children: [
                Icon(Icons.monitor_heart_rounded, color: primaryIcon, size: 32),
                const SizedBox(width: PrimeCareSpacing.sm),
                Text('PrimeCare', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900, color: primaryIcon)),
              ],
            ),
          ),
          const SizedBox(height: PrimeCareSpacing.md),
          Expanded(
            child: ListView.builder(
              itemCount: destinations.length,
              itemBuilder: (context, index) {
                final d = destinations[index];
                final isSelected = currentIndex == index;
                
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: PrimeCareSpacing.md, vertical: PrimeCareSpacing.xxs),
                  child: InkWell(
                    onTap: () => onNavigate(index),
                    borderRadius: PrimeCareRadii.boardMd,
                    child: Container(
                      padding: PrimeCareSpacing.edgeAllMd,
                      decoration: BoxDecoration(
                        color: isSelected ? primaryIndicator : Colors.transparent,
                        borderRadius: PrimeCareRadii.boardMd,
                      ),
                      child: Row(
                        children: [
                          Icon(isSelected ? d.selectedIcon : d.icon, color: isSelected ? primaryIcon : t.textMuted),
                          const SizedBox(width: PrimeCareSpacing.md),
                          Text(
                            d.label,
                            style: TextStyle(
                              color: isSelected ? primaryIcon : t.textMuted,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TabletNavRail extends StatelessWidget {
  final int currentIndex;
  final List<ResponsiveNavigationData> destinations;
  final ValueChanged<int> onNavigate;
  final Color? activeIndicatorColor;
  final Color? activeIconColor;

  const _TabletNavRail({
    required this.currentIndex,
    required this.destinations,
    required this.onNavigate,
    this.activeIndicatorColor,
    this.activeIconColor,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.pTheme;
    final primaryIcon = activeIconColor ?? PrimeCareColors.skyBlue;
    final primaryIndicator = activeIndicatorColor ?? PrimeCareColors.skyBlue.withValues(alpha: 0.1);

    return NavigationRail(
      selectedIndex: currentIndex,
      onDestinationSelected: onNavigate,
      labelType: NavigationRailLabelType.all,
      backgroundColor: t.surfaceElevated,
      indicatorColor: primaryIndicator,
      selectedIconTheme: IconThemeData(color: primaryIcon),
      unselectedIconTheme: IconThemeData(color: t.textMuted),
      selectedLabelTextStyle: TextStyle(color: primaryIcon, fontWeight: FontWeight.bold, fontSize: 13),
      unselectedLabelTextStyle: TextStyle(color: t.textMuted, fontWeight: FontWeight.normal, fontSize: 12),
      groupAlignment: 0, 
      destinations: destinations.map((d) => NavigationRailDestination(
        icon: Icon(d.icon),
        selectedIcon: Icon(d.selectedIcon),
        label: Text(d.label),
        padding: const EdgeInsets.symmetric(vertical: 12),
      )).toList(),
    );
  }
}

class _MobileBottomBar extends StatelessWidget {
  final int currentIndex;
  final List<ResponsiveNavigationData> destinations;
  final ValueChanged<int> onNavigate;
  final Color? activeIndicatorColor;
  final Color? activeIconColor;

  const _MobileBottomBar({
    required this.currentIndex,
    required this.destinations,
    required this.onNavigate,
    this.activeIndicatorColor,
    this.activeIconColor,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.pTheme;
    final primaryIcon = activeIconColor ?? PrimeCareColors.skyBlue;
    final primaryIndicator = activeIndicatorColor ?? PrimeCareColors.skyBlue.withValues(alpha: 0.1);

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onNavigate,
      backgroundColor: t.surfaceElevated,
      indicatorColor: primaryIndicator,
      destinations: destinations.map((d) => NavigationDestination(
        icon: Icon(d.icon, color: t.textMuted),
        selectedIcon: Icon(d.selectedIcon, color: primaryIcon),
        label: d.label,
      )).toList(),
    );
  }
}
