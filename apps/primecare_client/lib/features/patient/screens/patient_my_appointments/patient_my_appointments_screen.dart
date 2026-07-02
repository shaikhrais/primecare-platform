// Governance - Category: view | Purpose: Coordinator layout for Patient My Appointments
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientMyAppointmentsScreen extends ConsumerWidget {
  const PatientMyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Patient My Appointments Coordinator'),
      ),
    );
  }
}
