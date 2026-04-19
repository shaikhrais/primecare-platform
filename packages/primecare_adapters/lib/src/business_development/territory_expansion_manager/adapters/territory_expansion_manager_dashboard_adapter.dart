import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final territoryExpansionManagerDashboardAdapterProvider =
    FutureProvider<Result<TerritoryExpansionManagerDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'territory_expansion_manager_dashboard';

      return Result.guardFuture<TerritoryExpansionManagerDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<
            TerritoryExpansionManagerDashboardViewModel
          >(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching Territory Expansion Manager Metrics: $endpoint',
              );

              final response = await apiClient.get(
                '$endpoint?route=TerritoryExpansionManager',
              );

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'Territory Expansion Manager Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel =
                    TerritoryExpansionManagerDashboardViewModel.fromDashboardMetrics(
                      metrics,
                    );

                // Background hydration of LKG cache with real serialized data
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'Territory Expansion Manager API Error: ${response.statusCode}',
                  metadata: {'status': response.statusCode},
                );
                return TerritoryExpansionManagerDashboardViewModel.assemble(
                  isOffline: true,
                );
              }
            },
            fallbackBuilder: () {
              telemetry.failGate(
                ExecutionGateCategory.metricsLayer,
                'Territory Expansion Manager Logistics Fallback Triggered',
              );
              return TerritoryExpansionManagerDashboardViewModel.assemble(
                isOffline: true,
              );
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in Territory Expansion Manager Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring Territory Expansion Manager Dashboard from LKG snapshot',
            );
            return TerritoryExpansionManagerDashboardViewModel.fromJson(snapshot);
          }
          return TerritoryExpansionManagerDashboardViewModel.assemble(isOffline: true);
        },
      );
    });
