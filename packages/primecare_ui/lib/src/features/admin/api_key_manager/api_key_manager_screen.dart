// Governance - Category: view | Purpose: Coordinator layout for Api Key Manager
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiKeyManagerScreen extends ConsumerWidget {
  const ApiKeyManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Api Key Manager Coordinator'),
      ),
    );
  }
}
