import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dashboard_service.dart';
import 'api_providers.dart';
import 'src/factory_floor/data_logistics_hub.dart';

final dashboardServiceProvider = Provider<DashboardService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DashboardService(apiClient);
});

// Using a family provider to support fetching distinct metrics per route/role with resilient hydration
final dashboardMetricsProvider =
    FutureProvider.family<DashboardMetrics, String>((ref, route) async {
      final service = ref.watch(dashboardServiceProvider);

      return DataLogisticsHub.fetchAndAssemble<DashboardMetrics>(
        fetchCall: () => service.getMetrics(route),
        fallbackBuilder: () => DataLogisticsHub.getDashboardMetrics(route),
        onError: (e, st) {
          // Internal logging point for metrics failures
        },
      );
    });
