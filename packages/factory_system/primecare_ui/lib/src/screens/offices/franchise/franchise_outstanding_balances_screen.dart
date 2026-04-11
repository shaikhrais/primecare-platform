import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseOutstandingBalancesScreen extends ConsumerWidget {
  const FranchiseOutstandingBalancesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsyncValue = ref.watch(franchiseOutstandingBalancesDataProvider('all'));

    return PageTemplate(
      title: 'Outstanding Balances',
      subtitle: 'Monitor unpaid balances via API.',
      child: metricsAsyncValue.when(
        data: (liveData) => AssemblyLine(
          blueprints: liveData.blueprints,
          isOfflineFallback: liveData.isOfflineFallback,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
