import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:go_router/go_router.dart';
import '../shared/layouts/responsive_shell.dart';

class ManagerShellScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ManagerShellScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveShell(
      navigationShell: navigationShell,
      activeIndicatorColor: Color(0x33F59E0B),
      activeIconColor: PrimeCareColors.amber,
      destinations: [
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.overview, icon: Icons.stacked_bar_chart_rounded, selectedIcon: Icons.stacked_bar_chart_rounded),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.directory, icon: Icons.business_outlined, selectedIcon: Icons.business_outlined),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.system, icon: Icons.settings_applications_outlined, selectedIcon: Icons.settings_applications_outlined),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.execute, icon: Icons.admin_panel_settings_outlined, selectedIcon: Icons.admin_panel_settings_outlined),
      ],
    );
  }
}
