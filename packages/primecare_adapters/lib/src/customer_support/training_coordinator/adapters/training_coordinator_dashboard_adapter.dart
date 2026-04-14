import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final trainingCoordinatorDashboardAdapterProvider =
    FutureProvider<Result<TrainingCoordinatorDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'training_coordinator_dashboard';

      return Result.guardFuture<TrainingCoordinatorDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<
            TrainingCoordinatorDashboardViewModel
          >(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching Training Coordinator Metrics: $endpoint',
              );

              final response = await apiClient.get(
                '$endpoint?route=TrainingCoordinator',
              );

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'Training Coordinator Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel =
                    TrainingCoordinatorDashboardViewModel.fromDashboardMetrics(
                      metrics,
                    );

                // Background hydration of LKG cache with real serialized data
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'Training Coordinator API Error: ${response.statusCode}',
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
                'Training Coordinator Logistics Fallback Triggered',
              );
              return TrainingCoordinatorDashboardViewModel.assemble(isOffline: true);
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in Training Coordinator Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring Training Coordinator Dashboard from LKG snapshot',
            );
            return TrainingCoordinatorDashboardViewModel.fromJson(snapshot);
          }
          throw e;
        },
      );
    });
