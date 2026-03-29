import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ClientGranularDashboardScreen extends StatelessWidget {
  const ClientGranularDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PrimeCareAppBar(title: 'Client Dashboard'),
      body: Center(
        child: Text('Client view coming soon...'),
      ),
    );
  }
}
