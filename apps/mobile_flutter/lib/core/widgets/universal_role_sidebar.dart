import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    int currentIndex = 0;
    List<String> paths = [];
    List<BottomNavigationBarItem> items = [];
    Color activeColor = Colors.blue;

    if (currentPath.startsWith('/psw')) {
      activeColor = const Color(0xFF10B981);
      paths = [
        '/psw/home',
        '/universal/psw/inbox',
        '/universal/psw/dailyTasks',
      ];
      items = const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Messages'),
        BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
      ];
    } else if (currentPath.startsWith('/rn')) {
      activeColor = const Color(0xFF3B82F6);
      paths = ['/rn/home', '/rn/care-plan', '/universal/rn/inbox'];
      items = const [
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Patients'),
        BottomNavigationBarItem(icon: Icon(Icons.edit_document), label: 'Plan'),
        BottomNavigationBarItem(icon: Icon(Icons.inbox), label: 'Inbox'),
      ];
    } else if (currentPath.startsWith('/coordinator')) {
      activeColor = const Color(0xFFF59E0B);
      paths = [
        '/coordinator/home',
        '/coordinator/approvals',
        '/universal/coordinator/inbox',
      ];
      items = const [
        BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Hub'),
        BottomNavigationBarItem(
          icon: Icon(Icons.fact_check),
          label: 'Approvals',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Inbox'),
      ];
    } else if (currentPath.startsWith('/manager')) {
      activeColor = const Color(0xFFF43F5E);
      paths = ['/manager/home', '/manager/teams', '/universal/manager/inbox'];
      items = const [
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Reports'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Teams'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Inbox'),
      ];
    } else if (currentPath.startsWith('/admin')) {
      activeColor = const Color(0xFF8B5CF6);
      paths = ['/admin/home', '/universal/admin/inbox'];
      items = const [
        BottomNavigationBarItem(icon: Icon(Icons.radar), label: 'Telemetry'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Inbox'),
      ];
    } else if (currentPath.startsWith('/client')) {
      activeColor = const Color(0xFF0EA5E9);
      paths = ['/client/home', '/client/pulse', '/universal/client/inbox'];
      items = const [
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Team'),
        BottomNavigationBarItem(
          icon: Icon(Icons.monitor_heart),
          label: 'Pulse',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Inbox'),
      ];
    } else {
      paths = ['/psw/home'];
      items = const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      ];
    }

    currentIndex = paths.indexWhere((p) => p == currentPath);
    if (currentIndex == -1) currentIndex = 0;

    return Scaffold(
      body: child,
      bottomNavigationBar: items.length > 1
          ? BottomNavigationBar(
              currentIndex: currentIndex,
              selectedItemColor: activeColor,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                if (index < paths.length) context.go(paths[index]);
              },
              items: items,
            )
          : null,
    );
  }
}
