import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseRefundsScreen extends ConsumerWidget {
  const FranchiseRefundsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsyncValue = ref.watch(franchiseRefundsDataProvider('all'));

    return PageTemplate(
      title: 'Franchise Refunds',
      subtitle: 'Manage and monitor credit adjustments.',
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
