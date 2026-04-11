import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseOwnerDashboardScreen extends ConsumerWidget {
  const FranchiseOwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'FranchiseOwner',
        subtitle: '',
        provider: franchiseOwnerDashboardDataProvider('all'),
      );
}
