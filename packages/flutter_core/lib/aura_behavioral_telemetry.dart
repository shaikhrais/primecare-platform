// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';

/// Tracks user behavioral interactions with Aura insights and suggestions.
/// This data is used to weight future AI suggestions and prioritize critical mitigations.
class AuraBehavioralTelemetry {
  final Ref _ref;
  final Map<String, int> _interactionCounts = {};
  final List<Map<String, dynamic>> _interactionLogs = [];

  Map<String, dynamic> _governanceContext = {};

  AuraBehavioralTelemetry(this._ref);

  /// Updates the governance context to automatically populate telemetry logs with tenant and module breadcrumbs.
  void updateGovernanceContext({
    required PlatformTenant tenant,
    PlatformModule? module,
    PlatformRole? role,
  }) {
    _governanceContext = {
      'tenantId': tenant.tenantId,
      'tenantName': tenant.name,
      if (module != null) 'moduleId': module.moduleId,
      if (module != null) 'moduleName': module.name,
      if (role != null) 'activeRole': role.name,
    };
  }

  /// Logs a structural event (e.g., screen mount, layout change) for auditing.
  void logStructuralEvent({
    required String route,
    required String eventType,
    Map<String, dynamic> metadata = const {},
  }) {
    final telemetry = _ref.read<ExecutionGateService>(executionGateProvider);

    final log = {
      'route': route,
      'eventType': eventType,
      'timestamp': DateTime.now().toIso8601String(),
      ..._governanceContext,
      ...metadata,
    };

    _interactionLogs.add(log);

    telemetry.passGate(
      ExecutionGateCategory.governance,
      'Structural UI Event Logged',
      metadata: log,
    );
  }

  /// Logs a validation result against a structural blueprint.
  void logValidationResult({
    required String route,
    required bool isCompliant,
    required String details,
  }) {
    final telemetry = _ref.read<ExecutionGateService>(executionGateProvider);

    final log = {
      'route': route,
      'isCompliant': isCompliant,
      'details': details,
      'timestamp': DateTime.now().toIso8601String(),
      ..._governanceContext,
    };

    _interactionLogs.add(log);

    telemetry.passGate(
      ExecutionGateCategory.governance,
      isCompliant
          ? 'Structural Compliance Verified'
          : 'Structural Drift Detected',
      metadata: log,
    );
  }

  /// Logs an interaction with a specific Aura event.
  void logEventInteraction(AuraEvent event, String actionType) {
    final telemetry = _ref.read<ExecutionGateService>(executionGateProvider);

    _interactionCounts[event.type.name] =
        (_interactionCounts[event.type.name] ?? 0) + 1;

    final log = {
      'eventId': event.id,
      'eventType': event.type.name,
      'actionType': actionType,
      'timestamp': DateTime.now().toIso8601String(),
      'isPredictive': event.isPredictive,
      ..._governanceContext,
    };

    _interactionLogs.add(log);

    telemetry.passGate(
      ExecutionGateCategory.aura,
      'Behavioral Interaction Logged',
      metadata: log,
    );
  }

  /// Logs a Quick Access / Shortcut attempt.
  void logQuickAccessAttempt({
    required String shortcutId,
    required String featureId,
    required bool granted,
    required String roleName,
    required double riskScore,
  }) {
    final telemetry = _ref.read<ExecutionGateService>(executionGateProvider);

    final log = {
      'shortcutId': shortcutId,
      'featureId': featureId,
      'granted': granted,
      'roleName': roleName,
      'riskScore': riskScore,
      'timestamp': DateTime.now().toIso8601String(),
      ..._governanceContext,
    };

    _interactionLogs.add(log);

    telemetry.passGate(
      ExecutionGateCategory.governance,
      granted ? 'Quick Access Granted' : 'Quick Access Denied',
      metadata: log,
    );
  }

  /// Logs an interaction with a contextual suggestion.
  void logSuggestionClick(String suggestion, String? context) {
    final telemetry = _ref.read<ExecutionGateService>(executionGateProvider);

    final log = {
      'suggestion': suggestion,
      'context': context,
      'actionType': 'suggestion_click',
      'timestamp': DateTime.now().toIso8601String(),
      ..._governanceContext,
    };

    _interactionLogs.add(log);

    telemetry.passGate(
      ExecutionGateCategory.aura,
      'Contextual Suggestion Click Logged',
      metadata: log,
    );
  }

  /// Returns the top interaction types for weighting analysis.
  Map<String, int> get topInteractions => Map.from(_interactionCounts);
}

final auraBehavioralTelemetryProvider = Provider<AuraBehavioralTelemetry>((
  ref,
) {
  return AuraBehavioralTelemetry(ref);
});
