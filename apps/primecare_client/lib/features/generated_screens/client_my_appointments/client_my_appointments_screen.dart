// Governance - Category: view | Purpose: Coordinator layout for Client My Appointments
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientMyAppointmentsScreen extends ConsumerWidget {
  const ClientMyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Client My Appointments Coordinator'),
      ),
    );
  }
}
