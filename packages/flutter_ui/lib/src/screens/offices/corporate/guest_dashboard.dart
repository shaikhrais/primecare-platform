import 'package:flutter/material.dart';
import 'guest_dashboard/guest_dashboard_screen.dart';

class GuestDashboard extends StatelessWidget {
  const GuestDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Desktop wrapper representing the guest workspace
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: GuestDashboardScreen(),
    );
  }
}
