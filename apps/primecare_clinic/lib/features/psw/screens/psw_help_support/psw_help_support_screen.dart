// Governance - Category: view | Purpose: Coordinator layout for Psw Help Support
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswHelpSupportScreen extends ConsumerWidget {
  const PswHelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Psw Help Support Coordinator'),
      ),
    );
  }
}
