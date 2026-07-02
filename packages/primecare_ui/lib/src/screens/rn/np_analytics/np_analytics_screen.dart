// Governance - Category: view | Purpose: Coordinator layout for Nurse Practitioner (NP) Analytics
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NpAnalyticsScreen extends ConsumerWidget {
  const NpAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Nurse Practitioner (NP) Analytics Coordinator'),
      ),
    );
  }
}
