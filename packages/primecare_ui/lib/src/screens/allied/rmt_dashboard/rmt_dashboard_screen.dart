import 'package:flutter/material.dart';
import '../../common/specialist_dashboard_shell.dart';

class RmtDashboardScreen extends StatelessWidget {
  const RmtDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => PrimeSpecialistDashboardShell(
    title: 'RMT Clinical Dashboard',
    actions: const [],
    body: PrimeSpecialistDashboardShell.unavailable('rmtdashboard_screen'),
  );
}
