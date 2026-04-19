import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final localMarketingManagerDashboardAdapterProvider =
    FutureProvider<Result<LocalMarketingManagerDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'local_marketing_manager_dashboard';

      return Result.guardFuture<LocalMarketingManagerDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<
            LocalMarketingManagerDashboardViewModel
          >(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching Local Marketing Manager Metrics: $endpoint',
              );

              final response = await apiClient.get(
                '$endpoint?route=LocalMarketingManager',
              );

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'Local Marketing Manager Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel =
                    LocalMarketingManagerDashboardViewModel.fromDashboardMetrics(
                      metrics,
                    );

                // Background hydration of LKG cache
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'Local Marketing Manager API Error: ${response.statusCode}',
                  metadata: {'status': response.statusCode},
                );
                return LocalMarketingManagerDashboardViewModel.assemble(
                  isOffline: true,
                );
              }
            },
            fallbackBuilder: () {
              telemetry.failGate(
                ExecutionGateCategory.metricsLayer,
                'Local Marketing Manager Logistics Fallback Triggered',
              );
              return LocalMarketingManagerDashboardViewModel.assemble(
                isOffline: true,
              );
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in Local Marketing Manager Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring Local Marketing Manager Dashboard from LKG snapshot',
            );
            return LocalMarketingManagerDashboardViewModel.fromJson(snapshot);
          }
          return LocalMarketingManagerDashboardViewModel.assemble(isOffline: true);
        },
      );
    });
