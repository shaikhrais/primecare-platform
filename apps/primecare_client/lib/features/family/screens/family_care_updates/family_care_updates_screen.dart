// Governance - Category: view | Purpose: Coordinator layout for Family Care Updates
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyCareUpdatesScreen extends ConsumerWidget {
  const FamilyCareUpdatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Family Care Updates Coordinator'),
      ),
    );
  }
}
