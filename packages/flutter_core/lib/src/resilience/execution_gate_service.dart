// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE Level of impact for an institutional insight or anomaly. Types of events that the Aura Pulse...
// Layer: 01_INFRASTRUCTURE
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Level of impact for an institutional insight or anomaly.
export 'package:primecare_models/src/models/insight_impact.dart';
import 'package:primecare_models/src/models/insight_impact.dart';

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

/// A centralized service for tracking execution flow and enforcing governance boundaries.
class ExecutionGateService {
  /// Records a successful execution gate passage.
  void passGate(
    ExecutionGateCategory category,
    String message, {
    bool silent = false,
    Map<String, dynamic>? metadata,
  }) {
    if (!silent) {
      debugPrint('PASS_GATE [$category]: $message ${metadata ?? ''}');
    }
  }

  /// Alias for passGate used in legacy telemetry flows.
  void track(
    ExecutionGateCategory category,
    String message, {
    Map<String, dynamic>? metadata,
  }) {
    passGate(category, message, metadata: metadata);
  }

  /// Records a failed execution gate and generates diagnostic telemetry.
  void failGate(
    ExecutionGateCategory category,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    debugPrint(
      'FAIL_GATE [$category]: $message ${error ?? ''} ${metadata ?? ''}',
    );
    if (stackTrace != null) {
      debugPrint(stackTrace.toString());
    }
  }
}

/// Global provider for the ExecutionGateService.
final executionGateProvider = Provider<ExecutionGateService>((ref) {
  return ExecutionGateService();
});
