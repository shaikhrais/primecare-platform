// Governance - Category: view | Purpose: Coordinator layout for Psw My Clients
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswMyClientsScreen extends ConsumerWidget {
  const PswMyClientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Psw My Clients Coordinator'),
      ),
    );
  }
}
