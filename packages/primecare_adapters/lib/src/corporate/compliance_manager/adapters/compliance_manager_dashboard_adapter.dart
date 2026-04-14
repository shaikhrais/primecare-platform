import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final complianceManagerDashboardAdapterProvider =
    FutureProvider<Result<ComplianceManagerDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'compliance_manager_dashboard';

      return Result.guardFuture<ComplianceManagerDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<
            ComplianceManagerDashboardViewModel
          >(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching Compliance Metrics: $endpoint',
              );

              final response = await apiClient.get(
                '$endpoint?route=ComplianceManager',
              );

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'Compliance Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel =
                    ComplianceManagerDashboardViewModel.fromDashboardMetrics(
                      metrics,
                    );

                // Background hydration of LKG cache with real serialized data
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'Compliance Metrics API Error: ${response.statusCode}',
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
                'Compliance Metrics Logistics Fallback Triggered',
              );
              return ComplianceManagerDashboardViewModel.assemble(
                isOffline: true,
              );
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.metricsLayer,
            'Deterministic Adapter Failure: Compliance Manager Dashboard',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring Compliance Manager Dashboard from LKG snapshot',
            );
            return ComplianceManagerDashboardViewModel.fromJson(snapshot);
          }
          throw e;
        },
      );
    });
