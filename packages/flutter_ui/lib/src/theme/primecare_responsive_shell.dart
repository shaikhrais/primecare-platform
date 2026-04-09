import 'package:flutter/material.dart';
import 'colors.dart';
import 'theme_tokens.dart';
import 'theme_extension.dart';


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
  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onNavigate;
  final List<ResponsiveNavigationData> destinations;
  final Color? activeIndicatorColor;
  final Color? activeIconColor;

  const ResponsiveShell({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.onNavigate,
    required this.destinations,
    this.activeIndicatorColor,
    this.activeIconColor,
  });

  @override
  Widget build(BuildContext context) {
    if (destinations.isEmpty) return body;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1024) {
          // ENTERPRISE DESKTOP (macOS, Windows, Web HD)
          return Scaffold(
            backgroundColor: context.pTheme.surfaceElevated,
            body: Stack(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 260),
                    Expanded(child: body),
                  ],
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  width: 260,
                  child: _DesktopSidebar(
                    currentIndex: currentIndex,
                    destinations: destinations,
                    onNavigate: onNavigate,
                    activeIndicatorColor: activeIndicatorColor,
                    activeIconColor: activeIconColor,
                  ),
                ),
              ],
            ),
          );
        } else if (constraints.maxWidth >= 600) {
          // ENTERPRISE TABLET (iPadOS, Android Tab, Foldables)
          return Scaffold(
            backgroundColor: context.pTheme.surfaceElevated,
            body: Stack(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 80),
                    Expanded(child: body),
                  ],
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  width: 80,
                  child: _TabletNavRail(
                    currentIndex: currentIndex,
                    destinations: destinations,
                    onNavigate: onNavigate,
                    activeIndicatorColor: activeIndicatorColor,
                    activeIconColor: activeIconColor,
                  ),
                ),
              ],
            ),
          );
        } else {
          // ENTERPRISE MOBILE (iOS, Android Phone)
          return Scaffold(
            body: body,
            bottomNavigationBar: _MobileBottomBar(
              currentIndex: currentIndex,
              destinations: destinations,
              onNavigate: onNavigate,
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
    final primaryIndicator =
        activeIndicatorColor ?? PrimeCareColors.skyBlue.withValues(alpha: 0.1);

    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: t.surfaceElevated,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(8, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: PrimeCareSpacing.edgeAllLg,
            child: Row(
              children: [
                Icon(Icons.monitor_heart_rounded, color: primaryIcon, size: 32),
                const SizedBox(width: PrimeCareSpacing.sm),
                Text('PrimeCare', overflow: TextOverflow.ellipsis, maxLines: 1, style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: primaryIcon,
                  ),
                ),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: PrimeCareSpacing.md,
                    vertical: PrimeCareSpacing.xxs,
                  ),
                  child: InkWell(
                    onTap: () => onNavigate(index),
                    borderRadius: PrimeCareRadii.boardMd,
                    child: Container(
                      padding: PrimeCareSpacing.edgeAllMd,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? primaryIndicator
                            : Colors.transparent,
                        borderRadius: PrimeCareRadii.boardMd,
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: primaryIcon.withValues(alpha: 0.25),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? d.selectedIcon : d.icon,
                            color: isSelected ? primaryIcon : t.textMuted,
                          ),
                          const SizedBox(width: PrimeCareSpacing.md),
                          Text(d.label, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(
                              color: isSelected ? primaryIcon : t.textMuted,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,),
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
    final primaryIndicator =
        activeIndicatorColor ?? PrimeCareColors.skyBlue.withValues(alpha: 0.1);

    return Container(
      decoration: BoxDecoration(
        color: t.surfaceElevated,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(8, 0),
          ),
        ],
      ),
      child: NavigationRail(
        selectedIndex: currentIndex,
        onDestinationSelected: onNavigate,
        labelType: NavigationRailLabelType.all,
        backgroundColor: Colors.transparent,
        indicatorColor: primaryIndicator,
        selectedIconTheme: IconThemeData(color: primaryIcon),
        unselectedIconTheme: IconThemeData(color: t.textMuted),
        selectedLabelTextStyle: TextStyle(
          color: primaryIcon,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        unselectedLabelTextStyle: TextStyle(
          color: t.textMuted,
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        groupAlignment: 0,
        destinations: destinations
            .map(
              (d) => NavigationRailDestination(
                icon: Icon(d.icon),
                selectedIcon: Icon(d.selectedIcon),
                label: Text(d.label),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            )
            .toList(),
      ),
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
    final primaryIndicator =
        activeIndicatorColor ?? PrimeCareColors.skyBlue.withValues(alpha: 0.1);

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onNavigate,
      backgroundColor: t.surfaceElevated,
      indicatorColor: primaryIndicator,
      destinations: destinations
          .map(
            (d) => NavigationDestination(
              icon: Icon(d.icon, color: t.textMuted),
              selectedIcon: Icon(d.selectedIcon, color: primaryIcon),
              label: d.label,
            ),
          )
          .toList(),
    );
  }
}
