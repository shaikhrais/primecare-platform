// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final billingAdminDashboardAdapterProvider =
    FutureProvider<Result<BillingAdminDashboardViewModel>>((ref) async {
      const route = 'BillingAdmin';
      const cacheKey = 'billing_admin_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);
      final metricsResult = await ref.watch(dashboardMetricsProvider(route).future);

      return metricsResult.fold(
        (metrics) {
                    final viewModel = BillingAdminDashboardViewModel.fromDashboardMetrics(
            metrics,
          );

          // Persist LKG snapshot for offline survival
          unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

      telemetry.passGate(
        ExecutionGateCategory.resilience,
        'Dashboard route hydrated',
      );
          return Success(viewModel);
        },
        (error) {
      telemetry.passGate(
        ExecutionGateCategory.resilience,
        'BillingAdmin Metrics Logistics Fallback Triggered',
      );
          // Fallback: Restore from local resilience cache if infrastructure is unreachable
          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
        final vm = BillingAdminDashboardViewModel.fromJson(snapshot as Map<String, dynamic>);
        return Success(BillingAdminDashboardViewModel(
          metrics: vm.metrics,
          insights: vm.insights,
          blueprints: vm.blueprints,
          isOfflineFallback: true,
        ));
      }
          return Success(
            BillingAdminDashboardViewModel.empty(isOfflineFallback: true),
          );
        },
      );
    });

