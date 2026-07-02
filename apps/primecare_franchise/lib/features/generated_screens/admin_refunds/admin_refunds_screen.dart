// Governance - Category: view | Purpose: Coordinator layout for Admin Refunds
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminRefundsScreen extends ConsumerWidget {
  const AdminRefundsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Admin Refunds Coordinator'),
      ),
    );
  }
}
