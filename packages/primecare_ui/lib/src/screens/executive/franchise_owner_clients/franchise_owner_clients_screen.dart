// Governance - Category: view | Purpose: Coordinator layout for FranchiseOwnerClientsScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseOwnerClientsScreen extends ConsumerWidget {
  const FranchiseOwnerClientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('FranchiseOwnerClientsScreen Coordinator'),
      ),
    );
  }
}
