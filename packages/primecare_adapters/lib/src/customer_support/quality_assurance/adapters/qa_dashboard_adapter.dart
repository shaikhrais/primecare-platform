import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final qaDashboardAdapterProvider =
    FutureProvider<Result<QualityAssuranceDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'qa_dashboard';

      return Result.guardFuture<QualityAssuranceDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<
            QualityAssuranceDashboardViewModel
          >(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching QA Metrics: $endpoint',
              );

              final response = await apiClient.get('$endpoint?route=QA');

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'QA Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel =
                    QualityAssuranceDashboardViewModel.fromDashboardMetrics(metrics);

                // Background hydration of LKG cache with real serialized data
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'QA API Error: ${response.statusCode}',
                  metadata: {'status': response.statusCode},
                );
                return QualityAssuranceDashboardViewModel.assemble(isOffline: true);
              }
            },
            fallbackBuilder: () {
              telemetry.failGate(
                ExecutionGateCategory.metricsLayer,
                'QA Logistics Fallback Triggered',
              );
              return QualityAssuranceDashboardViewModel.assemble(isOffline: true);
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in QA Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring QA Dashboard from LKG snapshot',
            );
            return QualityAssuranceDashboardViewModel.fromJson(snapshot);
          }
          return QualityAssuranceDashboardViewModel.assemble(isOffline: true);
        },
      );
    });
