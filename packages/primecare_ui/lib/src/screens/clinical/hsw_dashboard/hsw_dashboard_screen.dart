import 'package:flutter/material.dart';
import '../../common/specialist_dashboard_shell.dart';

class HswDashboardScreen extends StatelessWidget {
  const HswDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => PrimeSpecialistDashboardShell(
    title: 'HSW Clinical Dashboard',
    actions: const [],
    body: PrimeSpecialistDashboardShell.unavailable('hswdashboard_screen'),
  );
}
