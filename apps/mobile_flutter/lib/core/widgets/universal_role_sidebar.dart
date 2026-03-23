import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_mobile/l10n/app_localizations.dart';

class UniversalRoleSidebar extends StatelessWidget {
  final Widget child;
  final String currentPath;

  const UniversalRoleSidebar({
    super.key,
    required this.child,
    required this.currentPath,
  });

  @override
  Widget build(BuildContext context) {
    List<ResponsiveNavigationData> destinations = [];
    List<String> paths = [];
    Color? activeColor;

    // Determine configuration based on URL prefix intelligently natively
    if (currentPath.startsWith('/psw')) {
      activeColor = const Color(0xFF10B981); // Emerald
      destinations = [
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.home, icon: Icons.home_rounded, selectedIcon: Icons.home_rounded),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.shifts, icon: Icons.space_dashboard_rounded, selectedIcon: Icons.space_dashboard_rounded),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.clients, icon: Icons.people_outline, selectedIcon: Icons.people_outline),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.timesheet, icon: Icons.timer_outlined, selectedIcon: Icons.timer_outlined),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.profile, icon: Icons.person_outline, selectedIcon: Icons.person_outline),
      ];
      paths = ['/psw/home', '/psw/dashboard', '/psw/clients', '/psw/timesheet', '/psw/profile'];
    } 
    else if (currentPath.startsWith('/rn')) {
      activeColor = const Color(0xFF3B82F6); // Blue
      destinations = [
        ResponsiveNavigationData(label: 'Matrix', icon: Icons.dashboard_rounded, selectedIcon: Icons.dashboard_rounded),
        ResponsiveNavigationData(label: 'Patients', icon: Icons.people_outline, selectedIcon: Icons.people),
        ResponsiveNavigationData(label: 'Inbox', icon: Icons.inbox_outlined, selectedIcon: Icons.inbox_rounded),
        ResponsiveNavigationData(label: 'Profile', icon: Icons.person_outline, selectedIcon: Icons.person),
      ];
      paths = ['/rn/dashboard', '/rn/patients', '/rn/inbox', '/rn/profile'];
    }
    else if (currentPath.startsWith('/client')) {
      activeColor = const Color(0xFF0EA5E9); // Sky
      destinations = [
        ResponsiveNavigationData(label: 'Care Feed', icon: Icons.dynamic_feed, selectedIcon: Icons.dynamic_feed),
        ResponsiveNavigationData(label: 'Pulse', icon: Icons.monitor_heart_outlined, selectedIcon: Icons.monitor_heart),
        ResponsiveNavigationData(label: 'Profile', icon: Icons.person_outline, selectedIcon: Icons.person),
      ];
      paths = ['/client/dashboard', '/client/pulse', '/client/profile'];
    }
    else if (currentPath == '/dashboard' || currentPath.startsWith('/admin')) {
      activeColor = const Color(0xFF8B5CF6); // Violet
      destinations = [
        ResponsiveNavigationData(label: 'Matrix', icon: Icons.dashboard_rounded, selectedIcon: Icons.dashboard_rounded),
        ResponsiveNavigationData(label: 'Network', icon: Icons.hub_outlined, selectedIcon: Icons.hub),
        ResponsiveNavigationData(label: 'Audit', icon: Icons.security_rounded, selectedIcon: Icons.security_rounded),
        ResponsiveNavigationData(label: 'Settings', icon: Icons.settings_outlined, selectedIcon: Icons.settings),
      ];
      paths = ['/dashboard', '/admin/network', '/admin/audit', '/admin/settings'];
    }
    else if (currentPath.startsWith('/coordinator')) {
      activeColor = const Color(0xFFF59E0B); // Amber
      destinations = [
        ResponsiveNavigationData(label: 'Matrix', icon: Icons.dashboard_rounded, selectedIcon: Icons.dashboard_rounded),
        ResponsiveNavigationData(label: 'Staff', icon: Icons.people_outline, selectedIcon: Icons.people),
        ResponsiveNavigationData(label: 'Approvals', icon: Icons.fact_check_outlined, selectedIcon: Icons.fact_check),
        ResponsiveNavigationData(label: 'Profile', icon: Icons.person_outline, selectedIcon: Icons.person),
      ];
      paths = ['/coordinator/dashboard', '/coordinator/staff', '/coordinator/approvals', '/coordinator/profile'];
    }
    else if (currentPath.startsWith('/manager')) {
      activeColor = const Color(0xFFF43F5E); // Rose
      destinations = [
        ResponsiveNavigationData(label: 'Matrix', icon: Icons.dashboard_rounded, selectedIcon: Icons.dashboard_rounded),
        ResponsiveNavigationData(label: 'Reports', icon: Icons.bar_chart_outlined, selectedIcon: Icons.bar_chart),
        ResponsiveNavigationData(label: 'Teams', icon: Icons.group_work_outlined, selectedIcon: Icons.group_work),
        ResponsiveNavigationData(label: 'Profile', icon: Icons.person_outline, selectedIcon: Icons.person),
      ];
      paths = ['/manager/dashboard', '/manager/reports', '/manager/teams', '/manager/profile'];
    }
    else if (currentPath.startsWith('/mt')) {
       activeColor = const Color(0xFF14B8A6); // Teal
       destinations = [
        ResponsiveNavigationData(label: 'Matrix', icon: Icons.dashboard_rounded, selectedIcon: Icons.dashboard_rounded),
        ResponsiveNavigationData(label: 'Clients', icon: Icons.people_outline, selectedIcon: Icons.people),
        ResponsiveNavigationData(label: 'Messages', icon: Icons.chat_bubble_outline, selectedIcon: Icons.chat_bubble),
      ];
      paths = ['/mt/dashboard', '/mt/clients', '/mt/messages'];
    }
    else {
      // Completely unrecognized or isolated path gracefully falls back to just showing the child natively
      return child; 
    }

    // Determine current index accurately matching explicit boundaries locally
    int currentIndex = paths.indexWhere((p) => p == currentPath);
    
    // Fallback if exactly tracking fails due to trailing slash boundaries or variables globally
    if (currentIndex == -1) {
      currentIndex = paths.indexWhere((p) => currentPath.startsWith(p));
      if (currentIndex == -1) currentIndex = 0;
    }

    return ResponsiveShell(
      body: child,
      currentIndex: currentIndex,
      destinations: destinations,
      activeIconColor: activeColor,
      activeIndicatorColor: activeColor?.withValues(alpha: 0.15),
      onNavigate: (index) {
        if (index >= 0 && index < paths.length) {
          context.go(paths[index]);
        }
      },
    );
  }
}
