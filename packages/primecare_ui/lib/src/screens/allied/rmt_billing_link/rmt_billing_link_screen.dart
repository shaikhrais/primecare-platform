// Governance - Category: view | Purpose: Coordinator layout for RmtBillingLinkScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtBillingLinkScreen extends ConsumerWidget {
  const RmtBillingLinkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('RmtBillingLinkScreen Coordinator'),
      ),
    );
  }
}
