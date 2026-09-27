// Governance - Category: view | Purpose: Coordinator layout for Biospecimen Inventory Tracker
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BiospecimenInventoryTrackerScreen extends ConsumerWidget {
  const BiospecimenInventoryTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Biospecimen Inventory Tracker Coordinator'),
      ),
    );
  }
}
