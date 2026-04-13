import 'package:primecare_core/primecare_core.dart';

enum AuraEventType {
  occupancySpike,
  revenueDip,
  systemAlert,
  workforceEfficiency,
  stableheartbeat,
}

class AuraEvent {
  final String id;
  final AuraEventType type;
  final String title;
  final String description;
  final InsightImpact impact;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  AuraEvent({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.impact,
    required this.timestamp,
    this.metadata,
  });

  factory AuraEvent.stable() {
    return AuraEvent(
      id: 'stable_${DateTime.now().millisecondsSinceEpoch}',
      type: AuraEventType.stableheartbeat,
      title: 'System Stable',
      description: 'Institutional heartbeat is nominal.',
      impact: InsightImpact.info,
      timestamp: DateTime.now(),
    );
  }
}
