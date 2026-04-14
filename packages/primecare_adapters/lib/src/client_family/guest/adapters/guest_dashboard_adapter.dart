import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final guestDashboardAdapterProvider =
    FutureProvider<Result<GuestDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'guest_dashboard';

      return Result.guardFuture<GuestDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<GuestDashboardViewModel>(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';

              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Fetching Guest Metrics: $endpoint',
              );

              final response = await apiClient.get('$endpoint?route=Guest');

              if (response.statusCode == 200) {
                telemetry.passGate(
                  ExecutionGateCategory.metricsLayer,
                  'Guest Metrics Hydrated',
                );
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel = GuestDashboardViewModel.fromDashboardMetrics(
                  metrics,
                );

                // Background hydration of LKG cache
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                telemetry.failGate(
                  ExecutionGateCategory.metricsLayer,
                  'Guest API Error: ${response.statusCode}',
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
                'Guest Logistics Fallback Triggered',
              );
              return GuestDashboardViewModel.assemble(isOffline: true);
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in Guest Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring Guest Dashboard from LKG snapshot',
            );
            return GuestDashboardViewModel.fromJson(snapshot);
          }
          throw e;
        },
      );
    });
