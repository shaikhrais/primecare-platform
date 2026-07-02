// Governance - Category: view | Purpose: Coordinator layout for Regional Bdm Reports
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalBdmReportsScreen extends ConsumerWidget {
  const RegionalBdmReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Regional Bdm Reports Coordinator'),
      ),
    );
  }
}
