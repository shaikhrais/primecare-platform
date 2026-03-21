import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../../core/colors.dart';

import 'package:go_router/go_router.dart';

class ScrumMasterShellScreen extends StatelessWidget {
  const ScrumMasterShellScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onTap,
        backgroundColor: PrimeCareColors.radarDark,
        indicatorColor: PrimeCareColors.emerald.withAlpha(50),
        destinations: [
          NavigationDestination(
            icon: PrimeCareIcon(Icons.dashboard_outlined, color: PrimeCareColors.slate400),
            selectedIcon: PrimeCareIcon(Icons.dashboard_rounded, color: PrimeCareColors.emerald),
            label: AppLocalizations.of(context)!.systemHub,
          ),
          NavigationDestination(
            icon: PrimeCareIcon(Icons.memory_outlined, color: PrimeCareColors.slate400),
            selectedIcon: PrimeCareIcon(Icons.memory_rounded, color: PrimeCareColors.emerald),
            label: AppLocalizations.of(context)!.diagnostics,
          ),
          NavigationDestination(
            icon: PrimeCareIcon(Icons.people_alt_outlined, color: PrimeCareColors.slate400),
            selectedIcon: PrimeCareIcon(Icons.people_alt_rounded, color: PrimeCareColors.emerald),
            label: AppLocalizations.of(context)!.tenants,
          ),
          NavigationDestination(
            icon: PrimeCareIcon(Icons.security_outlined, color: PrimeCareColors.slate400),
            selectedIcon: PrimeCareIcon(Icons.security_rounded, color: PrimeCareColors.emerald),
            label: AppLocalizations.of(context)!.security,
          ),
          NavigationDestination(
            icon: PrimeCareIcon(Icons.settings_outlined, color: PrimeCareColors.slate400),
            selectedIcon: PrimeCareIcon(Icons.settings_rounded, color: PrimeCareColors.emerald),
            label: AppLocalizations.of(context)!.settings,
          ),
        ],
      ),
    );
  }
}
