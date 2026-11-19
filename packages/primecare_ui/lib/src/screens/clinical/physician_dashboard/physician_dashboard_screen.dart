import 'package:flutter/material.dart';
import '../../common/specialist_dashboard_shell.dart';

class PhysicianDashboardScreen extends StatelessWidget {
  const PhysicianDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => PrimeSpecialistDashboardShell(
    title: 'Physician Clinical Dashboard',
    actions: const [],
    body: PrimeSpecialistDashboardShell.unavailable(
      'physiciandashboard_screen',
    ),
  );
}
