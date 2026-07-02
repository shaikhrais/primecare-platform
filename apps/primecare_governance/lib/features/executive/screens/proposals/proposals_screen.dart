// Governance - Category: view | Purpose: Coordinator layout for Proposals
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProposalsScreen extends ConsumerWidget {
  const ProposalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Proposals Coordinator'),
      ),
    );
  }
}
