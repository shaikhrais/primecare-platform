import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_adapters/primecare_adapters.dart';
import 'package:flutter_ui/src/components/page_template.dart';

import 'sections/coo_kpi_section.dart';

class CooDashboardScreen extends ConsumerWidget {
  const CooDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsyncValue = ref.watch(cooDashboardAdapterProvider);

    return PageTemplate(
      title: 'Coo Dashboard',
      subtitle: 'Real-time overview fetched natively via API.',
      kpiCards: metricsAsyncValue.when(
        loading: () => [
          const Center(child: CircularProgressIndicator(color: Colors.tealAccent)),
        ],
        error: (error, stackTrace) => [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.redAccent.withAlpha(25),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.redAccent.withAlpha(76)),
            ),
            child: Row(
              children: [
                const Icon(LucideIcons.alertTriangle, color: Colors.redAccent),
                const SizedBox(width: 16),
                Expanded(
                  child: Text('Failed to load live metrics: \n$error', style: const TextStyle(color: Colors.redAccent)),
                ),
              ],
            ),
          ),
        ],
        data: (liveData) => CooKpiSection.buildCards(liveData),
      ),
      bodySections: const [
        // Advanced components (Charts, Maps, Grids) go here based on role
      ],
    );
  }
}
