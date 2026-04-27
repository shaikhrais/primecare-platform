import 'dashboard_models.dart';

enum InsightType {
  alert,
  growth,
  risk,
  optimization,
  compliance,
  efficiency,
  info,
  standard,
  financial,
  analysis,
}

class IntelligenceInsight {
  final String id;
  final PrimeCareLabel title;
  final PrimeCareLabel summary;
  final InsightImpact impact;
  final InsightType type;
  final PrimeCareLabel? recommendation;
  final String? category;
  final String? relatedMetricId;

  IntelligenceInsight({
    required this.id,
    required dynamic title,
    required dynamic summary,
    required this.impact,
    this.type = InsightType.optimization,
    dynamic recommendation,
    this.category,
    this.relatedMetricId,
  }) : title = title is PrimeCareLabel
           ? title
           : PrimeCareLabel(title as String),
       summary = summary is PrimeCareLabel
           ? summary
           : PrimeCareLabel(summary as String),
       recommendation = recommendation == null
           ? null
           : (recommendation is PrimeCareLabel
                 ? recommendation
                 : PrimeCareLabel(recommendation as String));

  factory IntelligenceInsight.fromJson(Map<String, dynamic> json) {
    return IntelligenceInsight(
      id: json['id'] as String,
      title: json['title'] is Map
          ? PrimeCareLabel.fromJson(json['title'] as Map<String, dynamic>)
          : PrimeCareLabel(json['title'] as String? ?? ''),
      summary: json['summary'] is Map
          ? PrimeCareLabel.fromJson(json['summary'] as Map<String, dynamic>)
          : PrimeCareLabel(json['summary'] as String? ?? ''),
      impact: InsightImpact.values.firstWhere(
        (e) => e.name == json['impact'],
        orElse: () => InsightImpact.info,
      ),
      type: InsightType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => InsightType.optimization,
      ),
      recommendation: json['recommendation'] == null
          ? null
          : (json['recommendation'] is Map
                ? PrimeCareLabel.fromJson(
                    json['recommendation'] as Map<String, dynamic>,
                  )
                : PrimeCareLabel(json['recommendation'] as String)),
      category: json['category'] as String?,
      relatedMetricId: json['relatedMetricId'] as String?,
    );
  }

  factory IntelligenceInsight.fromDashboardInsight(DashboardInsight insight) {
    return IntelligenceInsight(
      id: 'insight_${insight.title.hashCode}',
      title: PrimeCareLabel(insight.title),
      summary: PrimeCareLabel(insight.description),
      impact: insight.impact ?? InsightImpact.info,
      type: _mapType(insight.type),
      recommendation: insight.metadata?['recommendation'] != null
          ? PrimeCareLabel(insight.metadata!['recommendation'] as String)
          : null,
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
      'title': title.toJson(),
      'summary': summary.toJson(),
      'impact': impact.name,
      'type': type.name,
      'recommendation': recommendation?.toJson(),
      'category': category,
      'relatedMetricId': relatedMetricId,
    };
  }
}
