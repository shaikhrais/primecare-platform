// Governance - Category: view | Purpose: Coordinator layout for Ceo Strategic Kpis
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CeoStrategicKpisScreen extends ConsumerWidget {
  const CeoStrategicKpisScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Ceo Strategic Kpis Coordinator'),
      ),
    );
  }
}
