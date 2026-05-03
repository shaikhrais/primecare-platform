// Layer: 02_MODELS_PRECISION
// Architecture: High-Precision Dashboard Intelligence Model

import 'dashboard_models.dart';

/// The standard data contract for all PrimeCare Dashboards.
/// Ensures 100% type safety and precision before data reaches the UI.
class IntelligenceDashboardModel {
  final List<KpiMetric> metrics;
  final List<DashboardInsight> insights;
  final List<AnalyticsChart> trends;
  final List<DashboardActivity> timeline;
  final DateTime lastUpdated;
  final bool isFromCache;

  const IntelligenceDashboardModel({
    required this.metrics,
    required this.insights,
    this.trends = const [],
    this.timeline = const [],
    required this.lastUpdated,
    this.isFromCache = false,
  });

  /// Factory for an empty, healthy state
  factory IntelligenceDashboardModel.empty() {
    return IntelligenceDashboardModel(
      metrics: [],
      insights: [],
      lastUpdated: DateTime.now(),
    );
  }

  /// Precision Mapping from JSON
  factory IntelligenceDashboardModel.fromJson(Map<String, dynamic> json) {
    return IntelligenceDashboardModel(
      metrics: (json['metrics'] as List?)
              ?.map((e) => KpiMetric.fromJson(e as Map<String, dynamic>))
              .toList() ?? [],
      insights: (json['insights'] as List?)
              ?.map((e) => DashboardInsight.fromJson(e as Map<String, dynamic>))
              .toList() ?? [],
      trends: (json['trends'] as List?)
              ?.map((e) => AnalyticsChart.fromJson(e as Map<String, dynamic>))
              .toList() ?? [],
      timeline: (json['timeline'] as List?)
              ?.map((e) => DashboardActivity.fromJson(e as Map<String, dynamic>))
              .toList() ?? [],
      lastUpdated: json['lastUpdated'] != null 
          ? DateTime.parse(json['lastUpdated'] as String)
          : DateTime.now(),
      isFromCache: json['isFromCache'] as bool? ?? false,
    );
  }

  /// Serialization for Persistent Store
  Map<String, dynamic> toJson() {
    return {
      'metrics': metrics.map((e) => e.toJson()).toList(),
      'insights': insights.map((e) => e.toJson()).toList(),
      'trends': trends.map((e) => e.toJson()).toList(),
      'timeline': timeline.map((e) => e.toJson()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
      'isFromCache': isFromCache,
    };
  }
}
