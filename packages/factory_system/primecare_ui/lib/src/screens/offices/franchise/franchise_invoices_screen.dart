import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseInvoicesScreen extends ConsumerWidget {
  const FranchiseInvoicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsyncValue = ref.watch(franchiseInvoicesDataProvider('all'));

    return PageTemplate(
      title: 'Franchise Invoices',
      subtitle: 'Overview of all client invoices.',
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
