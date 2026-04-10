import 'package:flutter/material.dart';
import 'support_dashboard_screen.dart';

class SupportDashboard extends StatelessWidget {
  const SupportDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Desktop wrapper representing the Support workspace
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SupportDashboardScreen(),
    );
  }
}
