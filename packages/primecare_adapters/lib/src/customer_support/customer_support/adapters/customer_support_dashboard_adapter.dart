import 'dart:async';
import 'package:primecare_core/primecare_core.dart';

final customerSupportDashboardAdapterProvider =
    FutureProvider<Result<CustomerSupportDashboardViewModel>>((ref) async {
  const route = 'CustomerSupport';
  const cacheKey = 'customer_support_dashboard';
  final resilience = ref.read(resilienceServiceProvider);

  // Watch the hardened infrastructure provider for standardized metrics fetching
  final result = await ref.watch(dashboardMetricsProvider(route).future);

  return result.fold(
    (metrics) {
      final viewModel =
          CustomerSupportDashboardViewModel.fromDashboardMetrics(metrics);
      // Persist LKG snapshot for offline survival
      unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
      return Success(viewModel);
    },
    (error) {
      // Fallback: Restore from local resilience cache if infrastructure is unreachable
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        return Success(CustomerSupportDashboardViewModel.fromJson(snapshot));
      }
      return Success(
        CustomerSupportDashboardViewModel.assemble(isOffline: true),
      );
    },
  );
});
