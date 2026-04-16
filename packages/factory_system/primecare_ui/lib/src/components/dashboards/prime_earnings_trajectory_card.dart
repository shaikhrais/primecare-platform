import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PrimeEarningsTrajectoryCard extends ConsumerWidget {
  final String title;
  final String totalPayout;
  final Map<String, double> trajectoryData;

  const PrimeEarningsTrajectoryCard({
    super.key,
    required this.title,
    required this.totalPayout,
    required this.trajectoryData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
        .read(executionGateProvider)
        .passGate(
          ExecutionGateCategory.auraEngine,
          'Hydrating Trajectory: $title',
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        const SizedBox(height: 12),
        PrimeCareCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Payout",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    totalPayout,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              PrimeCareLineChart(
                chart: AnalyticsChart(
                  id: 'trajectory',
                  title: title,
                  type: ChartType.line,
                  dataPoints: trajectoryData.entries
                      .map((e) => ChartDataPoint(label: e.key, value: e.value))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
