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
        '/psw/timesheets',
        '/psw/earnings',
        '/universal/psw/inbox',
      ];
      items = const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.schedule_send), label: 'Timesheet'),
        BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: 'Earnings'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Inbox'),
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
        '/coordinator/callin',
        '/coordinator/visit-adjust',
        '/universal/coordinator/inbox',
      ];
      items = const [
        BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Hub'),
        BottomNavigationBarItem(icon: Icon(Icons.fact_check), label: 'Approvals'),
        BottomNavigationBarItem(icon: Icon(Icons.phone_disabled), label: 'Call-in'),
        BottomNavigationBarItem(icon: Icon(Icons.edit_calendar), label: 'Adjust'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Inbox'),
      ];
    } else if (currentPath.startsWith('/manager')) {
      activeColor = const Color(0xFFF43F5E);
      paths = [
        '/manager/home', 
        '/manager/teams', 
        '/manager/payroll',
        '/manager/incidents',
        '/universal/manager/inbox'
      ];
      items = const [
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Reports'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Teams'),
        BottomNavigationBarItem(icon: Icon(Icons.payments), label: 'Payroll'),
        BottomNavigationBarItem(icon: Icon(Icons.warning), label: 'Escalations'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Inbox'),
      ];
    } else if (currentPath.startsWith('/admin')) {
      activeColor = const Color(0xFF8B5CF6);
      paths = ['/admin/home', '/admin/audit', '/universal/admin/inbox'];
      items = const [
        BottomNavigationBarItem(icon: Icon(Icons.radar), label: 'Telemetry'),
        BottomNavigationBarItem(icon: Icon(Icons.security), label: 'Shadows'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Inbox'),
      ];
    } else if (currentPath.startsWith('/client')) {
      activeColor = const Color(0xFF0EA5E9);
      paths = [
        '/client/home',
        '/client/pulse',
        '/client/dispatch',
        '/client/payments',
        '/universal/client/inbox'
      ];
      items = const [
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Team'),
        BottomNavigationBarItem(icon: Icon(Icons.monitor_heart), label: 'Pulse'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Tracker'),
        BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'Billing'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Inbox'),
      ];
    } else if (currentPath.startsWith('/gm')) {
      activeColor = const Color(0xFF6366F1);
      paths = ['/gm_home', '/gm/pnl', '/universal/gm/inbox'];
      items = const [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Executive'),
        BottomNavigationBarItem(icon: Icon(Icons.stacked_line_chart), label: 'Ledger'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Comm'),
      ];
    } else if (currentPath.startsWith('/mt')) {
      activeColor = const Color(0xFFF97316);
      paths = ['/mt/home', '/mt/surge-config', '/universal/mt/inbox'];
      items = const [
        BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Analytics'),
        BottomNavigationBarItem(icon: Icon(Icons.offline_bolt), label: 'Surge'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Inbox'),
      ];
    } else if (currentPath.startsWith('/superuser')) {
      activeColor = const Color(0xFFEF4444);
      paths = ['/superuser/home', '/superuser/territory', '/superuser/registry'];
      items = const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Root'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Territories'),
        BottomNavigationBarItem(icon: Icon(Icons.sync_problem), label: 'Registry'),
      ];
    } else if (currentPath.startsWith('/thin-hub')) {
      activeColor = Colors.grey;
      paths = ['/thin-hub'];
      items = const [
        BottomNavigationBarItem(icon: Icon(Icons.hub), label: 'Hub'),
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
              type: BottomNavigationBarType.fixed,
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
