// Layer: 00_MODELS

class UIComponentBlueprint {
  final String id;
  final String type;
  final String title;
  final Map<String, dynamic> config;
  final dynamic dataPayload;

  const UIComponentBlueprint({
    required this.id,
    required this.type,
    required this.title,
    this.config = const {},
    this.dataPayload,
  });

  factory UIComponentBlueprint.fromJson(Map<String, dynamic> json) {
    return UIComponentBlueprint(
      id: json['id'] as String? ?? '',
      type: json['type'] as String? ?? '',
      title: json['title'] as String? ?? '',
      config: (json['config'] as Map<String, dynamic>?) ?? {},
      dataPayload: json['data'] ?? json['dataPayload'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'title': title,
        'config': config,
        'dataPayload': dataPayload,
      };
}

class StatGridBlueprint extends UIComponentBlueprint {
  final List<String> metrics;

  const StatGridBlueprint({
    required super.id,
    required super.title,
    this.metrics = const [],
    super.config,
    super.dataPayload,
  }) : super(type: 'stat_grid');

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'metrics': metrics,
      };
}

class ChartBlueprint extends UIComponentBlueprint {
  final String chartType;
  final String dataSource;

  const ChartBlueprint({
    super.id = '',
    super.title = '',
    this.chartType = '',
    this.dataSource = '',
    super.config,
    super.dataPayload,
  }) : super(type: 'chart');

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'chartType': chartType,
        'dataSource': dataSource,
      };
}

class ActivityFeedBlueprint extends UIComponentBlueprint {
  const ActivityFeedBlueprint({
    required super.id,
    required super.title,
    super.config,
    super.dataPayload,
  }) : super(type: 'activity_feed');
}

class ChartDataPoint {
  final String label;
  final double value;
  final String? color;

  const ChartDataPoint({
    required this.label,
    required this.value,
    this.color,
  });

  factory ChartDataPoint.fromJson(Map<String, dynamic> json) {
    return ChartDataPoint(
      label: json['label'] as String? ?? '',
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
      color: json['color'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'label': label,
        'value': value,
        'color': color,
      };
}
