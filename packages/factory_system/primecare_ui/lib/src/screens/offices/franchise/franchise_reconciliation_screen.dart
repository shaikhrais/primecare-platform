import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseReconciliationScreen extends ConsumerWidget {
  const FranchiseReconciliationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'FranchiseReconciliation',
        subtitle: '',
        provider: franchiseReconciliationDataProvider('all'),
      );
}
