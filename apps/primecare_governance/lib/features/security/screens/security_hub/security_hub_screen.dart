// Governance - Category: view | Purpose: Coordinator layout for Security Hub
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecurityHubScreen extends ConsumerWidget {
  const SecurityHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Security Hub Coordinator'),
      ),
    );
  }
}
