import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final intakeDashboardAdapterProvider =
    FutureProvider<Result<IntakeCoordinatorDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'intake_coordinator_dashboard';

      return Result.guardFuture<IntakeCoordinatorDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<
            IntakeCoordinatorDashboardViewModel
          >(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching Intake Coordinator Metrics: $endpoint',
              );

              final response = await apiClient.get(
                '$endpoint?route=IntakeCoordinator',
              );

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'Intake Coordinator Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel =
                    IntakeCoordinatorDashboardViewModel.fromDashboardMetrics(
                      metrics,
                    );

                // Background hydration of LKG cache with real serialized data
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'Intake Coordinator API Error: ${response.statusCode}',
                  metadata: {'status': response.statusCode},
                );
                return IntakeCoordinatorDashboardViewModel.assemble(isOffline: true);
              }
            },
            fallbackBuilder: () {
              telemetry.failGate(
                ExecutionGateCategory.metricsLayer,
                'Intake Coordinator Logistics Fallback Triggered',
              );
              return IntakeCoordinatorDashboardViewModel.assemble(isOffline: true);
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in Intake Coordinator Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring Intake Coordinator Dashboard from LKG snapshot',
            );
            return IntakeCoordinatorDashboardViewModel.fromJson(snapshot);
          }
          return IntakeCoordinatorDashboardViewModel.assemble(isOffline: true);
        },
      );
    });
