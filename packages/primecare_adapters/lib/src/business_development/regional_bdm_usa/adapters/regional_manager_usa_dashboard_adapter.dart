import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final regionalManagerUSADashboardAdapterProvider =
    FutureProvider<Result<RegionalManagerUsaDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'regional_manager_usa_dashboard';

      return Result.guardFuture<RegionalManagerUsaDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<
            RegionalManagerUsaDashboardViewModel
          >(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching Regional Manager USA Metrics: $endpoint',
              );

              final response = await apiClient.get(
                '$endpoint?route=RegionalManagerUSA',
              );

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'Regional Manager USA Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel =
                    RegionalManagerUsaDashboardViewModel.fromDashboardMetrics(
                      metrics,
                    );

                // Background hydration of LKG cache with real serialized data
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'Regional Manager USA API Error: ${response.statusCode}',
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
                'Regional Manager USA Logistics Fallback Triggered',
              );
              return RegionalManagerUsaDashboardViewModel.assemble(
                isOffline: true,
              );
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in Regional Manager USA Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring Regional Manager USA Dashboard from LKG snapshot',
            );
            return RegionalManagerUsaDashboardViewModel.fromJson(snapshot);
          }
          throw e;
        },
      );
    });
