import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final ownerDashboardAdapterProvider =
    FutureProvider<Result<OwnerDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'owner_dashboard';

      return Result.guardFuture<OwnerDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<OwnerDashboardViewModel>(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';
              final response = await apiClient.get('$endpoint?route=Owner');

              if (response.statusCode == 200) {
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel = OwnerDashboardViewModel.fromDashboardMetrics(
                  metrics,
                );

                // Background hydration of LKG cache with real serialized data
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                return OwnerDashboardViewModel.assemble(isOffline: true);
              }
            },
            fallbackBuilder: () {
              return OwnerDashboardViewModel.assemble(isOffline: true);
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in Owner Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring Owner Dashboard from LKG snapshot',
            );
            return OwnerDashboardViewModel.fromJson(snapshot);
          }
          return OwnerDashboardViewModel.assemble(isOffline: true);
        },
      );
    });
