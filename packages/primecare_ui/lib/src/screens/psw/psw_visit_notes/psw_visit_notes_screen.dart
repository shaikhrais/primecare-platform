// Governance - Category: view | Purpose: Coordinator layout for Visit Notes
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswVisitNotesScreen extends ConsumerWidget {
  const PswVisitNotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Visit Notes Coordinator'),
      ),
    );
  }
}
