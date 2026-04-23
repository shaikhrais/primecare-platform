import '02_M_dashboard_models.dart';

enum InsightType { alert, growth, risk, optimization }

class IntelligenceInsight {
  final String id;
  final String title;
  final String summary;
  final InsightImpact impact;
  final InsightType type;
  final String? recommendation;
  final String? category;
  final String? relatedMetricId;

  IntelligenceInsight({
    required this.id,
    required this.title,
    required this.summary,
    required this.impact,
    this.type = InsightType.optimization,
    this.recommendation,
    this.category,
    this.relatedMetricId,
  });

  factory IntelligenceInsight.fromJson(Map<String, dynamic> json) {
    return IntelligenceInsight(
      id: json['id'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String,
      impact: InsightImpact.values.firstWhere(
        (e) => e.name == json['impact'],
        orElse: () => InsightImpact.info,
      ),
      type: InsightType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => InsightType.optimization,
      ),
      recommendation: json['recommendation'] as String?,
      category: json['category'] as String?,
      relatedMetricId: json['relatedMetricId'] as String?,
    );
  }

  factory IntelligenceInsight.fromDashboardInsight(DashboardInsight insight) {
    return IntelligenceInsight(
      id: 'insight_${insight.title.hashCode}',
      title: insight.title,
      summary: insight.description,
      impact: insight.impact ?? InsightImpact.info,
      type: _mapType(insight.type),
      recommendation: insight.metadata?['recommendation'] as String?,
      category: insight.type,
    );
  }

  static InsightType _mapType(String type) {
    switch (type.toLowerCase()) {
      case 'alert':
      case 'critical':
        return InsightType.alert;
      case 'growth':
      case 'positive':
        return InsightType.growth;
      case 'risk':
      case 'warning':
        return InsightType.risk;
      default:
        return InsightType.optimization;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'impact': impact.name,
      'type': type.name,
      'recommendation': recommendation,
      'category': category,
      'relatedMetricId': relatedMetricId,
    };
  }
}
