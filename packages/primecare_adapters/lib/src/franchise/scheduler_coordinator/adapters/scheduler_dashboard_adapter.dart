import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final schedulerDashboardAdapterProvider =
    FutureProvider<Result<SchedulerCoordinatorDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'scheduler_coordinator_dashboard';

      return Result.guardFuture<SchedulerCoordinatorDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<
            SchedulerCoordinatorDashboardViewModel
          >(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching Scheduler Coordinator Metrics: $endpoint',
              );

              final response = await apiClient.get(
                '$endpoint?route=SchedulerCoordinator',
              );

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'Scheduler Coordinator Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel =
                    SchedulerCoordinatorDashboardViewModel.fromDashboardMetrics(
                      metrics,
                    );

                // Background hydration of LKG cache with real serialized data
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'Scheduler Coordinator API Error: ${response.statusCode}',
                  metadata: {'status': response.statusCode},
                );
                return SchedulerCoordinatorDashboardViewModel.assemble(
                  isOffline: true,
                );
              }
            },
            fallbackBuilder: () {
              telemetry.failGate(
                ExecutionGateCategory.metricsLayer,
                'Scheduler Coordinator Logistics Fallback Triggered',
              );
              return SchedulerCoordinatorDashboardViewModel.assemble(
                isOffline: true,
              );
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in Scheduler Coordinator Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring Scheduler Coordinator Dashboard from LKG snapshot',
            );
            return SchedulerCoordinatorDashboardViewModel.fromJson(snapshot);
          }
          return SchedulerCoordinatorDashboardViewModel.assemble(isOffline: true);
        },
      );
    });
