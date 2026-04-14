import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final territorySalesManagerDashboardAdapterProvider =
    FutureProvider<Result<TerritorySalesManagerDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'territory_sales_manager_dashboard';

      return Result.guardFuture<TerritorySalesManagerDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<
            TerritorySalesManagerDashboardViewModel
          >(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching Territory Sales Manager Metrics: $endpoint',
              );

              final response = await apiClient.get(
                '$endpoint?route=TerritorySalesManager',
              );

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'Territory Sales Manager Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel =
                    TerritorySalesManagerDashboardViewModel.fromDashboardMetrics(
                      metrics,
                    );

                // Background hydration of LKG cache
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'Territory Sales Manager API Error: ${response.statusCode}',
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
                'Territory Sales Manager Logistics Fallback Triggered',
              );
              return TerritorySalesManagerDashboardViewModel.assemble(
                isOffline: true,
              );
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in Territory Sales Manager Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring Territory Sales Manager Dashboard from LKG snapshot',
            );
            return TerritorySalesManagerDashboardViewModel.fromJson(snapshot);
          }
          throw e;
        },
      );
    });
