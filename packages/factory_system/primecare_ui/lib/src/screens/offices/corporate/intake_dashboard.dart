import 'package:flutter/material.dart';
import 'intake_dashboard/intake_dashboard_screen.dart';

class IntakeDashboard extends StatelessWidget {
  const IntakeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Desktop wrapper representing the Intake workspace
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: IntakeDashboardScreen(),
    );
  }
}
