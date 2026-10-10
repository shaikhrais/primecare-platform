part of '../../resilience/execution_gate_service.dart';

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
