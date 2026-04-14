import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final clinicDashboardAdapterProvider =
    FutureProvider<Result<ClinicDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'clinic_dashboard';

      return Result.guardFuture<ClinicDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<ClinicDashboardViewModel>(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching Clinic Metrics: $endpoint',
              );

              final response = await apiClient.get('$endpoint?route=Clinic');

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'Clinic Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel = ClinicDashboardViewModel.fromDashboardMetrics(
                  metrics,
                );

                // Background hydration of LKG cache with real serialized data
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'Clinic Metrics API Error: ${response.statusCode}',
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
                'Clinic Metrics Logistics Fallback Triggered',
              );
              return ClinicDashboardViewModel.assemble(isOffline: true);
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in Clinic Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring Clinic Dashboard from LKG snapshot',
            );
            return ClinicDashboardViewModel.fromJson(snapshot);
          }
          throw e;
        },
      );
    });
