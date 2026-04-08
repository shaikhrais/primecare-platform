import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/dashboard_service.dart';
import 'api_providers.dart';

final dashboardServiceProvider = Provider<DashboardService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DashboardService(apiClient);
});

final dashboardMetricsProvider = FutureProvider<DashboardMetrics>((ref) async {
  final service = ref.watch(dashboardServiceProvider);
  return await service.getMetrics();
});
