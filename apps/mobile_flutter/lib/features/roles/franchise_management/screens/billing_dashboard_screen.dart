import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class BillingDashboardScreen extends StatelessWidget {
  const BillingDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PrimeCareAppBar(title: 'Billing / Admin Dashboard'),
      body: Center(
        child: Text('Billing / Admin view coming soon...'),
      ),
    );
  }
}
