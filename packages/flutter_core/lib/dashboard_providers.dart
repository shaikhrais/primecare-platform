import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dashboard_service.dart';
import 'api_providers.dart';

final dashboardServiceProvider = Provider<DashboardService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DashboardService(apiClient);
});

// Using a family provider to support fetching distinct metrics per route/role
final dashboardMetricsProvider = FutureProvider.family<DashboardMetrics, String>((ref, route) async {
  final service = ref.watch(dashboardServiceProvider);
  return await service.getMetrics(route);
});
