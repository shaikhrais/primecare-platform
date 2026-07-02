// Governance - Category: view | Purpose: Coordinator layout for Billing Invoices
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillingInvoicesScreen extends ConsumerWidget {
  const BillingInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Billing Invoices Coordinator'),
      ),
    );
  }
}
