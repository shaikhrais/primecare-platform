import 'package:flutter/material.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';
import 'package:primecare_adapters/primecare_adapters.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Standardized Dashboard Architecture: The Adapter orchestrates all data fetching (Metrics + AI AI Analytics)
    // and maps it to a unified UI Blueprint collection consumed by the AssemblyLine.
    final adapter = ref.watch(clinicDashboardAdapterProvider);

    return PageTemplate(
      title: 'Clinical Intelligence',
      subtitle: 'High-fidelity operations and risk surveillance.',
      bodySections: [
        adapter.when(
          data: (result) => result.fold(
            (data) => AssemblyLine(
              blueprints: data.blueprints,
              isOfflineFallback: data.isOfflineFallback,
            ),
            (error) => Center(
              child: Text('Error loading clinic intelligence: $error'),
            ),
          ),
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (err, st) => Center(child: Text('Infrastructure Error: $err')),
        ),
      ],
    );
  }
}
