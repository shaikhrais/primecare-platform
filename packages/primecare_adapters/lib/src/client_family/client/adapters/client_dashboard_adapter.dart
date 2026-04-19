import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final clientDashboardAdapterProvider =
    FutureProvider<Result<ClientDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'client_dashboard';

      return Result.guardFuture<ClientDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<ClientDashboardViewModel>(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching Client Metrics: $endpoint',
              );

              final response = await apiClient.get('$endpoint?route=Client');

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'Client Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel = ClientDashboardViewModel.fromDashboardMetrics(
                  metrics,
                );

                // Background hydration of LKG cache
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'Client API Error: ${response.statusCode}',
                  metadata: {'status': response.statusCode},
                );
                return ClientDashboardViewModel.assemble(isOffline: true);
              }
            },
            fallbackBuilder: () {
              telemetry.failGate(
                ExecutionGateCategory.metricsLayer,
                'Client Logistics Fallback Triggered',
              );
              return ClientDashboardViewModel.assemble(isOffline: true);
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in Client Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring Client Dashboard from LKG snapshot',
            );
            return ClientDashboardViewModel.fromJson(snapshot);
          }
          return ClientDashboardViewModel.assemble(isOffline: true);
        },
      );
    });
