/// A universal blueprint that defines a UI component mapping from data to layout.
abstract class UIComponentBlueprint {
  /// The type of UI component (e.g. 'stat_card_grid', 'data_table').
  final String componentType;

  /// The abstract payload of data.
  final dynamic dataPayload;

  const UIComponentBlueprint({
    required this.componentType,
    required this.dataPayload,
  });
}

/// A blueprint for a grid of KPI/stat cards.
class StatGridBlueprint extends UIComponentBlueprint {
  const StatGridBlueprint({
    required super.dataPayload,
  }) : super(componentType: 'stat_card_grid');
  
  // You can strictly type the payload if desired, but dynamic allows flexible assembly.
}

/// A blueprint for a live operations feed / recent activity.
class ActivityFeedBlueprint extends UIComponentBlueprint {
  const ActivityFeedBlueprint({
    required super.dataPayload,
  }) : super(componentType: 'activity_feed');
}

/// A blueprint for a common layout table.
class DataTableBlueprint extends UIComponentBlueprint {
  const DataTableBlueprint({
    required super.dataPayload,
  }) : super(componentType: 'data_table');
}
