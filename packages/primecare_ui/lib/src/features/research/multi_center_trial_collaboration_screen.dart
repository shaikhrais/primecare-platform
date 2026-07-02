// Governance - Category: view | Purpose: Coordinator layout for Multi Center Trial Collaboration
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MultiCenterTrialCollaborationScreen extends ConsumerWidget {
  const MultiCenterTrialCollaborationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Multi Center Trial Collaboration Coordinator'),
      ),
    );
  }
}
