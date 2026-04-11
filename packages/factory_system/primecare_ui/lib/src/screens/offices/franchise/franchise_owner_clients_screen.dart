import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseOwnerClientsScreen extends ConsumerWidget {
  const FranchiseOwnerClientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'FranchiseOwnerClients',
        subtitle: '',
        provider: franchiseOwnerDashboardDataProvider('all'),
      );
}
