// Governance - Category: view | Purpose: Coordinator layout for Billing Admin Invoices
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillingAdminInvoicesScreen extends ConsumerWidget {
  const BillingAdminInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Billing Admin Invoices Coordinator'),
      ),
    );
  }
}
