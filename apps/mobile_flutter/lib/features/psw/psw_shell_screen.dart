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
  }

  void _handleLogout(BuildContext context) async {
    await apiClient.logout();
    if (context.mounted) context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => _onTap(index, context),
        backgroundColor: Colors.white,
        indicatorColor: const Color(0x3310B981), // Glassmorphic Emerald Marker
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_month, color: Color(0xFF10B981)),
            label: 'Shifts',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people, color: Color(0xFF10B981)),
            label: 'Clients',
          ),
          NavigationDestination(
            icon: Icon(Icons.timer_outlined),
            selectedIcon: Icon(Icons.timer, color: Color(0xFF10B981)),
            label: 'Timesheet',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: Color(0xFF10B981)),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
