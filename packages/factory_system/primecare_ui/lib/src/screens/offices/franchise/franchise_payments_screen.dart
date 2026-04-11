import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchisePaymentsScreen extends ConsumerWidget {
  const FranchisePaymentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsyncValue = ref.watch(franchisePaymentsDataProvider('all'));

    return PageTemplate(
      title: 'Franchise Payments',
      subtitle: 'Real-time payment transaction logs.',
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
