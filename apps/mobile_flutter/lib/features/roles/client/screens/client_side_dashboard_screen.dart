import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ClientSideDashboardScreen extends StatelessWidget {
  const ClientSideDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PrimeCareAppBar(title: 'Client Side Dashboard'),
      body: Center(
        child: Text('Client Side view coming soon...'),
      ),
    );
  }
}
