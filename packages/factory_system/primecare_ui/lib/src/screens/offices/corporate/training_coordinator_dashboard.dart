import 'package:flutter/material.dart';
import 'training_coordinator_dashboard/training_coordinator_dashboard_screen.dart';

class TrainingCoordinatorDashboard extends StatelessWidget {
  const TrainingCoordinatorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Desktop wrapper representing the Training Coordinator workspace
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: TrainingCoordinatorDashboardScreen(),
    );
  }
}
