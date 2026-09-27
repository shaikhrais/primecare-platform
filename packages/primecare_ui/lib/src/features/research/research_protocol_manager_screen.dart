// Governance - Category: view | Purpose: Coordinator layout for Research Protocol Manager
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResearchProtocolManagerScreen extends ConsumerWidget {
  const ResearchProtocolManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Research Protocol Manager Coordinator'),
      ),
    );
  }
}
