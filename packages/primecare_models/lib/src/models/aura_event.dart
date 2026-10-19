import 'base_entity.dart';
import 'aura_event_type.dart';
import 'insight_impact.dart';

/// Represents a structured event emitted by the Aura Intelligence system.
class AuraEvent extends BaseEntity<String> {
  final AuraEventType type;
  final String title;
  final String description;
  final InsightImpact impact;
  final DateTime timestamp;
  final bool isPredictive;
  final Map<String, dynamic>? metadata;

  const AuraEvent({
    required super.id,
    required this.type,
    required this.title,
    required this.description,
    required this.impact,
    required this.timestamp,
    this.isPredictive = false,
    this.metadata,
  });

  factory AuraEvent.stable() => AuraEvent(
    id: 'stable',
    type: AuraEventType.stable,
    title: 'aura.events.stable_title',
    description: 'aura.events.stable_desc',
    impact: InsightImpact.info,
    timestamp: DateTime.now(),
  );
}
