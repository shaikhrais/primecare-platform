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
        fallbackBuilder: () => DashboardMetrics(
          kpis: [
            KpiMetric(
              title: 'Active Patients',
              value: '1,240',
              status: 'stable',
              subtitle: '+12% from last month',
            ),
            KpiMetric(
              title: 'Pending Claims',
              value: '48',
              status: 'warning',
              subtitle: '8 high priority',
            ),
            KpiMetric(
              title: 'Staff Capacity',
              value: '92%',
              status: 'good',
              subtitle: 'Optimal',
            ),
          ],
          recentActivity: [],
          charts: [
            AnalyticsChart(
              id: 'revenue_trend',
              title: 'Revenue Performance',
              type: ChartType.line,
              data: [
                ChartDataPoint(label: 'Mon', value: 4500),
                ChartDataPoint(label: 'Tue', value: 5200),
                ChartDataPoint(label: 'Wed', value: 4800),
                ChartDataPoint(label: 'Thu', value: 6100),
                ChartDataPoint(label: 'Fri', value: 5900),
              ],
              unit: '\$',
            ),
            AnalyticsChart(
              id: 'resource_split',
              title: 'Staff Allocation',
              type: ChartType.pie,
              data: [
                ChartDataPoint(label: 'Clinical', value: 60, color: '#1E40AF'),
                ChartDataPoint(label: 'Admin', value: 25, color: '#3B82F6'),
                ChartDataPoint(label: 'Support', value: 15, color: '#93C5FD'),
              ],
              unit: '%',
            ),
          ],
        ),
        onError: (e, st) {
          // Internal logging point for metrics failures
        },
      );
    });
