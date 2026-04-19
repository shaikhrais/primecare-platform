import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final billingAdminDashboardAdapterProvider =
    FutureProvider<Result<BillingAdminDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'billing_admin_dashboard';

      return Result.guardFuture<BillingAdminDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<BillingAdminDashboardViewModel>(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching Billing Admin Metrics: $endpoint',
              );

              final response = await apiClient.get('$endpoint?route=BillingAdmin');

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'Billing Admin Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel =
                    BillingAdminDashboardViewModel.fromDashboardMetrics(metrics);

                // Background hydration of LKG cache with real serialized data
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'Billing Admin API Error: ${response.statusCode}',
                  metadata: {'status': response.statusCode},
                );
                return BillingAdminDashboardViewModel.assemble(isOffline: true);
              }
            },
            fallbackBuilder: () {
              telemetry.failGate(
                ExecutionGateCategory.metricsLayer,
                'Billing Admin Logistics Fallback Triggered',
              );
              return BillingAdminDashboardViewModel.assemble(isOffline: true);
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in Billing Admin Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring Billing Admin Dashboard from LKG snapshot',
            );
            return BillingAdminDashboardViewModel.fromJson(snapshot);
          }
          return BillingAdminDashboardViewModel.assemble(isOffline: true);
        },
      );
    });
