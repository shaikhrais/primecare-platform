import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final headOfBusDevDashboardAdapterProvider =
    FutureProvider<Result<HeadOfBusDevDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'head_of_bus_dev_dashboard';

      return Result.guardFuture<HeadOfBusDevDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<
            HeadOfBusDevDashboardViewModel
          >(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching Head of Bus Dev Metrics: $endpoint',
              );

              final response = await apiClient.get(
                '$endpoint?route=HeadOfBusDev',
              );

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'Head of Bus Dev Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel =
                    HeadOfBusDevDashboardViewModel.fromDashboardMetrics(
                      metrics,
                    );

                // Background hydration of LKG cache with real serialized data
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'Head of Bus Dev Metrics API Error: ${response.statusCode}',
                  metadata: {'status': response.statusCode},
                );
                return HeadOfBusDevDashboardViewModel.assemble(isOffline: true);
              }
            },
            fallbackBuilder: () {
              telemetry.failGate(
                ExecutionGateCategory.metricsLayer,
                'Head of Bus Dev Metrics Logistics Fallback Triggered',
              );
              return HeadOfBusDevDashboardViewModel.assemble(isOffline: true);
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in Head of Bus Dev Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring Head of Bus Dev Dashboard from LKG snapshot',
            );
            return HeadOfBusDevDashboardViewModel.fromJson(snapshot);
          }
          return HeadOfBusDevDashboardViewModel.assemble(isOffline: true);
        },
      );
    });
