import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/src/shared/src/infrastructure/telemetry_service.dart';
import 'package:primecare_ui/src/shared/src/models/core/dashboard_models.dart';
import 'package:primecare_ui/src/theme/colors.dart';
import 'package:primecare_ui/src/components/primecare_card.dart';
import 'package:primecare_ui/src/components/charts/prime_care_line_chart.dart';

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
                    'Total Payout',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: PrimeCareColors.slate400,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    totalPayout,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 18,
                      color: PrimeCareColors.emerald,
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
