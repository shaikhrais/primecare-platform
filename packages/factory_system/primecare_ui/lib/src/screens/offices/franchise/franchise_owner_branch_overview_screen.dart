import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseOwnerBranchOverviewScreen extends ConsumerWidget {
  const FranchiseOwnerBranchOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'FranchiseOwnerBranchOverview',
        subtitle: '',
        provider: franchiseOwnerDashboardDataProvider('all'),
      );
}
