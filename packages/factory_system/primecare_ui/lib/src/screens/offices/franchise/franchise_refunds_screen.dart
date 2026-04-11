import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseRefundsScreen extends ConsumerWidget {
  const FranchiseRefundsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Franchise Refunds',
        subtitle: 'Manage and monitor credit adjustments.',
        provider: franchiseRefundsDataProvider('all'),
      );
}
