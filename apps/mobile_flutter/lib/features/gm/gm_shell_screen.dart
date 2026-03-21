import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';

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
      activeIndicatorColor: PrimeCareColors.amber.withAlpha(40),
      activeIconColor: PrimeCareColors.amber,
      destinations: [
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.hub, icon: Icons.show_chart_rounded, selectedIcon: Icons.show_chart_rounded),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.marketing, icon: Icons.campaign_outlined, selectedIcon: Icons.campaign_rounded),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.revenue, icon: Icons.trending_down_outlined, selectedIcon: Icons.trending_down_rounded),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.expand, icon: Icons.add_location_alt_outlined, selectedIcon: Icons.add_location_alt_rounded),
      ],
    );
  }
}
