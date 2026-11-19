import 'package:flutter/material.dart';
import '../../common/specialist_dashboard_shell.dart';

class CnsDashboardScreen extends StatelessWidget {
  const CnsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => PrimeSpecialistDashboardShell(
    title: 'CNS Clinical Dashboard',
    actions: const [],
    body: PrimeSpecialistDashboardShell.unavailable('cnsdashboard_screen'),
  );
}
