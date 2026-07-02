// Governance - Category: view | Purpose: Coordinator layout for Cfo Accounts Receivable
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoAccountsReceivableScreen extends ConsumerWidget {
  const CfoAccountsReceivableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Cfo Accounts Receivable Coordinator'),
      ),
    );
  }
}
