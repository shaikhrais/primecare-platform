import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final communityOutreachDashboardAdapterProvider =
    FutureProvider<Result<CommunityOutreachDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'community_outreach_dashboard';

      return Result.guardFuture<CommunityOutreachDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<
            CommunityOutreachDashboardViewModel
          >(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching Community Outreach Metrics: $endpoint',
              );

              final response = await apiClient.get(
                '$endpoint?route=CommunityOutreach',
              );

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'Community Outreach Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel =
                    CommunityOutreachDashboardViewModel.fromDashboardMetrics(
                      metrics,
                    );

                // Background hydration of LKG cache
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'Community Outreach API Error: ${response.statusCode}',
                  metadata: {'status': response.statusCode},
                );
                return CommunityOutreachDashboardViewModel.assemble(isOffline: true);
              }
            },
            fallbackBuilder: () {
              telemetry.failGate(
                ExecutionGateCategory.metricsLayer,
                'Community Outreach Logistics Fallback Triggered',
              );
              return CommunityOutreachDashboardViewModel.assemble(isOffline: true);
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in Community Outreach Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring Community Outreach Dashboard from LKG snapshot',
            );
            return CommunityOutreachDashboardViewModel.fromJson(snapshot);
          }
          return CommunityOutreachDashboardViewModel.assemble(isOffline: true);
        },
      );
    });
