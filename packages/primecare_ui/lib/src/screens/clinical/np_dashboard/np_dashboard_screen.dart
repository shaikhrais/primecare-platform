import 'package:flutter/material.dart';
import '../../common/specialist_dashboard_shell.dart';

class NpDashboardScreen extends StatelessWidget {
  const NpDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => PrimeSpecialistDashboardShell(
    title: 'Nurse Practitioner Dashboard',
    actions: const [],
    body: PrimeSpecialistDashboardShell.unavailable('npdashboard_screen'),
  );
}
