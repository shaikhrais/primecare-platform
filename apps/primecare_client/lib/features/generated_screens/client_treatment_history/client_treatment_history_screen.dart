// Governance - Category: view | Purpose: Coordinator layout for Client Treatment History
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientTreatmentHistoryScreen extends ConsumerWidget {
  const ClientTreatmentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Client Treatment History Coordinator'),
      ),
    );
  }
}
