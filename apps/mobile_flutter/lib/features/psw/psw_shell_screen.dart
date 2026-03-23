import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../../core/widgets/global_top_bar.dart';

class PswShellScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const PswShellScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      appBar: const GlobalTopBar(title: 'PrimeCare Platform'),
      body: ResponsiveShell(
      navigationShell: navigationShell,
      activeIndicatorColor: Color(0x3310B981),
      activeIconColor: PrimeCareColors.emerald,
      destinations: [
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.home, icon: Icons.home_rounded, selectedIcon: Icons.home_rounded),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.shifts, icon: Icons.space_dashboard_rounded, selectedIcon: Icons.space_dashboard_rounded),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.clients, icon: Icons.people_outline, selectedIcon: Icons.people_outline),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.timesheet, icon: Icons.timer_outlined, selectedIcon: Icons.timer_outlined),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.profile, icon: Icons.person_outline, selectedIcon: Icons.person_outline),
      ],
      ),
    );
  }
}
