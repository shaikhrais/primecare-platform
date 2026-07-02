// Governance - Category: view | Purpose: Coordinator layout for Cfo Franchise Financials
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoFranchiseFinancialsScreen extends ConsumerWidget {
  const CfoFranchiseFinancialsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Cfo Franchise Financials Coordinator'),
      ),
    );
  }
}
