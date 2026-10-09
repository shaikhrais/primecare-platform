import 'base_entity.dart';
// Governance - Category: view | Purpose: Layer: 00_MODELS
// Layer: 00_MODELS
import 'package:flutter_core/flutter_core.dart';

enum ChartType { line, bar, pie }

class DataPoint {
  final String label;
  final double value;

  const DataPoint({required this.label, required this.value});

  factory DataPoint.fromJson(Map<String, dynamic> json) {
    return DataPoint(
      label: (json['label'] as String?) ?? '',
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {'label': label, 'value': value};
}

class AnalyticsChart extends BaseEntity<String> {
  final String title;
  final ChartType type;
  final List<DataPoint> dataPoints;

  const AnalyticsChart({
    required super.id,
    required this.title,
    required this.type,
    required this.dataPoints,
  });

  factory AnalyticsChart.fromJson(Map<String, dynamic> json) {
    return AnalyticsChart(
      id: (json['id'] as String?) ?? '',
      title: (json['title'] as String?) ?? '',
      type: ChartType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ChartType.line,
      ),
      dataPoints: (json['dataPoints'] as List? ?? [])
          .map((p) => DataPoint.fromJson(p as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'type': type.name,
    'dataPoints': dataPoints.map((p) => p.toJson()).toList(),
  };
}

class ActivityItem extends BaseEntity<String> {
  final String title;
  final String subtitle;
  final DateTime timestamp;
  final String? type;

  const ActivityItem({
    required super.id,
    required this.title,
    required this.subtitle,
    required this.timestamp,
    this.type,
  });

  factory ActivityItem.fromJson(Map<String, dynamic> json) {
    return ActivityItem(
      id: (json['id'] as String?) ?? '',
      title: (json['title'] as String?) ?? '',
      subtitle: (json['subtitle'] as String?) ?? '',
      timestamp:
          DateTime.tryParse((json['timestamp'] as String?) ?? '') ??
          DateTime.now(),
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'subtitle': subtitle,
    'timestamp': timestamp.toIso8601String(),
    'type': type,
  };
}

class IntelligenceInsight extends BaseEntity<String> {
  final String title;
  final String summary;
  final InsightImpact impact;
  final String? relatedMetricId;

  const IntelligenceInsight({
    required super.id,
    required this.title,
    required this.summary,
    required this.impact,
    this.relatedMetricId,
  });

  factory IntelligenceInsight.fromJson(Map<String, dynamic> json) {
    return IntelligenceInsight(
      id: (json['id'] as String?) ?? '',
      title: (json['title'] as String?) ?? '',
      summary: (json['summary'] as String?) ?? '',
      impact: InsightImpact.values.firstWhere(
        (e) => e.name == json['impact'],
        orElse: () => InsightImpact.info,
      ),
      relatedMetricId: json['relatedMetricId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'summary': summary,
    'impact': impact.name,
    'relatedMetricId': relatedMetricId,
  };
}

class DashboardMetrics {
  final Map<String, dynamic> kpis;
  final List<AnalyticsChart> charts;
  final List<ActivityItem> recentActivity;
  final List<IntelligenceInsight> insights;
  final bool isOfflineFallback;

  const DashboardMetrics({
    required this.kpis,
    required this.charts,
    required this.recentActivity,
    required this.insights,
    this.isOfflineFallback = false,
  });

  factory DashboardMetrics.fromJson(Map<String, dynamic> json) {
    return DashboardMetrics(
      kpis:
          (json['kpis'] ?? json['metrics'] ?? <String, dynamic>{})
              as Map<String, dynamic>,
      charts: (json['charts'] as List? ?? [])
          .map((c) => AnalyticsChart.fromJson(c as Map<String, dynamic>))
          .toList(),
      recentActivity: (json['recentActivity'] as List? ?? [])
          .map((a) => ActivityItem.fromJson(a as Map<String, dynamic>))
          .toList(),
      insights: (json['insights'] as List? ?? [])
          .map((i) => IntelligenceInsight.fromJson(i as Map<String, dynamic>))
          .toList(),
      isOfflineFallback: json['isOfflineFallback'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'kpis': kpis,
    'charts': charts.map((c) => c.toJson()).toList(),
    'recentActivity': recentActivity.map((a) => a.toJson()).toList(),
    'insights': insights.map((i) => i.toJson()).toList(),
    'isOfflineFallback': isOfflineFallback,
  };

  factory DashboardMetrics.empty() => const DashboardMetrics(
    kpis: {},
    charts: [],
    recentActivity: [],
    insights: [],
  );

  DashboardMetrics copyWith({
    Map<String, dynamic>? kpis,
    List<AnalyticsChart>? charts,
    List<ActivityItem>? recentActivity,
    List<IntelligenceInsight>? insights,
    bool? isOfflineFallback,
  }) {
    return DashboardMetrics(
      kpis: kpis ?? this.kpis,
      charts: charts ?? this.charts,
      recentActivity: recentActivity ?? this.recentActivity,
      insights: insights ?? this.insights,
      isOfflineFallback: isOfflineFallback ?? this.isOfflineFallback,
    );
  }
}

class ClinicalIntelligenceViewModel {
  final DashboardMetrics metrics;
  final List<IntelligenceInsight> clinicalInsights;
  final bool isOfflineFallback;
  const ClinicalIntelligenceViewModel({
    required this.metrics,
    required this.clinicalInsights,
    this.isOfflineFallback = false,
  });

  factory ClinicalIntelligenceViewModel.fromJson(Map<String, dynamic> json) {
    return ClinicalIntelligenceViewModel(
      metrics: DashboardMetrics.fromJson(
        (json['metrics'] as Map<String, dynamic>?) ?? {},
      ),
      clinicalInsights: (json['clinicalInsights'] as List? ?? [])
          .map((i) => IntelligenceInsight.fromJson(i as Map<String, dynamic>))
          .toList(),
      isOfflineFallback: json['isOfflineFallback'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'metrics': metrics.toJson(),
    'clinicalInsights': clinicalInsights.map((i) => i.toJson()).toList(),
    'isOfflineFallback': isOfflineFallback,
  };
}

class AIAnalyticsForecastingData {
  final List<AnalyticsChart> predictedTrends;
  final List<IntelligenceInsight> recommendations;

  const AIAnalyticsForecastingData({
    required this.predictedTrends,
    required this.recommendations,
  });

  factory AIAnalyticsForecastingData.fromJson(Map<String, dynamic> json) {
    return AIAnalyticsForecastingData(
      predictedTrends: (json['predictedTrends'] as List? ?? [])
          .map((c) => AnalyticsChart.fromJson(c as Map<String, dynamic>))
          .toList(),
      recommendations: (json['recommendations'] as List? ?? [])
          .map((i) => IntelligenceInsight.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'predictedTrends': predictedTrends.map((c) => c.toJson()).toList(),
    'recommendations': recommendations.map((i) => i.toJson()).toList(),
  };
}

class PrimeCareDashboardViewModel {
  final DashboardMetrics metrics;
  final List<IntelligenceInsight> insights;
  final List<ActivityItem> timeline;
  final List<AnalyticsChart> trends;
  final bool isFromCache;
  final DateTime lastUpdated;

  PrimeCareDashboardViewModel({
    required this.metrics,
    required this.insights,
    required this.timeline,
    required this.trends,
    this.isFromCache = false,
    required this.lastUpdated,
  });

  factory PrimeCareDashboardViewModel.fromJson(Map<String, dynamic> json) {
    return PrimeCareDashboardViewModel(
      metrics: DashboardMetrics.fromJson(
        (json['metrics'] as Map<String, dynamic>?) ?? {},
      ),
      insights: (json['insights'] as List? ?? [])
          .map((i) => IntelligenceInsight.fromJson(i as Map<String, dynamic>))
          .toList(),
      timeline: (json['timeline'] as List? ?? [])
          .map((i) => ActivityItem.fromJson(i as Map<String, dynamic>))
          .toList(),
      trends: (json['trends'] as List? ?? [])
          .map((i) => AnalyticsChart.fromJson(i as Map<String, dynamic>))
          .toList(),
      isFromCache: json['isOfflineFallback'] as bool? ?? false,
      lastUpdated:
          DateTime.tryParse((json['lastUpdated'] as String?) ?? '') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'metrics': metrics.toJson(),
    'insights': insights.map((i) => i.toJson()).toList(),
    'timeline': timeline.map((i) => i.toJson()).toList(),
    'trends': trends.map((i) => i.toJson()).toList(),
    'isOfflineFallback': isFromCache,
    'lastUpdated': lastUpdated.toIso8601String(),
  };

  PrimeCareDashboardViewModel copyWith({
    DashboardMetrics? metrics,
    List<IntelligenceInsight>? insights,
    List<ActivityItem>? timeline,
    List<AnalyticsChart>? trends,
    bool? isFromCache,
    DateTime? lastUpdated,
  }) {
    return PrimeCareDashboardViewModel(
      metrics: metrics ?? this.metrics,
      insights: insights ?? this.insights,
      timeline: timeline ?? this.timeline,
      trends: trends ?? this.trends,
      isFromCache: isFromCache ?? this.isFromCache,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
