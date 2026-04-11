import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/src/components/layouts/provider_layout.dart';
import 'package:primecare_ui/src/components/primecare_stat_card.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TerritoryExpansionManagerOpenTerritoriesScreen extends ConsumerWidget {
  const TerritoryExpansionManagerOpenTerritoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsyncValue = ref.watch(territoryExpansionManagerOpenTerritoriesDataProvider('all'));

    return ProviderLayout(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Territory Expansion Manager Open Territories',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Real-time overview fetched natively via API.',
              style: TextStyle(
                color: Colors.white.withAlpha(178),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),

            metricsAsyncValue.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(64.0),
                  child: CircularProgressIndicator(color: Colors.tealAccent),
                ),
              ),
              error: (error, stackTrace) => Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withAlpha(25),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.redAccent.withAlpha(76)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      LucideIcons.alertTriangle,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Failed to load live metrics for territoryExpansionManagerOpenTerritories: \n$error',
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ],
                ),
              ),
              data: (TerritoryExpansionManagerOpenTerritoriesDashboardViewModel liveData) {
                return AssemblyLine(
                  blueprints: liveData.blueprints,
                  isOfflineFallback: liveData.isOfflineFallback,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  