import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_core/flutter_core.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We use the specialized clinicIntelligenceProvider with the 'clinicIntelligence' family key
    final intelligence = ref.watch(clinicIntelligenceProvider('clinicIntelligence'));

    return PageTemplate(
      title: 'Clinical Intelligence',
      subtitle: 'High-fidelity operations and risk surveillance.',
      bodySections: [
        intelligence.when(
          data: (data) => AssemblyLine(
            blueprints: data.blueprints,
            isOfflineFallback: data.isOfflineFallback,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, st) => Center(
            child: Text('Error loading intelligence: $err'),
          ),
        ),
      ],
    );
  }
}
