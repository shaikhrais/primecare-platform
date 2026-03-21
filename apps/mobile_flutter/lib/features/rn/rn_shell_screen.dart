import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:go_router/go_router.dart';
import '../shared/layouts/responsive_shell.dart';

class RnShellScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const RnShellScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveShell(
      navigationShell: navigationShell,
      activeIndicatorColor: Color(0x33E11D48),
      activeIconColor: PrimeCareColors.rose,
      destinations: [
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.triage, icon: Icons.speed_rounded, selectedIcon: Icons.speed_rounded),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.patients, icon: Icons.healing_rounded, selectedIcon: Icons.healing_rounded),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.inbox, icon: Icons.forum_outlined, selectedIcon: Icons.forum_outlined),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.profile, icon: Icons.person_outline, selectedIcon: Icons.person_outline),
      ],
    );
  }
}
