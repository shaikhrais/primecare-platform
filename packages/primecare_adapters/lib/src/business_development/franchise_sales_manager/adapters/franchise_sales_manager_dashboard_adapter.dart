import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final franchiseSalesManagerDashboardAdapterProvider =
    FutureProvider<Result<FranchiseSalesManagerDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'franchise_sales_manager_dashboard';

      return Result.guardFuture<FranchiseSalesManagerDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<
            FranchiseSalesManagerDashboardViewModel
          >(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching Franchise Sales Manager Metrics: $endpoint',
              );

              final response = await apiClient.get(
                '$endpoint?route=FranchiseSalesManager',
              );

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'Franchise Sales Manager Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel =
                    FranchiseSalesManagerDashboardViewModel.fromDashboardMetrics(
                      metrics,
                    );

                // Background hydration of LKG cache with real serialized data
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'Franchise Sales Manager API Error: ${response.statusCode}',
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
                'Franchise Sales Manager Logistics Fallback Triggered',
              );
              return FranchiseSalesManagerDashboardViewModel.assemble(
                isOffline: true,
              );
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in Franchise Sales Manager Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring Franchise Sales Manager Dashboard from LKG snapshot',
            );
            return FranchiseSalesManagerDashboardViewModel.fromJson(snapshot);
          }
          throw e;
        },
      );
    });
