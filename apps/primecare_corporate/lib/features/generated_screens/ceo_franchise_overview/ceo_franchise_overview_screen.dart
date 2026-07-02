// Governance - Category: view | Purpose: Coordinator layout for Ceo Franchise Overview
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CeoFranchiseOverviewScreen extends ConsumerWidget {
  const CeoFranchiseOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Ceo Franchise Overview Coordinator'),
      ),
    );
  }
}
