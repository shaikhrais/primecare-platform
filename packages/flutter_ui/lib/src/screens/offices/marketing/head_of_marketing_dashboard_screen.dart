import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_adapters/primecare_adapters.dart';
import 'package:flutter_ui/flutter_ui.dart';

class HeadOfMarketingDashboardScreen extends ConsumerWidget {
  const HeadOfMarketingDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Subscribe to live data using the specific route metric.
    final viewModelAsyncValue = ref.watch(
      headOfMarketingDashboardAdapterProvider,
    );

    return ProviderLayout(
      child: viewModelAsyncValue.when(
        data: (viewModel) => PageTemplate(
          title: 'HeadOfMarketingDashboardScreen',
          subtitle: 'Real-time metrics and alerts',
          kpiCards: viewModel.kpis
              .map(
                (kpi) => Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          kpi.label,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          kpi.value,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        if (kpi.trend != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            kpi.trend!,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: Colors.blueGrey),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
          children: [
            if (viewModel.recentActivity.isNotEmpty) ...[
              Text(
                'Recent Activity',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              ...viewModel.recentActivity.map(
                (log) => ListTile(
                  title: Text(log.title),
                  subtitle: Text(log.timestamp.toString()),
                ),
              ),
            ],
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
