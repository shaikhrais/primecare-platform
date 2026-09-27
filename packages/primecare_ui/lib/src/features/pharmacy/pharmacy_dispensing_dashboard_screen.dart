// Governance - Category: view | Purpose: Coordinator layout for Pharmacy Dispensing Dashboard
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PharmacyDispensingDashboardScreen extends ConsumerWidget {
  const PharmacyDispensingDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Pharmacy Dispensing Dashboard Coordinator'),
      ),
    );
  }
}
