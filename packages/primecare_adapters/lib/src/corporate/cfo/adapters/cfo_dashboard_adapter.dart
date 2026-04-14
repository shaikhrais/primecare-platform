import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final cfoDashboardAdapterProvider =
    FutureProvider<Result<CfoDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'cfo_dashboard';

      return Result.guardFuture<CfoDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<CfoDashboardViewModel>(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching CFO Metrics: $endpoint',
              );

              final response = await apiClient.get('$endpoint?route=Cfo');

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'Cfo Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel = CfoDashboardViewModel.fromDashboardMetrics(
                  metrics,
                );

                // Background hydration of LKG cache with real serialized data
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'Cfo Metrics API Error: ${response.statusCode}',
                  metadata: {'status': response.statusCode},
                );
                throw Exception(
                  'API error loading dashboard: ${response.statusCode}',
                );
              }
            },
            fallbackBuilder: () {
              telemetry.failGate(
                ExecutionGateCategory.metricsLayer,
                'Cfo Metrics Logistics Fallback Triggered',
              );
              return CfoDashboardViewModel.assemble(isOffline: true);
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.metricsLayer,
            'Deterministic Adapter Failure: CFO Dashboard',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring CFO Dashboard from LKG snapshot',
            );
            return CfoDashboardViewModel.fromJson(snapshot);
          }
          throw e;
        },
      );
    });
