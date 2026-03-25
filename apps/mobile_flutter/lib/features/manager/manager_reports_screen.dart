import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_mobile/features/manager/providers/manager_stats_provider.dart';

class ManagerReportsScreen extends ConsumerWidget {
  const ManagerReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStats = ref.watch(managerStatsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Manager Analytics Hub')),
      body: asyncStats.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning, color: Colors.amber, size: 64),
              const SizedBox(height: 16),
              Text('Network Error: $err', textAlign: TextAlign.center),
            ],
          ),
        ),
        data: (stats) {
          // Compute dynamic revenue and target from payload safely
          double latestRevenue = 0;
          double previousRevenue = 0;

          if (stats.revenue.isNotEmpty) {
            final revMap = stats.revenue.last as Map<String, dynamic>;
            latestRevenue = (revMap['actual'] as num?)?.toDouble() ?? 0;
            previousRevenue = (revMap['target'] as num?)?.toDouble() ?? 0;
          }

          int highRiskOT = 0;
          if (stats.overtimeRisk.isNotEmpty) {
            final otMap = stats.overtimeRisk.firstWhere(
              (e) => e['name'] == 'High Risk',
              orElse: () => {'value': 0},
            );
            highRiskOT = (otMap['value'] as num?)?.toInt() ?? 0;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MacroFinancialSummaryCard(
                  currentRevenue: latestRevenue,
                  targetRevenue: previousRevenue > 0 ? previousRevenue : 50000,
                ),
                const SizedBox(height: 24),
                // Replacing radar chart with native gauge metrics from payload for OT Risk
                PrimeCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Operational Risk Engine',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Critical Overtime Exposure:',
                            style: TextStyle(fontSize: 14),
                          ),
                          PrimeStatusBadge(
                            text: '$highRiskOT% Risk',
                            color: highRiskOT > 10 ? Colors.red : Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Timesheet Discrepancies',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const TimesheetDiscrepancyTable(), // Retaining as table struct
              ],
            ),
          );
        },
      ),
    );
  }
}
