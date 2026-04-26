// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/01_I_colors.dart';
import 'package:flutter/material.dart';

import 'package:primecare_ui/src/theme/01_I_design_system.dart';
import 'package:flutter_core/config/01_I_screen_breakpoints.dart';
import 'package:flutter_core/config/01_I_adaptive_scaling_config.dart';
import 'package:easy_localization/easy_localization.dart';

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
        final tier = ScreenBreakpoints.getTier(constraints.maxWidth);
        final sidebarWidth = AdaptiveScalingConfig.getSidebarWidth(tier);
        final miniSidebarWidth = AdaptiveScalingConfig.getMinimalSidebarWidth(
          tier,
        );

        if (tier != ResolutionTier.mob && tier != ResolutionTier.tab) {
          // ENTERPRISE DESKTOP (macOS, Windows, Web HD)
          return Scaffold(
            backgroundColor: PrimeCareDesignSystem.surfaceElevated,
            body: Stack(
              children: [
                Row(
                  children: [
                    SizedBox(width: sidebarWidth),
                    Expanded(child: body),
                  ],
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  width: sidebarWidth,
                  child: _DesktopSidebar(
                    currentIndex: currentIndex,
                    destinations: destinations,
                    onNavigate: onNavigate,
                    activeIndicatorColor: activeIndicatorColor,
                    activeIconColor: activeIconColor,
                    width: sidebarWidth,
                  ),
                ),
              ],
            ),
          );
        } else if (tier == ResolutionTier.tab) {
          // ENTERPRISE TABLET (iPadOS, Android Tab, Foldables)
          return Scaffold(
            backgroundColor: PrimeCareDesignSystem.surfaceElevated,
            body: Stack(
              children: [
                Row(
                  children: [
                    SizedBox(width: miniSidebarWidth),
                    Expanded(child: body),
                  ],
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  width: miniSidebarWidth,
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
  final double width;
  final Color? activeIndicatorColor;
  final Color? activeIconColor;

  const _DesktopSidebar({
    required this.currentIndex,
    required this.destinations,
    required this.onNavigate,
    this.activeIndicatorColor,
    this.activeIconColor,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final primaryIcon = activeIconColor ?? PrimeCareColors.skyBlue;
    final primaryIndicator =
        activeIndicatorColor ?? PrimeCareColors.skyBlue.withValues(alpha: 0.1);

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: PrimeCareDesignSystem.surfaceElevated,
        boxShadow: [
          BoxShadow(
            color: PrimeCareColors.black.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: Offset(8, 0),
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
                SizedBox(width: PrimeCareSpacing.sm),
                Text(
                  'common.app_name'.tr(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                                  offset: Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? d.selectedIcon : d.icon,
                            color: isSelected
                                ? primaryIcon
                                : PrimeCareDesignSystem.textMuted,
                          ),
                          SizedBox(width: PrimeCareSpacing.md),
                          Text(
                            d.label.tr(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: isSelected
                                  ? primaryIcon
                                  : PrimeCareDesignSystem.textMuted,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
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
    final primaryIcon = activeIconColor ?? PrimeCareColors.skyBlue;
    final primaryIndicator =
        activeIndicatorColor ?? PrimeCareColors.skyBlue.withValues(alpha: 0.1);

    return Container(
      decoration: BoxDecoration(
        color: PrimeCareDesignSystem.surfaceElevated,
        boxShadow: [
          BoxShadow(
            color: PrimeCareColors.black.withValues(alpha: 0.35),
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
        unselectedIconTheme: IconThemeData(
          color: PrimeCareDesignSystem.textMuted,
        ),
        selectedLabelTextStyle: TextStyle(
          color: primaryIcon,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        unselectedLabelTextStyle: TextStyle(
          color: PrimeCareDesignSystem.textMuted,
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        groupAlignment: 0,
        destinations: destinations
            .map(
              (d) => NavigationRailDestination(
                icon: Icon(d.icon),
                selectedIcon: Icon(d.selectedIcon),
                label: Text(d.label.tr()),
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
    final primaryIcon = activeIconColor ?? PrimeCareColors.skyBlue;
    final primaryIndicator =
        activeIndicatorColor ?? PrimeCareColors.skyBlue.withValues(alpha: 0.1);

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onNavigate,
      backgroundColor: PrimeCareDesignSystem.surfaceElevated,
      indicatorColor: primaryIndicator,
      destinations: destinations
          .map(
            (d) => NavigationDestination(
              icon: Icon(d.icon, color: PrimeCareDesignSystem.textMuted),
              selectedIcon: Icon(d.selectedIcon, color: primaryIcon),
              label: d.label.tr(),
            ),
          )
          .toList(),
    );
  }
}

// Using dynamicPageProvider and ViewModel pattern for data binding.
