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

    if (currentPath.startsWith('/psw')) {
      activeColor = const Color(0xFF10B981);
      destinations = [
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.home, icon: Icons.home_rounded, selectedIcon: Icons.home_rounded),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.shifts, icon: Icons.widgets_rounded, selectedIcon: Icons.widgets_rounded),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.clients, icon: Icons.people_outline, selectedIcon: Icons.people_outline),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.timesheet, icon: Icons.timer_outlined, selectedIcon: Icons.timer_outlined),
        ResponsiveNavigationData(label: AppLocalizations.of(context)!.profile, icon: Icons.person_outline, selectedIcon: Icons.person_outline),
        ResponsiveNavigationData(label: 'Daily Tasks', icon: Icons.task_alt, selectedIcon: Icons.task_alt),
        ResponsiveNavigationData(label: 'Activities', icon: Icons.timeline_outlined, selectedIcon: Icons.timeline_rounded),
        ResponsiveNavigationData(label: 'My Role', icon: Icons.school_outlined, selectedIcon: Icons.school_rounded),
      ];
      paths = ['/psw/home', '/psw/shifts', '/psw/clients', '/psw/timesheet', '/psw/profile', '/psw/dailyTasks', '/psw/activities', '/psw/mentor'];
    } 
    else if (currentPath.startsWith('/rn')) {
      activeColor = const Color(0xFF3B82F6);
      destinations = [
        ResponsiveNavigationData(label: 'Matrix', icon: Icons.grid_view_rounded, selectedIcon: Icons.grid_view_rounded),
        ResponsiveNavigationData(label: 'Patients', icon: Icons.people_outline, selectedIcon: Icons.people),
        ResponsiveNavigationData(label: 'Inbox', icon: Icons.inbox_outlined, selectedIcon: Icons.inbox_rounded),
        ResponsiveNavigationData(label: 'Profile', icon: Icons.person_outline, selectedIcon: Icons.person),
        ResponsiveNavigationData(label: 'Daily Tasks', icon: Icons.task_alt, selectedIcon: Icons.task_alt),
        ResponsiveNavigationData(label: 'Activities', icon: Icons.timeline_outlined, selectedIcon: Icons.timeline_rounded),
        ResponsiveNavigationData(label: 'My Role', icon: Icons.school_outlined, selectedIcon: Icons.school_rounded),
      ];
      paths = ['/rn/operations-hub', '/rn/patients', '/rn/inbox', '/rn/profile', '/rn/dailyTasks', '/rn/activities', '/rn/mentor'];
    }
    else if (currentPath.startsWith('/client')) {
      activeColor = const Color(0xFF0EA5E9);
      destinations = [
        ResponsiveNavigationData(label: 'Care Feed', icon: Icons.dynamic_feed, selectedIcon: Icons.dynamic_feed),
        ResponsiveNavigationData(label: 'Pulse', icon: Icons.monitor_heart_outlined, selectedIcon: Icons.monitor_heart),
        ResponsiveNavigationData(label: 'Profile', icon: Icons.person_outline, selectedIcon: Icons.person),
        ResponsiveNavigationData(label: 'Daily Tasks', icon: Icons.task_alt, selectedIcon: Icons.task_alt),
        ResponsiveNavigationData(label: 'Activities', icon: Icons.timeline_outlined, selectedIcon: Icons.timeline_rounded),
        ResponsiveNavigationData(label: 'My Role', icon: Icons.school_outlined, selectedIcon: Icons.school_rounded),
      ];
      paths = ['/client/care-hub', '/client/pulse', '/client/profile', '/client/dailyTasks', '/client/activities', '/client/mentor'];
    }
    else if (currentPath == '/admin/telemetry-matrix' || currentPath.startsWith('/admin')) {
      activeColor = const Color(0xFF8B5CF6);
      destinations = [
        ResponsiveNavigationData(label: 'Matrix', icon: Icons.grid_view_rounded, selectedIcon: Icons.grid_view_rounded),
        ResponsiveNavigationData(label: 'Network', icon: Icons.hub_outlined, selectedIcon: Icons.hub),
        ResponsiveNavigationData(label: 'Audit', icon: Icons.security_rounded, selectedIcon: Icons.security_rounded),
        ResponsiveNavigationData(label: 'Global Telemetry', icon: Icons.radar_outlined, selectedIcon: Icons.radar_rounded),
        ResponsiveNavigationData(label: 'Settings', icon: Icons.settings_outlined, selectedIcon: Icons.settings),
        
        ResponsiveNavigationData(label: 'Daily Tasks', icon: Icons.task_alt, selectedIcon: Icons.task_alt),
        ResponsiveNavigationData(label: 'Activities', icon: Icons.timeline_outlined, selectedIcon: Icons.timeline_rounded),
        ResponsiveNavigationData(label: 'My Role', icon: Icons.school_outlined, selectedIcon: Icons.school_rounded),
      ];
      paths = ['/admin/telemetry-matrix', '/admin/network', '/admin/audit', '/admin/telemetry', '/admin/settings', '/admin/dailyTasks', '/admin/activities', '/admin/mentor'];
    }
    else if (currentPath.startsWith('/coordinator')) {
      activeColor = const Color(0xFFF59E0B);
      destinations = [
        ResponsiveNavigationData(label: 'Matrix', icon: Icons.grid_view_rounded, selectedIcon: Icons.grid_view_rounded),
        ResponsiveNavigationData(label: 'Staff', icon: Icons.people_outline, selectedIcon: Icons.people),
        ResponsiveNavigationData(label: 'Approvals', icon: Icons.fact_check_outlined, selectedIcon: Icons.fact_check),
        ResponsiveNavigationData(label: 'Profile', icon: Icons.person_outline, selectedIcon: Icons.person),
        ResponsiveNavigationData(label: 'Daily Tasks', icon: Icons.task_alt, selectedIcon: Icons.task_alt),
        ResponsiveNavigationData(label: 'Activities', icon: Icons.timeline_outlined, selectedIcon: Icons.timeline_rounded),
        ResponsiveNavigationData(label: 'My Role', icon: Icons.school_outlined, selectedIcon: Icons.school_rounded),
      ];
      paths = ['/coordinator/matrix', '/coordinator/staff', '/coordinator/approvals', '/coordinator/profile', '/coordinator/dailyTasks', '/coordinator/activities', '/coordinator/mentor'];
    }
    else if (currentPath.startsWith('/manager')) {
      activeColor = const Color(0xFFF43F5E);
      destinations = [
        ResponsiveNavigationData(label: 'Matrix', icon: Icons.grid_view_rounded, selectedIcon: Icons.grid_view_rounded),
        ResponsiveNavigationData(label: 'Reports', icon: Icons.bar_chart_outlined, selectedIcon: Icons.bar_chart),
        ResponsiveNavigationData(label: 'Teams', icon: Icons.group_work_outlined, selectedIcon: Icons.group_work),
        ResponsiveNavigationData(label: 'Profile', icon: Icons.person_outline, selectedIcon: Icons.person),
        ResponsiveNavigationData(label: 'Daily Tasks', icon: Icons.task_alt, selectedIcon: Icons.task_alt),
        ResponsiveNavigationData(label: 'Activities', icon: Icons.timeline_outlined, selectedIcon: Icons.timeline_rounded),
        ResponsiveNavigationData(label: 'My Role', icon: Icons.school_outlined, selectedIcon: Icons.school_rounded),
      ];
      paths = ['/manager/analytics-matrix', '/manager/reports', '/manager/teams', '/manager/profile', '/manager/dailyTasks', '/manager/activities', '/manager/mentor'];
    }
    else if (currentPath.startsWith('/mt')) {
       activeColor = const Color(0xFF14B8A6);
       destinations = [
        ResponsiveNavigationData(label: 'Matrix', icon: Icons.grid_view_rounded, selectedIcon: Icons.grid_view_rounded),
        ResponsiveNavigationData(label: 'Clients', icon: Icons.people_outline, selectedIcon: Icons.people),
        ResponsiveNavigationData(label: 'Messages', icon: Icons.chat_bubble_outline, selectedIcon: Icons.chat_bubble),
        ResponsiveNavigationData(label: 'Daily Tasks', icon: Icons.task_alt, selectedIcon: Icons.task_alt),
        ResponsiveNavigationData(label: 'Activities', icon: Icons.timeline_outlined, selectedIcon: Icons.timeline_rounded),
        ResponsiveNavigationData(label: 'My Role', icon: Icons.school_outlined, selectedIcon: Icons.school_rounded),
      ];
      paths = ['/mt/operations-hub', '/mt/clients', '/mt/messages', '/mt/dailyTasks', '/mt/activities', '/mt/mentor'];
    }
    else if (currentPath.startsWith('/gm')) {
      activeColor = const Color(0xFF0284C7);
      destinations = [
        ResponsiveNavigationData(label: 'Matrix', icon: Icons.grid_view_rounded, selectedIcon: Icons.grid_view_rounded),
        ResponsiveNavigationData(label: 'Daily Tasks', icon: Icons.task_alt, selectedIcon: Icons.task_alt),
        ResponsiveNavigationData(label: 'Activities', icon: Icons.timeline_outlined, selectedIcon: Icons.timeline_rounded),
        ResponsiveNavigationData(label: 'My Role', icon: Icons.school_outlined, selectedIcon: Icons.school_rounded),
      ];
      paths = ['/gm/operations-hub', '/gm/dailyTasks', '/gm/activities', '/gm/mentor'];
    }
    else if (currentPath.startsWith('/scrum-master')) {
      activeColor = const Color(0xFF9333EA);
      destinations = [
        ResponsiveNavigationData(label: 'Matrix', icon: Icons.grid_view_rounded, selectedIcon: Icons.grid_view_rounded),
        ResponsiveNavigationData(label: 'Daily Tasks', icon: Icons.task_alt, selectedIcon: Icons.task_alt),
        ResponsiveNavigationData(label: 'Activities', icon: Icons.timeline_outlined, selectedIcon: Icons.timeline_rounded),
        ResponsiveNavigationData(label: 'My Role', icon: Icons.school_outlined, selectedIcon: Icons.school_rounded),
      ];
      paths = ['/scrum-master/operations-hub', '/scrum-master/dailyTasks', '/scrum-master/activities', '/scrum-master/mentor'];
    }
    else {
      return child; 
    }

    int currentIndex = paths.indexWhere((p) => p == currentPath);
    if (currentIndex == -1) {
      currentIndex = paths.indexWhere((p) => currentPath.startsWith(p));
      if (currentIndex == -1) currentIndex = 0;
    }

    return Stack(
      children: [
        ResponsiveShell(
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
        ),
        Positioned(
          bottom: 100, // Perfectly floats above the modern BottomNavigationBar
          right: 24,
          child: FloatingActionButton(
            elevation: 8,
            heroTag: 'universal_talk_call_button',
            backgroundColor: activeColor ?? Theme.of(context).primaryColor,
            onPressed: () {
              final segments = currentPath.split('/');
              final userRole = segments.length > 1 ? segments[1] : 'psw';
              context.push('/$userRole/inbox');
            },
            child: const Icon(Icons.forum_rounded, color: Colors.white, size: 28),
          ),
        ),
      ],
    );
  }
}
