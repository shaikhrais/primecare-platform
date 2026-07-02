// Governance - Category: view | Purpose: Coordinator layout for Surgical Video Archive
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SurgicalVideoArchiveScreen extends ConsumerWidget {
  const SurgicalVideoArchiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Surgical Video Archive Coordinator'),
      ),
    );
  }
}
