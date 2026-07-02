// Governance - Category: view | Purpose: Coordinator layout for Psw My Shifts
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswMyShiftsScreen extends ConsumerWidget {
  const PswMyShiftsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Psw My Shifts Coordinator'),
      ),
    );
  }
}
