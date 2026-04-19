import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final ctoDashboardAdapterProvider =
    FutureProvider<Result<CtoDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'cto_dashboard';

      return Result.guardFuture<CtoDashboardViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<CtoDashboardViewModel>(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';
              final response = await apiClient.get('$endpoint?route=Cto');

              if (response.statusCode == 200) {
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel = CtoDashboardViewModel.fromDashboardMetrics(
                  metrics,
                );

                // Background hydration of LKG cache with real serialized data
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                return CtoDashboardViewModel.assemble(isOffline: true);
              }
            },
            fallbackBuilder: () {
              return CtoDashboardViewModel.assemble(isOffline: true);
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in CTO Dashboard Adapter',
            error: e,
            stackTrace: st,
          );

          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring CTO Dashboard from LKG snapshot',
            );
            return CtoDashboardViewModel.fromJson(snapshot);
          }
          return CtoDashboardViewModel.assemble(isOffline: true);
        },
      );
    });
