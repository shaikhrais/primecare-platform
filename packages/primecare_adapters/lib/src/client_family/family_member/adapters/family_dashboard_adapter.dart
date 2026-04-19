import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final familyDashboardAdapterProvider =
    FutureProvider<Result<FamilyDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'family_dashboard';

      return Result.guardFuture<FamilyDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<FamilyDashboardViewModel>(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching Family Metrics: $endpoint',
              );

              final response = await apiClient.get('$endpoint?route=Family');

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'Family Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel = FamilyDashboardViewModel.fromDashboardMetrics(
                  metrics,
                );

                // Background hydration of LKG cache
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'Family API Error: ${response.statusCode}',
                  metadata: {'status': response.statusCode},
                );
                return FamilyDashboardViewModel.assemble(isOffline: true);
              }
            },
            fallbackBuilder: () {
              telemetry.failGate(
                ExecutionGateCategory.metricsLayer,
                'Family Logistics Fallback Triggered',
              );
              return FamilyDashboardViewModel.assemble(isOffline: true);
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in Family Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring Family Dashboard from LKG snapshot',
            );
            return FamilyDashboardViewModel.fromJson(snapshot);
          }
          return FamilyDashboardViewModel.assemble(isOffline: true);
        },
      );
    });
