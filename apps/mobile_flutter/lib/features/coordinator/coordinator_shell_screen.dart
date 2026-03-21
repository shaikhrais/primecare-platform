import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CoordinatorShellScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CoordinatorShellScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveShell(
      navigationShell: navigationShell,
      activeIndicatorColor: Color(0x338B5CF6),
      activeIconColor: PrimeCareColors.purple,
      destinations: [
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.dispatch, icon: Icons.route_rounded, selectedIcon: Icons.route_rounded),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.staff, icon: Icons.badge_outlined, selectedIcon: Icons.badge_outlined),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.approvals, icon: Icons.fact_check_outlined, selectedIcon: Icons.fact_check_outlined),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.profile, icon: Icons.person_outline, selectedIcon: Icons.person_outline),
      ],
    );
  }
}
