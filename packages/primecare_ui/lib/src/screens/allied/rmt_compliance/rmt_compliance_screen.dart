// Governance - Category: view | Purpose: Coordinator layout for RmtComplianceScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtComplianceScreen extends ConsumerWidget {
  const RmtComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('RmtComplianceScreen Coordinator'),
      ),
    );
  }
}
