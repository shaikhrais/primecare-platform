// Governance - Category: view | Purpose: Coordinator layout for Verification Center
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerificationCenterScreen extends ConsumerWidget {
  const VerificationCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Verification Center Coordinator'),
      ),
    );
  }
}
