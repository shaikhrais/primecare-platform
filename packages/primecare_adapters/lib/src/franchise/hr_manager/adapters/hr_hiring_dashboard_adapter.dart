import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final hrHiringDashboardAdapterProvider =
    FutureProvider<Result<HrHiringDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'hr_hiring_dashboard';

      return Result.guardFuture<HrHiringDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<HrHiringDashboardViewModel>(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching HR Metrics: $endpoint',
              );

              final response = await apiClient.get('$endpoint?route=HrHiring');

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'HR Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel = HrHiringDashboardViewModel.fromDashboardMetrics(
                  metrics,
                );

                // Background hydration of LKG cache with real serialized data
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'HR Metrics API Error: ${response.statusCode}',
                  metadata: {'status': response.statusCode},
                );
                return HrHiringDashboardViewModel.assemble(isOffline: true);
              }
            },
            fallbackBuilder: () {
              telemetry.failGate(
                ExecutionGateCategory.metricsLayer,
                'HR Metrics Logistics Fallback Triggered',
              );
              return HrHiringDashboardViewModel.assemble(isOffline: true);
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.metricsLayer,
            'Deterministic Adapter Failure: HR Hiring',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring HR Hiring Dashboard from LKG snapshot',
            );
            return HrHiringDashboardViewModel.fromJson(snapshot);
          }
          return HrHiringDashboardViewModel.assemble(isOffline: true);
        },
      );
    });
