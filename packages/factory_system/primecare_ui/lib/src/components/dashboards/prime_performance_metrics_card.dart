import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/src/shared/src/infrastructure/telemetry_service.dart';
import 'package:primecare_ui/src/theme/colors.dart';
import 'package:primecare_ui/src/components/primecare_card.dart';
import 'package:primecare_ui/src/components/primecare_progress_bar.dart';

class PrimePerformanceMetricsCard extends ConsumerWidget {
  final String onTimeArrivalRate;
  final String tasksLogged;
  final String patientRating;
  final double weeklyHoursProgress;
  final String weeklyHoursText;

  const PrimePerformanceMetricsCard({
    super.key,
    required this.onTimeArrivalRate,
    required this.tasksLogged,
    required this.patientRating,
    required this.weeklyHoursProgress,
    required this.weeklyHoursText,
  });

  Widget _buildStatMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            color: PrimeCareColors.slate400,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
        .read(executionGateProvider)
        .passGate(
          ExecutionGateCategory.metricsLayer,
          'Hydrating PerformanceMetrics: $tasksLogged tasks logged',
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Performance Metrics',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        const SizedBox(height: 12),
        PrimeCareCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatMetric(
                    'On-Time Arrival',
                    onTimeArrivalRate,
                    PrimeCareColors.emerald,
                  ),
                  _buildStatMetric(
                    'Tasks Logged',
                    tasksLogged,
                    Theme.of(context).primaryColor,
                  ),
                  _buildStatMetric(
                    'Patient Rating',
                    patientRating,
                    PrimeCareColors.amber,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Weekly Hours Target',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: PrimeCareColors.slate400,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: PrimeCareProgressBar(
                      progress: weeklyHoursProgress,
                      activeColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    weeklyHoursText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
