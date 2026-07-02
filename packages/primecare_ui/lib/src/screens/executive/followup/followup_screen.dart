// Governance - Category: view | Purpose: Coordinator layout for FollowupScreen
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FollowupScreen extends ConsumerWidget {
  const FollowupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('FollowupScreen Coordinator'),
      ),
    );
  }
}
