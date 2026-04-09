import 'config/api_config.dart';
import 'network/api_client.dart';

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

class DashboardMetrics {
  final List<KpiMetric> kpis;
  final List<DashboardActivity> recentActivity;

  DashboardMetrics({required this.kpis, required this.recentActivity});

  factory DashboardMetrics.fromJson(Map<String, dynamic> json) {
    return DashboardMetrics(
      kpis: (json['kpis'] as List)
          .map((i) => KpiMetric.fromJson(i as Map<String, dynamic>))
          .toList(),
      recentActivity: (json['recentActivity'] as List)
          .map((i) => DashboardActivity.fromJson(i as Map<String, dynamic>))
          .toList(),
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
