import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final scrumMasterDashboardAdapterProvider =
    FutureProvider<Result<ScrumMasterDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'scrum_master_dashboard';

      return Result.guardFuture<ScrumMasterDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<
            ScrumMasterDashboardViewModel
          >(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching Scrum Master Metrics: $endpoint',
              );

              final response = await apiClient.get(
                '$endpoint?route=ScrumMaster',
              );

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'Scrum Master Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel =
                    ScrumMasterDashboardViewModel.fromDashboardMetrics(metrics);

                // Background hydration of LKG cache with real serialized data
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'Scrum Master Metrics API Error: ${response.statusCode}',
                  metadata: {'status': response.statusCode},
                );
                return ScrumMasterDashboardViewModel.assemble(isOffline: true);
              }
            },
            fallbackBuilder: () {
              telemetry.failGate(
                ExecutionGateCategory.metricsLayer,
                'Scrum Master Metrics Logistics Fallback Triggered',
              );
              return ScrumMasterDashboardViewModel.assemble(isOffline: true);
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in Scrum Master Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring Scrum Master Dashboard from LKG snapshot',
            );
            return ScrumMasterDashboardViewModel.fromJson(snapshot);
          }
          return ScrumMasterDashboardViewModel.assemble(isOffline: true);
        },
      );
    });
