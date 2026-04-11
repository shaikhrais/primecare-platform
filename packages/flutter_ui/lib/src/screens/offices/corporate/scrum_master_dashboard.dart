import 'package:flutter/material.dart';
import 'scrum_master_dashboard/scrum_master_dashboard_screen.dart';

class ScrumMasterDashboard extends StatelessWidget {
  const ScrumMasterDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Desktop wrapper representing the scrum_master workspace
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: ScrumMasterDashboardScreen(),
    );
  }
}
