import 'package:flutter/material.dart';
import '../../common/specialist_dashboard_shell.dart';

class LpnDashboardScreen extends StatelessWidget {
  const LpnDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => PrimeSpecialistDashboardShell(
    title: 'LPN Clinical Dashboard',
    actions: const [],
    body: PrimeSpecialistDashboardShell.unavailable('lpndashboard_screen'),
  );
}
