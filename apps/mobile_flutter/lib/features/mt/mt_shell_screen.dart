import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../shared/layouts/responsive_shell.dart';

class MtShellScreen extends StatelessWidget {
  const MtShellScreen({super.key, required this.navigationShell});

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
      activeIndicatorColor: Color(0xFFDBEAFE),
      activeIconColor: Color(0xFF3B82F6),
      destinations: [
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.schedule, icon: Icons.calendar_month_outlined, selectedIcon: Icons.calendar_month),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.clients, icon: Icons.spa_outlined, selectedIcon: Icons.spa),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.messages, icon: Icons.message_outlined, selectedIcon: Icons.message),
      ],
    );
  }
}
