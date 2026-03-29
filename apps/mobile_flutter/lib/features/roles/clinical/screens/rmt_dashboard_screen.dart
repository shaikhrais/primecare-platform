import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class RmtDashboardScreen extends StatelessWidget {
  const RmtDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PrimeCareAppBar(title: 'RMT Dashboard'),
      body: Center(
        child: Text('RMT view coming soon...'),
      ),
    );
  }
}
