// Governance - Category: view | Purpose: Coordinator layout for Prime Care
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrimeCareScreen extends ConsumerWidget {
  const PrimeCareScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Prime Care Coordinator'),
      ),
    );
  }
}
