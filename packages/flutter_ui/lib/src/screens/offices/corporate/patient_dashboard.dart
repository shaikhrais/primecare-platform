import 'package:flutter/material.dart';
import 'patient_dashboard_screen.dart';

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Desktop wrapper representing the patient workspace
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: PatientDashboardScreen(),
    );
  }
}
