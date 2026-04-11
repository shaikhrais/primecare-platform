import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchisePaymentsScreen extends ConsumerWidget {
  const FranchisePaymentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Franchise Payments',
        subtitle: 'Real-time payment transaction logs.',
        provider: franchisePaymentsDataProvider('all'),
      );
}
