import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final franchiseOwnerAdapterProvider =
    FutureProvider<Result<FranchiseOwnerViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final resilience = ref.read(resilienceServiceProvider);
      const cacheKey = 'franchise_owner_dashboard';

      return Result.guardFuture<FranchiseOwnerViewModel>(
        () async {
          return DataLogisticsHub.fetchAndAssemble<FranchiseOwnerViewModel>(
            fetchCall: () async {
              final apiClient = ref.read(apiClientProvider);
              const endpoint = '/api/v1/metrics';
              final response = await apiClient.get(
                '$endpoint?route=FranchiseOwner',
              );

              if (response.statusCode == 200) {
                final metrics = DashboardMetrics.fromJson(
                  response.data as Map<String, dynamic>,
                );
                final viewModel = FranchiseOwnerViewModel.fromDashboardMetrics(
                  metrics,
                );

                // Background hydration of LKG cache with real serialized data
                unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

                return viewModel;
              } else {
                return FranchiseOwnerDashboardViewModel.assemble(isOffline: true);
              }
            },
            fallbackBuilder: () {
              // Level 1 Resilience: DataLogisticsHub local fallback
              return FranchiseOwnerViewModel.assemble(isOffline: true);
            },
          );
        },
        onError: (e, st) {
          telemetry.failGate(
            ExecutionGateCategory.resource,
            'Major failure in Franchise Owner Adapter',
            error: e,
            stackTrace: st,
          );

          // Level 2 Resilience: Last Known Good Restore
          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            telemetry.passGate(
              ExecutionGateCategory.resource,
              'Resilience: Restoring Franchise Owner Dashboard from LKG snapshot',
            );
            return FranchiseOwnerViewModel.fromJson(snapshot);
          }

          return FranchiseOwnerViewModel.assemble(isOffline: true);
        },
      );
    });
