import 'base_entity.dart';

// Governance - Category: model | Purpose: Layer: 02_MODELS_FOUNDATION
// Layer: 02_MODELS_FOUNDATION
enum AuraActionType { navigate, filter, summarize, snooze, reassign, unknown }

class AuraAction {
  final AuraActionType type;
  final String target; // e.g. 'revenue_report', 'ward_a'
  final Map<String, dynamic>? params;

  const AuraAction({required this.type, required this.target, this.params});
}

class AuraIntent extends BaseEntity<String> {
  final String rawQuery;
  final String title;
  final String description;
  final List<AuraAction> actions;
  final double confidence;

  const AuraIntent({
    required super.id,
    required this.rawQuery,
    required this.title,
    required this.description,
    required this.actions,
    this.confidence = 1.0,
  });
}
