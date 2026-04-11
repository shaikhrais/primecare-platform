import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseOwnerHiringScreen extends ConsumerWidget {
  const FranchiseOwnerHiringScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'FranchiseOwnerHiring',
        subtitle: '',
        provider: franchiseOwnerDashboardDataProvider('all'),
      );
}
