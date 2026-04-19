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
    final forecasting = ref.watch(aiAnalyticsForecastingProvider);

    return PageTemplate(
      title: 'Clinical Intelligence',
      subtitle: 'High-fidelity operations and risk surveillance.',
      bodySections: [
        forecasting.when(
          data: (result) => result.fold(
            (data) => AIForecastingDashlet(data: data),
            (error) => const SizedBox.shrink(), // Gracefully hide forecasting if it fails
          ),
          loading: () => const SizedBox.shrink(),
          error: (e, st) => const SizedBox.shrink(),
        ),
        const SizedBox(height: 32),
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
