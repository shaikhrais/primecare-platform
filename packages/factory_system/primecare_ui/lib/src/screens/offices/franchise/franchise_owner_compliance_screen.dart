import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseOwnerComplianceScreen extends ConsumerWidget {
  const FranchiseOwnerComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'FranchiseOwnerCompliance',
        subtitle: '',
        provider: franchiseOwnerDashboardDataProvider('all'),
      );
}
