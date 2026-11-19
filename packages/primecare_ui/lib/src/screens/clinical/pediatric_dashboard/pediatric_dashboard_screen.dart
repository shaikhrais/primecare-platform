import 'package:flutter/material.dart';
import '../../common/specialist_dashboard_shell.dart';

class PediatricDashboardScreen extends StatelessWidget {
  const PediatricDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => PrimeSpecialistDashboardShell(
    title: 'Pediatric Clinical Dashboard',
    actions: const [],
    body: PrimeSpecialistDashboardShell.unavailable(
      'pediatricdashboard_screen',
    ),
  );
}
