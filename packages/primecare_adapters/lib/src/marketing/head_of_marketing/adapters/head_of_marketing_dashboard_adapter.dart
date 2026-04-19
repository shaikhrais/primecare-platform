import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final headOfMarketingDashboardAdapterProvider =
    FutureProvider<Result<HeadOfMarketingDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'head_of_marketing_dashboard';

      return Result.guardFuture<HeadOfMarketingDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<
            HeadOfMarketingDashboardViewModel
          >(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching Head of Marketing Metrics: $endpoint',
              );

              final response = await apiClient.get(
                '$endpoint?route=HeadOfMarketing',
              );

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'Head of Marketing Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel =
                    HeadOfMarketingDashboardViewModel.fromDashboardMetrics(
                      metrics,
                    );

                // Background hydration of LKG cache
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'Head of Marketing API Error: ${response.statusCode}',
                  metadata: {'status': response.statusCode},
                );
                return HeadOfMarketingDashboardViewModel.assemble(isOffline: true);
              }
            },
            fallbackBuilder: () {
              telemetry.failGate(
                ExecutionGateCategory.metricsLayer,
                'Head of Marketing Logistics Fallback Triggered',
              );
              return HeadOfMarketingDashboardViewModel.assemble(isOffline: true);
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in Head of Marketing Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring Head of Marketing Dashboard from LKG snapshot',
            );
            return HeadOfMarketingDashboardViewModel.fromJson(snapshot);
          }
          return HeadOfMarketingDashboardViewModel.assemble(isOffline: true);
        },
      );
    });
