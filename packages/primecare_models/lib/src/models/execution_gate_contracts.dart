import 'insight_impact.dart';

/// Types of events that the Aura Pulse service can emit.
enum AuraEventType {
  stable,
  occupancySpike,
  revenueDip,
  workforceEfficiency,
  predictedStaffingGap,
  predictedBudgetOverrun,
  architecturalDrift,
  hydrationMetrics,
}

/// Represents a structured event emitted by the Aura Intelligence system.
class AuraEvent {
  final String id;
  final AuraEventType type;
  final String title;
  final String description;
  final InsightImpact impact;
  final DateTime timestamp;
  final bool isPredictive;
  final Map<String, dynamic>? metadata;

  const AuraEvent({
    required this.id,
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

/// Categories for telemetry and auditing gates.
enum ExecutionGateCategory {
  auth,
  database,
  network,
  ui,
  intelligence,
  auraEngine,
  aura,
  governance,
  metricsLayer,
  scheduler,
  navigationLayer,
  resilience,
  structuralIntegrity,
  domainApi,
  storage,
}
