// Governance - Category: view | Purpose: Coordinator layout for Local Marketing Manager Budget
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalMarketingManagerBudgetScreen extends ConsumerWidget {
  const LocalMarketingManagerBudgetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Local Marketing Manager Budget Coordinator'),
      ),
    );
  }
}
