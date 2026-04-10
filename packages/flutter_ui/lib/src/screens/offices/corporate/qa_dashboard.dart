import 'package:flutter/material.dart';
import 'qa_dashboard_screen.dart';

class QaDashboard extends StatelessWidget {
  const QaDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Desktop wrapper representing the Qa workspace
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: QaDashboardScreen(),
    );
  }
}
