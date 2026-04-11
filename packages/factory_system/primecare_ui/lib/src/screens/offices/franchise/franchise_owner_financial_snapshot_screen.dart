import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseOwnerFinancialSnapshotScreen extends ConsumerWidget {
  const FranchiseOwnerFinancialSnapshotScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'FranchiseOwnerFinancialSnapshot',
        subtitle: '',
        provider: franchiseOwnerDashboardDataProvider('all'),
      );
}
