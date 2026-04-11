import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseOutstandingBalancesScreen extends ConsumerWidget {
  const FranchiseOutstandingBalancesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Outstanding Balances',
        subtitle: 'Monitor unpaid balances via API.',
        provider: franchiseOutstandingBalancesDataProvider('all'),
      );
}
