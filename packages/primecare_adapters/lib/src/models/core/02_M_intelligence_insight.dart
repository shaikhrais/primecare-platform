// Layer: 02_MODELS_FOUNDATION
enum InsightImpact { positive, caution, info, alert }

class IntelligenceInsight {
  final String id;
  final String title;
  final String summary;
  final InsightImpact impact;
  final String? relatedMetricId;

  IntelligenceInsight({
    required this.id,
    required this.title,
    required this.summary,
    required this.impact,
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
      relatedMetricId: json['relatedMetricId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'impact': impact.name,
      'relatedMetricId': relatedMetricId,
    };
  }
}
