import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final regionalManagerOntarioDashboardAdapterProvider =
    FutureProvider<Result<RegionalManagerOntarioDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'regional_manager_ontario_dashboard';

      return Result.guardFuture<RegionalManagerOntarioDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<
            RegionalManagerOntarioDashboardViewModel
          >(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching Regional Manager Ontario Metrics: $endpoint',
              );

              final response = await apiClient.get(
                '$endpoint?route=RegionalManagerOntario',
              );

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'Regional Manager Ontario Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel =
                    RegionalManagerOntarioDashboardViewModel.fromDashboardMetrics(
                      metrics,
                    );

                // Background hydration of LKG cache with real serialized data
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'Regional Manager Ontario API Error: ${response.statusCode}',
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
                'Regional Manager Ontario Logistics Fallback Triggered',
              );
              return RegionalManagerOntarioDashboardViewModel.assemble(
                isOffline: true,
              );
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in Regional Manager Ontario Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring Regional Manager Ontario Dashboard from LKG snapshot',
            );
            return RegionalManagerOntarioDashboardViewModel.fromJson(snapshot);
          }
          throw e;
        },
      );
    });
