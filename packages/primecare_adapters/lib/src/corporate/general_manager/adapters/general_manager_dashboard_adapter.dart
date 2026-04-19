import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final generalManagerDashboardAdapterProvider =
    FutureProvider<Result<GeneralManagerDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'general_manager_dashboard';

      return Result.guardFuture<GeneralManagerDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<
            GeneralManagerDashboardViewModel
          >(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching General Manager Metrics: $endpoint',
              );

              final response = await apiClient.get(
                '$endpoint?route=GeneralManager',
              );

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'General Manager Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel =
                    GeneralManagerDashboardViewModel.fromDashboardMetrics(
                      metrics,
                    );

                // Background hydration of LKG cache with real serialized data
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'General Manager Metrics API Error: ${response.statusCode}',
                  metadata: {'status': response.statusCode},
                );
                return GeneralManagerDashboardViewModel.assemble(isOffline: true);
              }
            },
            fallbackBuilder: () {
              telemetry.failGate(
                ExecutionGateCategory.metricsLayer,
                'General Manager Metrics Logistics Fallback Triggered',
              );
              return GeneralManagerDashboardViewModel.assemble(isOffline: true);
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in General Manager Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring General Manager Dashboard from LKG snapshot',
            );
            return GeneralManagerDashboardViewModel.fromJson(snapshot);
          }
          return GeneralManagerDashboardViewModel.assemble(isOffline: true);
        },
      );
    });
