import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/api_client.dart';

class PswShellScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const PswShellScreen({
    super.key,
    required this.navigationShell,
  });

  void _onTap(int index, BuildContext context) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
    Navigator.of(context).pop(); // Terminate drawer layout naturally
  }

  void _handleLogout(BuildContext context) async {
    await apiClient.logout();
    if (context.mounted) context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final titles = ['My Shifts', 'Assigned Clients', 'Timesheet & Payroll', 'Settings & Profile'];
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(titles[navigationShell.currentIndex], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: const Color(0xFF0EA5E9),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF0EA5E9)),
              accountName: Text('Personal Support Worker (PSW)', style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: Text('itpro.mohammed@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.health_and_safety, color: Color(0xFF0EA5E9), size: 36),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.calendar_month, color: Color(0xFF64748B)),
                    title: const Text('My Shifts', style: TextStyle(fontWeight: FontWeight.w600)),
                    selected: navigationShell.currentIndex == 0,
                    selectedTileColor: const Color(0x140EA5E9),
                    selectedColor: const Color(0xFF0EA5E9),
                    onTap: () => _onTap(0, context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.people_alt, color: Color(0xFF64748B)),
                    title: const Text('Assigned Clients', style: TextStyle(fontWeight: FontWeight.w600)),
                    selected: navigationShell.currentIndex == 1,
                    selectedTileColor: const Color(0x140EA5E9),
                    selectedColor: const Color(0xFF0EA5E9),
                    onTap: () => _onTap(1, context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.timer, color: Color(0xFF64748B)),
                    title: const Text('Timesheet', style: TextStyle(fontWeight: FontWeight.w600)),
                    selected: navigationShell.currentIndex == 2,
                    selectedTileColor: const Color(0x140EA5E9),
                    selectedColor: const Color(0xFF0EA5E9),
                    onTap: () => _onTap(2, context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings, color: Color(0xFF64748B)),
                    title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.w600)),
                    selected: navigationShell.currentIndex == 3,
                    selectedTileColor: const Color(0x140EA5E9),
                    selectedColor: const Color(0xFF0EA5E9),
                    onTap: () => _onTap(3, context),
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFFE11D48)),
              title: const Text('Sign Out', style: TextStyle(color: Color(0xFFE11D48), fontWeight: FontWeight.bold)),
              onTap: () => _handleLogout(context),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      body: navigationShell,
    );
  }
}
