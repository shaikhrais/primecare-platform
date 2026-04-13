import 'config/api_config.dart';
import 'network/api_client.dart';
export 'src/factory_floor/ui_blueprint.dart';

class KpiMetric {
  final String title;
  String get label => title;
  final String value;
  final String? subtitle;
  final String? trend;
  final String status;

  KpiMetric({
    required this.title,
    required this.value,
    this.subtitle,
    this.trend,
    required this.status,
  });

  factory KpiMetric.fromJson(Map<String, dynamic> json) {
    return KpiMetric(
      title: json['title'] as String,
      value: json['value'] as String,
      subtitle: json['subtitle'] as String?,
      trend: json['trend'] as String?,
      status: json['status'] as String,
    );
  }
}

class DashboardActivity {
  final String title;
  final String subtitle;
  final String timestamp;
  final String icon;
  final String color;

  DashboardActivity({
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.icon,
    required this.color,
  });

  factory DashboardActivity.fromJson(Map<String, dynamic> json) {
    return DashboardActivity(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      timestamp: json['timestamp'] as String,
      icon: json['icon'] as String,
      color: json['color'] as String,
    );
  }
}

enum ChartType { bar, line, pie }

class ChartDataPoint {
  final String label;
  final double value;
  final String? color;

  ChartDataPoint({required this.label, required this.value, this.color});

  factory ChartDataPoint.fromJson(Map<String, dynamic> json) {
    return ChartDataPoint(
      label: json['label'] as String,
      value: (json['value'] as num).toDouble(),
      color: json['color'] as String?,
    );
  }
}

class AnalyticsChart {
  final String id;
  final String title;
  final ChartType type;
  final List<ChartDataPoint> dataPoints;
  final List<ChartDataPoint>? forecastDataPoints;
  final String? reportId;

  AnalyticsChart({
    required this.id,
    required this.title,
    required this.type,
    required this.dataPoints,
    this.forecastDataPoints,
    this.reportId,
  });

  factory AnalyticsChart.fromJson(Map<String, dynamic> json) {
    return AnalyticsChart(
      id: json['id'] as String,
      title: json['title'] as String,
      type: ChartType.values.firstWhere(
        (e) => e.name == (json['type'] as String).toLowerCase(),
        orElse: () => ChartType.bar,
      ),
      dataPoints: (json['dataPoints'] as List)
          .map((i) => ChartDataPoint.fromJson(i as Map<String, dynamic>))
          .toList(),
      forecastDataPoints: json['forecastDataPoints'] != null
          ? (json['forecastDataPoints'] as List)
                .map((i) => ChartDataPoint.fromJson(i as Map<String, dynamic>))
                .toList()
          : null,
      reportId: json['reportId'] as String?,
    );
  }
}

class DashboardMetrics {
  final List<KpiMetric> kpis;
  final List<DashboardActivity> recentActivity;
  final List<AnalyticsChart> charts;

  DashboardMetrics({
    required this.kpis,
    required this.recentActivity,
    this.charts = const [],
  });

  factory DashboardMetrics.fromJson(Map<String, dynamic> json) {
    return DashboardMetrics(
      kpis: (json['kpis'] as List)
          .map((i) => KpiMetric.fromJson(i as Map<String, dynamic>))
          .toList(),
      recentActivity: (json['recentActivity'] as List)
          .map((i) => DashboardActivity.fromJson(i as Map<String, dynamic>))
          .toList(),
      charts: json['charts'] != null
          ? (json['charts'] as List)
                .map((i) => AnalyticsChart.fromJson(i as Map<String, dynamic>))
                .toList()
          : [],
    );
  }
}

class DashboardService {
  final ApiClient _apiClient;

  DashboardService(this._apiClient);

  Future<DashboardMetrics> getMetrics(String route) async {
    try {
      final endpoint = ApiConfig.endpoints['providerMetrics']!;
      // Attach the route parameter to hit real, dynamic endpoint targets
      final response = await _apiClient.get('$endpoint?route=$route');
      if (response.statusCode == 200) {
        return DashboardMetrics.fromJson(response.data as Map<String, dynamic>);
      }
      throw Exception('Failed to load metrics: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to fetch dashboard metrics for route $route: $e');
    }
  }
}
