// Governance - Category: view | Purpose: Coordinator layout for IntakeCoordinatorDocumentsScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorDocumentsScreen extends ConsumerWidget {
  const IntakeCoordinatorDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('IntakeCoordinatorDocumentsScreen Coordinator'),
      ),
    );
  }
}
