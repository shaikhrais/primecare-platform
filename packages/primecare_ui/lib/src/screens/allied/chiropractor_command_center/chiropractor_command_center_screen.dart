// Governance - Category: view | Purpose: Coordinator layout for ChiropractorCommandCenterScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorCommandCenterScreen extends ConsumerWidget {
  const ChiropractorCommandCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('ChiropractorCommandCenterScreen Coordinator'),
      ),
    );
  }
}
