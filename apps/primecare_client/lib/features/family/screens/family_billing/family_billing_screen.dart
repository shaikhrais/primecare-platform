// Governance - Category: view | Purpose: Coordinator layout for Family Billing
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyBillingScreen extends ConsumerWidget {
  const FamilyBillingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Family Billing Coordinator'),
      ),
    );
  }
}
