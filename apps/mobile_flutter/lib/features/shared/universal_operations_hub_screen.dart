import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';

class UniversalOperationsHubScreen extends StatelessWidget {
  final String rolePrefix;
  
  const UniversalOperationsHubScreen({super.key, required this.rolePrefix});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> items = [];
    Color activeColor = Theme.of(context).primaryColor;

    if (rolePrefix == 'psw') {
      activeColor = const Color(0xFF10B981);
      items = [
        {'label': 'Clients', 'icon': Icons.people_outline, 'path': '/psw/clients'},
        {'label': 'Timesheet', 'icon': Icons.timer_outlined, 'path': '/psw/timesheet'},
        {'label': 'Inbox', 'icon': Icons.inbox_outlined, 'path': '/psw/inbox'},
        {'label': 'Profile', 'icon': Icons.person_outline, 'path': '/psw/profile'},
        {'label': 'Daily Tasks', 'icon': Icons.task_alt, 'path': '/psw/dailyTasks'},
        {'label': 'Activities', 'icon': Icons.timeline_outlined, 'path': '/psw/activities'},
        {'label': 'My Role', 'icon': Icons.school_outlined, 'path': '/psw/mentor'},
      ];
    } else if (rolePrefix == 'rn') {
      activeColor = const Color(0xFF3B82F6);
      items = [
        {'label': 'Patients', 'icon': Icons.people_outline, 'path': '/rn/patients'},
        {'label': 'Inbox', 'icon': Icons.inbox_outlined, 'path': '/rn/inbox'},
        {'label': 'Profile', 'icon': Icons.person_outline, 'path': '/rn/profile'},
        {'label': 'Daily Tasks', 'icon': Icons.task_alt, 'path': '/rn/dailyTasks'},
        {'label': 'Activities', 'icon': Icons.timeline_outlined, 'path': '/rn/activities'},
        {'label': 'My Role', 'icon': Icons.school_outlined, 'path': '/rn/mentor'},
      ];
    } else if (rolePrefix == 'coordinator') {
      activeColor = const Color(0xFFF59E0B);
      items = [
        {'label': 'Jane Matrix', 'icon': Icons.calendar_month, 'path': '/coordinator/matrix'},
        {'label': 'Staff', 'icon': Icons.people_outline, 'path': '/coordinator/staff'},
        {'label': 'Approvals', 'icon': Icons.fact_check_outlined, 'path': '/coordinator/approvals'},
        {'label': 'Profile', 'icon': Icons.person_outline, 'path': '/coordinator/profile'},
        {'label': 'Inbox', 'icon': Icons.inbox_outlined, 'path': '/coordinator/inbox'},
        {'label': 'Live Map', 'icon': Icons.map_outlined, 'path': '/coordinator/live-map'},
        {'label': 'Daily Tasks', 'icon': Icons.task_alt, 'path': '/coordinator/dailyTasks'},
        {'label': 'Activities', 'icon': Icons.timeline_outlined, 'path': '/coordinator/activities'},
        {'label': 'My Role', 'icon': Icons.school_outlined, 'path': '/coordinator/mentor'},
      ];
    } else if (rolePrefix == 'admin') {
      activeColor = const Color(0xFF8B5CF6);
      items = [
        {'label': 'Network', 'icon': Icons.hub_outlined, 'path': '/admin/network'},
        {'label': 'Audit', 'icon': Icons.security_rounded, 'path': '/admin/audit'},
        {'label': 'Telemetry', 'icon': Icons.radar_outlined, 'path': '/admin/telemetry'},
        {'label': 'Settings', 'icon': Icons.settings_outlined, 'path': '/admin/settings'},
        {'label': 'Inbox', 'icon': Icons.inbox_outlined, 'path': '/admin/inbox'},
        {'label': 'Daily Tasks', 'icon': Icons.task_alt, 'path': '/admin/dailyTasks'},
        {'label': 'Activities', 'icon': Icons.timeline_outlined, 'path': '/admin/activities'},
        {'label': 'My Role', 'icon': Icons.school_outlined, 'path': '/admin/mentor'},
      ];
    } else if (rolePrefix == 'manager') {
      activeColor = const Color(0xFFF43F5E);
      items = [
        {'label': 'Mgmt Interface', 'icon': Icons.analytics, 'path': '/manager/analytics-matrix'},
        {'label': 'Reports', 'icon': Icons.bar_chart_outlined, 'path': '/manager/reports'},
        {'label': 'Teams', 'icon': Icons.group_work_outlined, 'path': '/manager/teams'},
        {'label': 'Profile', 'icon': Icons.person_outline, 'path': '/manager/profile'},
        {'label': 'Inbox', 'icon': Icons.inbox_outlined, 'path': '/manager/inbox'},
        {'label': 'Daily Tasks', 'icon': Icons.task_alt, 'path': '/manager/dailyTasks'},
        {'label': 'Activities', 'icon': Icons.timeline_outlined, 'path': '/manager/activities'},
        {'label': 'My Role', 'icon': Icons.school_outlined, 'path': '/manager/mentor'},
      ];
    } else if (rolePrefix == 'client') {
      activeColor = const Color(0xFF0EA5E9);
      items = [
        {'label': 'Pulse', 'icon': Icons.monitor_heart_outlined, 'path': '/client/pulse'},
        {'label': 'Profile', 'icon': Icons.person_outline, 'path': '/client/profile'},
        {'label': 'Inbox', 'icon': Icons.inbox_outlined, 'path': '/client/inbox'},
        {'label': 'Daily Tasks', 'icon': Icons.task_alt, 'path': '/client/dailyTasks'},
        {'label': 'Activities', 'icon': Icons.timeline_outlined, 'path': '/client/activities'},
        {'label': 'My Role', 'icon': Icons.school_outlined, 'path': '/client/mentor'},
      ];
    } else if (rolePrefix == 'mt') {
       activeColor = const Color(0xFF14B8A6);
       items = [
        {'label': 'Clients', 'icon': Icons.people_outline, 'path': '/mt/clients'},
        {'label': 'Messages', 'icon': Icons.chat_bubble_outline, 'path': '/mt/messages'},
        {'label': 'Inbox', 'icon': Icons.inbox_outlined, 'path': '/mt/inbox'},
        {'label': 'Daily Tasks', 'icon': Icons.task_alt, 'path': '/mt/dailyTasks'},
        {'label': 'Activities', 'icon': Icons.timeline_outlined, 'path': '/mt/activities'},
        {'label': 'My Role', 'icon': Icons.school_outlined, 'path': '/mt/mentor'},
      ];
    } else if (rolePrefix == 'gm') {
      activeColor = const Color(0xFF0284C7);
      items = [
        {'label': 'Inbox', 'icon': Icons.inbox_outlined, 'path': '/gm/inbox'},
        {'label': 'Daily Tasks', 'icon': Icons.task_alt, 'path': '/gm/dailyTasks'},
        {'label': 'Activities', 'icon': Icons.timeline_outlined, 'path': '/gm/activities'},
        {'label': 'My Role', 'icon': Icons.school_outlined, 'path': '/gm/mentor'},
      ];
    } else if (rolePrefix == 'scrum-master') {
      activeColor = const Color(0xFF9333EA);
      items = [
        {'label': 'Inbox', 'icon': Icons.inbox_outlined, 'path': '/scrum-master/inbox'},
        {'label': 'Daily Tasks', 'icon': Icons.task_alt, 'path': '/scrum-master/dailyTasks'},
        {'label': 'Activities', 'icon': Icons.timeline_outlined, 'path': '/scrum-master/activities'},
        {'label': 'My Role', 'icon': Icons.school_outlined, 'path': '/scrum-master/mentor'},
      ];
    } else {
      items = [];
    }

    return PrimeCareScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.grid_view_customize_rounded, size: 48, color: activeColor),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('System Hub: ${rolePrefix.toUpperCase()}', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: PrimeCareColors.radarDark)),
                    Text('Centralized operational modules and required access nodes.', style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600)),
                  ]
                )
              ]
            ),
            const SizedBox(height: 32),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final String p = item['path'];
                return InkWell(
                  onTap: () => context.go(p),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: activeColor.withValues(alpha: 0.2), width: 2),
                      boxShadow: [
                        BoxShadow(color: activeColor.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 4))
                      ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item['icon'], size: 48, color: activeColor),
                        const SizedBox(height: 12),
                        Text(item['label'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: PrimeCareColors.radarDark)),
                      ]
                    )
                  )
                );
              }
            )
          ]
        )
      )
    );
  }
}
